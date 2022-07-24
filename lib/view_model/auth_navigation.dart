import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:students_details_online/model/user_model.dart';
import 'package:students_details_online/services/auth_service.dart';
import 'package:students_details_online/services/response_status.dart';
import 'package:students_details_online/services/student_services.dart';
import 'package:students_details_online/utils/navigation_utils.dart';

class AuthNavigationViewModel extends ChangeNotifier {

  User? _user ;

  UserClient? _userClient ;

  String? _name ;
  String? _phone ;
  String? _institute ;
  String? _qualification ;
  XFile? _image ;
  String? _url ;  
  bool _loading = false ;  

  String? get name => _name;
  String? get phone => _phone;
  String? get institute => _institute;
  String? get qualification => _qualification;
  bool get loading => _loading ;

  User? get user => _user ;

  UserClient? get userClient => _userClient ;

  setLoading(bool loading){
    _loading = loading;
    notifyListeners();
  }

  _userFromFirebase() async{ 
    FirebaseAuth.instance.authStateChanges().listen((user) async {
      _user = user;
      await _setUserClient(_user?.uid);
      notifyListeners();
    });
  }

  AuthNavigationViewModel(){

    _userFromFirebase();

  }

  _setUserClient(String? userUid) async {

    if(userUid != null){

     _userClient = await AuthServices.getUserDatas(userUid);

    }
    
  }

   updateUserClient(context) async {

    setLoading(true);

    if(_image != null){

      String userId = FirebaseAuth.instance.currentUser!.uid;

      final path = '$userId/user_datas/${_image!.name}';

      final file = File(_image!.path);

      Object response = await StudentServices.addImage(file: file , path: path);

      if (response is Success) {

        _url  = response.response as String;

      }

    }

     _userClient = await AuthServices.setUserDatas( _user!.uid , _name ?? userClient!.name ?? '',_institute ?? userClient!.instituteName ?? '', _phone ?? userClient!.phone ?? '' , _qualification??userClient!.qualification ?? '' , _url ?? '');

     setLoading(false);
     
     Navigator.pop(context);

   }


  logOutUser(context) async{

    final response = await AuthServices.logOutUser();

    if (response is AuthSuccess) {

      closeScreens(context);


    }

  }

  setUserDetails({required String label, required String text}) {

    if (label == 'Name') {
      _name = text;
    }
    if (label == 'Phone') {
      _phone= text;
    }
    if (label == 'Institue') {
      _institute = text;
    }
    if (label == 'Qualification') {
      _qualification = text;
    }

  }
  
    setImage(String source) async{

    final ImagePicker picker = ImagePicker();

    if (source == 'gallery') {
      try {
       _image = await picker.pickImage(source: ImageSource.gallery);  
      }on PlatformException catch (e) {
        log('.............Exception=$e');
      }
    }else{
      try {
        _image = await picker.pickImage(source: ImageSource.camera); 
      }on PlatformException catch (e) {
        log('.............Exception=$e');
      }
      
    }

  }

}
