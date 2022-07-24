import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:students_details_online/model/exam_model.dart';

import '../services/exam_services.dart';
import '../services/response_status.dart';

class ExamsViewModel extends ChangeNotifier {
  bool _networkError = false;
  bool _loading = false;
  bool _emptyData = false;
  final List<ExamModel> _examsListModel = [];
  ExamModel? _selectedExamModel;

  bool get networkError => _networkError;
  bool get loading => _loading;
  bool get emptyData => _emptyData;
  List<ExamModel> get examsListModel => _examsListModel;
  ExamModel? get selectedExamModel => _selectedExamModel;

  ExamsViewModel() {
    getAllExams();
  }

  setEmptyData(bool empty) {
    _emptyData = empty;
    setNetwork(false);
  }

  setLoading(bool loading) {
    _loading = loading;
    notifyListeners();
  }

  setNetwork(bool network) {
    _networkError = network;
    setLoading(false);
  }

  setSelectedExam(int index) {
    _selectedExamModel = _examsListModel[index];
  }

  _setExamsListModel(List<ExamModel> examListModel) {
    _examsListModel.clear();
    _examsListModel.addAll(examListModel);
    setEmptyData(false);
    notifyListeners();
  }

  setExam(ExamModel examModel, context) async {
    _examsListModel.add(examModel);
    setEmptyData(false);
    notifyListeners();

    var json = examsListToJson(_examsListModel);

    Object response = await ExamServices.addExams(json);

    if (response is Success) {
      Navigator.pop(context);
    }
  }

  getAllExams() async {
    setLoading(true);

    var response = await ExamServices.getExams();

    if (response is Success) {
      _setExamsListModel(response.response as List<ExamModel>);

      log('..................Success');
    }

    if (response is Empty) {
      setEmptyData(true);

      log('.................empty');
    }

    if (response is NetworkError) {
      setNetwork(true);
    }

    if (response is Failure) {}
  }
}
