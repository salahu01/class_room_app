import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:students_details_online/services/response_status.dart';

import '../model/chart_model.dart';
import '../model/student_model.dart';
import '../services/student_services.dart';

class StudentViewModel extends ChangeNotifier {

  
  bool _networkError = false ;
  bool _loading = false;
  bool _emptyData = false;
  List<StudentModel> _studentListModel=[];
  List<StudentModel>? _searchStudentListModel;
  StudentModel? _selectedStudent;
  final List<PerfomanceData> _chartData = [];

  bool get networkError => _networkError ;
  bool get loading => _loading;
  bool get emptyData => _emptyData;
  List<StudentModel> get studentListModel => _studentListModel;
  List<StudentModel>? get searchStudentListModel => _searchStudentListModel;
  StudentModel? get selectedStudent => _selectedStudent;
  List<PerfomanceData>? get chartData => _chartData;

  StudentViewModel() {
    getStudents();
  }

  setLoading(bool loading) {
    _loading = loading;
    notifyListeners();
  }

  setNetwork(bool network){
    _networkError = network ;
    setLoading(false);
  }

  _setStudentListModel(List<StudentModel> studentListModel) {
    _studentListModel.clear();
    _studentListModel = studentListModel;
    setEmptyData(false); 
  }

  setEmptyData(bool empty){
    _emptyData = empty ; 
    setNetwork(false);
  }

  setSelectedStudent(StudentModel studentModel) {
    _selectedStudent = studentModel;
    notifyListeners();
  }

  setStudent(StudentModel studentModel){
    _studentListModel.add(studentModel);
    setEmptyData(false);
  }


  updateStudent(StudentModel studentModel,int index){
    removeStudent(index);
    _studentListModel.insert(index, studentModel);
    notifyListeners();
  }


  removeStudent(index){
    _studentListModel.removeAt(index);
    notifyListeners();
  }


  setSelectedStudentChartData(StudentModel studentModel) {
    List<PerfomanceData> chartdata = [
      PerfomanceData(DateTime(2022), studentModel.perfomance!.last),
      PerfomanceData(DateTime(2021), studentModel.perfomance!.second),
      PerfomanceData(DateTime(2020), studentModel.perfomance!.third),
      PerfomanceData(DateTime(2019), studentModel.perfomance!.fourth),
      PerfomanceData(DateTime(2018), studentModel.perfomance!.fifth)
    ];
    _chartData.clear();
    _chartData.addAll(chartdata);
  }

  getStudents() async {

    setLoading(true);
    
    var response = await StudentServices.getStudents();

    if (response is Success) {
      _setStudentListModel(response.response as List<StudentModel>); 
      log('..................bla');
    }

    if (response is Empty) {
       setEmptyData(true);
       log('.................empty');
    }

    if (response is NetworkError) {
      setNetwork(true);
    }

    if (response is Failure) {
    }

  }

  serachStudets(String name){

    _searchStudentListModel = _studentListModel.where((u) => (u.name!.toLowerCase().contains(name.toLowerCase()))).toList();

    notifyListeners();
    
  }

}
