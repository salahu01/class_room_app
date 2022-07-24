import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:students_details_online/model/exam_model.dart';

class AddExamModelView extends ChangeNotifier {
  
  bool _subjectVisible = false;
  final List<String> _subjects = [];
  String _subjectName = '';
  String _examName = '' ;

  bool get subjectVisible => _subjectVisible ;
  List<String> get subjects => _subjects ;

  setSubjectName(String subjectName) {
    _subjectName = subjectName;
  }

  setExamtName(String examName) {
    _examName = examName;
  }

  addSubject() {
    if (_subjectName.isEmpty || subjects.contains(_subjectName)) {
      return;
    }
    _subjects.add(_subjectName);
    if (_subjects.isNotEmpty) {
      _subjectVisible = true;
    }
    notifyListeners();
  }

  removeSubject(int index) {
    _subjects.removeAt(index);
    if (_subjects.isEmpty) {
      _subjectVisible = false;
    }
    notifyListeners();
  }

  checkValid(){
    if(_examName.isEmpty ||  _subjects.isEmpty){
      log('..................isInValid');
      return isInValid();
    }else{

      log('..................isValid');

     return isValid();
    }

  }

  isValid(){
    return true;
  }

  isInValid(){
    return false;
  }

  createObject(){

    ExamModel examModel = ExamModel(
      examName: _examName,
      subjectsList: _subjects
    );

    return examModel;
  }

}
