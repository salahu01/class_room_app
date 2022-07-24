import 'package:flutter/widgets.dart';

class SubjectViewModel extends ChangeNotifier{

  bool _showAddStudent = false;

  bool get showAddStudent => _showAddStudent ;

  setShowAddStudent(bool showAddStudent){
    _showAddStudent = showAddStudent;
    notifyListeners();
  }

}