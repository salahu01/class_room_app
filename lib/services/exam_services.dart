import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:students_details_online/model/exam_model.dart';

import 'response_status.dart';

class ExamServices extends ChangeNotifier{

    static getExams() async {

    String userId = FirebaseAuth.instance.currentUser!.uid;

    final response = FirebaseFirestore.instance.collection('examsData').doc(userId);

    try {
      final networkStatus = await InternetConnectionChecker().hasConnection;

      if (networkStatus == false) {

        return NetworkError(errorResponse: false);

      }

      final body = await response.get();


      if (body.data()?['exams'].toString() == [].toString()) {

        return Empty(response: 'Empty');

      } else {
        
        return Success(response: examsListFromJson(body.data()?['exams']));

      }

    } catch (e) {

      if (e.toString() == 'type \'String\' is not a subtype of type \'List<dynamic>\'' || e.toString() == 'type \'Null\' is not a subtype of type \'List<dynamic>\'' ) {

        return Empty(response: 'Empty');

      }

      log('............exception =   $e');

      return Failure(errorResponse: e);
      
    }
    
  }

  static addExams(json) async {

    String userId = FirebaseAuth.instance.currentUser!.uid;

    final response = FirebaseFirestore.instance.collection('examsData').doc(userId);

    try {

      final networkStatus = await InternetConnectionChecker().hasConnection;

      if (networkStatus == false) {

        return NetworkError(errorResponse: 'network Error');

      }

      await response.update({'exams': json});

      return Success(response: 'success');

    } catch (e) {

      log('............exception =   $e');

      return Failure(errorResponse: e);

    }

  }

}