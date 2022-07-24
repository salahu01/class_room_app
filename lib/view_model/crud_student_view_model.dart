import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:students_details_online/model/student_model.dart';
import 'package:students_details_online/services/response_status.dart';
import 'package:students_details_online/view_model/students_view_model.dart';

import '../services/student_services.dart';

class CrudStudentViewModel extends ChangeNotifier{

  String _dialogMessage = '';
  String _dialogTitle = '';
  ContentType? _dialogTop = ContentType.failure;
  bool _dialogShow = false;

  bool _loading = false;

  String _name = '';
  String _email = '';
  String _dob = '';
  String _phone = '';
  String _parentName = '';
  String _parentRelation = '';
  String _parentPhone = '';
  XFile? _image;
  String? _url;

  int _lastYear = 1;
  int _secondYear = 1;
  int _thirdYear = 1;
  int _fifthYear = 1;
  int _fourthYear = 1;

  String _department = 'Cs';
  String _course = 'Bsc';
  String _batch = 'first';
  String _year = '2021 - 2024';
  String _status = 'Available';

  bool get dialogShow=> _dialogShow;
  String? get dialogMessage => _dialogMessage;
  String? get dialogTitle => _dialogTitle;
  ContentType? get dialogTop => _dialogTop;

  bool get loading => _loading;

  String? get email => _email;
  String? get name => _name;
  String? get dob => _dob;
  String? get phone => _phone;
  String? get parentName => _parentName;
  String? get parentPhone => _parentPhone;
  String? get parentRelation => _parentRelation;
  XFile? get image => _image;

  int get lastYear => _lastYear;
  int get fourthYear => _fourthYear;
  int get thirdYear => _thirdYear;
  int get secondYear => _secondYear;
  int get fifthYear => _fifthYear;

  String get department => _department;
  String get course => _course;
  String get batch => _batch;
  String get year => _year;
  String get status => _status;

  _setLoading(bool loading) {
    _loading = loading;
    notifyListeners();
  }

  _setDialogs(ContentType dialogTop, String dialogMessage , String dialogTitle){

    _dialogTop = dialogTop;
    _dialogMessage = dialogMessage;
    _dialogTitle = dialogTitle ;

  }

  _callDialog(bool dialogShow){

    _setDialogShow(dialogShow);

    Timer(const Duration(seconds: 2), () => _setDialogShow(false));

  }

  _setDialogShow(bool dialogShow){
    _dialogShow = dialogShow ;
    notifyListeners();
  }

  setStudentDetails({required String label, required String text}) {
    if (label == 'name') {
      _name = text;
    }
    if (label == 'email') {
      _email = text;
    }
    if (label == 'dob') {
      _dob = text;
    }
    if (label == 'phone') {
      _phone = text;
    }
    if (label == 'parent phone') {
      _parentPhone = text;
    }
    if (label == 'parent relation') {
      _parentRelation = text;
    }
    if (label == 'parent name') {
      _parentName = text;
    }
  }

  setStudentRating({int value = 1, String? label}) {
    if (label == 'last') {
      _lastYear = value;
    }
    if (label == 'second') {
      _secondYear = value;
    }
    if (label == 'third') {
      _thirdYear = value;
    }
    if (label == 'fourth') {
      _fourthYear = value;
    }
    if (label == 'fifth') {
      _fifthYear = value;
    }
    notifyListeners();
  }

  setImage(String source) async {
    final ImagePicker picker = ImagePicker();

    if (source == 'gallery') {
      try {
        _image = await picker.pickImage(source: ImageSource.gallery);
      } on PlatformException catch (e) {
        log('.............Exception=$e');
      }
    } else {
      try {
        _image = await picker.pickImage(source: ImageSource.camera);
      } on PlatformException catch (e) {
        log('.............Exception=$e');
      }
    }
  }

  setEducationDetails({String? label, String? value}) {
    if (label == 'department') {
      _department = value!;
    }
    if (label == 'batch') {
      _batch = value!;
    }
    if (label == 'course') {
      _course = value!;
    }
    if (label == 'year') {
      _year = value!;
    }
    if (label == 'status') {
      _status = value!;
    }
    notifyListeners();
  }

  checkValid(StudentViewModel studentViewModel, context, int? index,
      CrudStudentViewModel crudStudentViewModel) async {
    if (_name == '' ||
        _email == '' ||
        _phone == '' ||
        _dob == '' ||
        _parentName == '' ||
        _parentPhone == '' ||
        _parentRelation == '' ||
        _image == null) {
      log('..................isInValid');
      isInValid();
    } else {
      log('..................isValid');
      String updateOrAddcheck = index == null ? 'add' : 'update';
      bool returnValue = await isValid(studentViewModel, updateOrAddcheck, index ?? 0, crudStudentViewModel);

      if (returnValue == true) {
        _url = '';
        _image = null;
        Navigator.pop(context);
      }
    }
  }

  setUrl(String url) {
    _url = url;
  }

  isValid(StudentViewModel studentViewModel, String updateOrAddcheck, int index, CrudStudentViewModel crudStudentViewModel ) async {
    _setLoading(true);

    String userId = FirebaseAuth.instance.currentUser!.uid;

    final path = '$userId/students_images/${_image!.name}';

    final file = File(_image!.path);

    Object response = await StudentServices.addImage(file: file, path: path);

    if (response is NetworkError) {
      _setLoading(false);
      _setDialogs(ContentType.failure, 'Bad Connection ! , Make  sure about connection !' , 'Network Error!');
      _callDialog(true);
      return false;
    }

    if (response is Failure) {
      _setLoading(false);
      _setDialogs(ContentType.warning, 'Can\'t make Action Now ! try Again Later' , 'Warning!');
      _callDialog(true);

      return false;
    }

    if (response is Success) {
      _url = response.response as String;
    }

    StudentModel studentModel = _createObject();

    if (updateOrAddcheck == 'add') {
      studentViewModel.setStudent(studentModel);
    } else {
      studentViewModel.updateStudent(studentModel, index);

      studentViewModel.setSelectedStudent(studentModel);
    }

    var json = studentsListToJson(studentViewModel.studentListModel);

    await StudentServices.addStudent(json);

    _setLoading(false);

    return true;
  }

  isInValid() {
    
    if(_image == null &&
        _name.isNotEmpty &&
        _email.isNotEmpty &&
        _phone.isNotEmpty &&
        _dob.isNotEmpty && 
        _parentName.isNotEmpty &&
        _parentPhone.isNotEmpty &&
        _parentRelation.isNotEmpty
    ){
    _setDialogs(ContentType.failure,'The image is empty , Add image !', 'Oh Snap!');
    _callDialog(true);
    return;
    }

    _setDialogs(ContentType.failure,'The fields are empty , Fill all values', 'Oh Snap!');
    _callDialog(true);
    
  }

  deleteStudent(StudentViewModel studentViewModel, index) async {
    studentViewModel.removeStudent(index);
    if(studentViewModel.studentListModel.isEmpty){
      studentViewModel.setEmptyData(true);
    }
    var json = studentsListToJson(studentViewModel.studentListModel);
    await StudentServices.addStudent(json);
  }

  StudentModel _createObject() {
    return StudentModel(
        batch: _batch,
        course: _course,
        department: _department,
        dob: _dob,
        email: _email,
        name: _name,
        parent: _parentName,
        parentPhone: _parentPhone,
        parentRelation: _parentRelation,
        perfomance: Perfomance(
          fifth: _fifthYear,
          fourth: _fourthYear,
          last: _lastYear,
          second: _secondYear,
          third: _thirdYear,
        ),
        phone: _phone,
        rating: _lastYear.toString(),
        status: _status,
        year: _year,
        image: _url);
  }

  setUpdateValues(StudentModel? studentModel) {
    _lastYear = studentModel?.perfomance?.last ?? 1;
    _secondYear = studentModel?.perfomance?.second ?? 1;
    _thirdYear = studentModel?.perfomance?.third ?? 1;
    _fifthYear = studentModel?.perfomance?.fifth ?? 1;
    _fourthYear = studentModel?.perfomance?.last ?? 1;
    _department = studentModel?.department ?? 'Cs';
    _course = studentModel?.course ?? 'Bsc';
    _batch = studentModel?.batch ?? 'first';
    _year = studentModel?.year ?? '2021 - 2024';
    _status = studentModel?.status ?? 'Available';
    _url = studentModel?.image;
  }
}
