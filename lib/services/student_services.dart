import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:students_details_online/services/response_status.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../model/student_model.dart';

class StudentServices {

  static getStudents() async {

    String userId = FirebaseAuth.instance.currentUser!.uid;

    final response = FirebaseFirestore.instance.collection('usersData').doc(userId);

    try {
      final networkStatus = await InternetConnectionChecker().hasConnection;

      if (networkStatus == false) {

        return NetworkError(errorResponse: false);

      }

      final body = await response.get();


      if (body.data()?['students'].toString() == [].toString()) {

        return Empty(response: 'Empty');

      } else {

        return Success(response: studentsListFromJson(body.data()?['students']));

      }
    } catch (e) {

      if (e.toString() == 'type \'String\' is not a subtype of type \'List<dynamic>\'' ) {

        return Empty(response: 'Empty');

      }

      log('............exception =   $e');

      return Failure(errorResponse: e);
      
    }
  }

  static addStudent(json) async {

    String userId = FirebaseAuth.instance.currentUser!.uid;

    final response = FirebaseFirestore.instance.collection('usersData').doc(userId);

    try {

      final networkStatus = await InternetConnectionChecker().hasConnection;

      if (networkStatus == false) {

        return NetworkError(errorResponse: 'network Error');
      }

      await response.update({'students': json});

      return Success(response: 'success');

    } catch (e) {

      log('............exception =   $e');

      return Failure(errorResponse: e);
    }
  }

  static addImage({required File file,required String path }) async {

    try {
      final networkStatus = await InternetConnectionChecker().hasConnection;

      if (networkStatus == false) {
        return NetworkError(errorResponse: 'network Error');
      }

      
      final ref = FirebaseStorage.instance.ref().child(path);
      final uploadTask = ref.putFile(file);
      final snapshot = await uploadTask;
      String? imageUrl = await snapshot.ref.getDownloadURL();

      if (imageUrl.isNotEmpty) {

        return Success(response: imageUrl);

      }
      if (imageUrl.isEmpty) {
        return Failure(errorResponse: 'can\'t uload');
      }

      if (imageUrl.isEmpty) {
        return Failure(errorResponse: 'can\'t uload');
      }

    } catch (e) {

      log('............exception =   $e');

      return Failure(errorResponse: e);
    }

  }

}
