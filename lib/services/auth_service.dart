import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:students_details_online/services/response_status.dart';

import '../model/user_model.dart';

class AuthServices {

  static Future<Object> createUser(String email, String password,String name) async {
    try {

      final networkStatus = await InternetConnectionChecker().hasConnection;

      if (networkStatus == false) {

        return NetworkError(errorResponse: 'network Error');

      }

      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      if (userCredential.user!.uid.isNotEmpty) {
      FirebaseFirestore.instance.collection('UserInformation').doc(userCredential.user!.uid).set({
      "name": name,
      "email": email,
      });
      FirebaseFirestore.instance.collection('usersData').doc(userCredential.user!.uid).set({'students':''});
      FirebaseFirestore.instance.collection('examsData').doc(userCredential.user!.uid).set({'exams':''});
      }
      return AuthSuccess(response: userCredential,user: UserClient(
        email: email,
        name: name,
      ));

    } catch (e) {
      log('..............Exception $e');
      return AuthFailed(response: e);
    }
  }

  static Future<Object>loginUser(String email, String password) async {
    try {

      final networkStatus = await InternetConnectionChecker().hasConnection;

      if (networkStatus == false) {
        return NetworkError(errorResponse: 'network Error');
      }

      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);

      final user = await FirebaseFirestore.instance.collection('UserInformation').doc(userCredential.user!.uid).get();

      return AuthSuccess(response: userCredential,user: UserClient(
        email: email,
        name: user.data()?['name'],
      ));

    } catch (e) {

      log('..............Exception $e');

      return AuthFailed(response: e);

    }

  }

  static Future<Object>logOutUser() async {

    try {

      final networkStatus = await InternetConnectionChecker().hasConnection;

      if (networkStatus == false) {

        return NetworkError(errorResponse: 'network Error');
        
      }


      await FirebaseAuth.instance.signOut();

      return AuthSuccess(response: 'LogOut_Success');

    } catch (e) {

      log('..............Exception $e');

      return AuthFailed(response: e);

    }

  }

  static getUserDatas(String userUid)async{
    
    final user = await FirebaseFirestore.instance.collection('UserInformation').doc(userUid).get();

    return UserClient(

        email: user.data()?['email'],

        name: user.data()?['name'],

        instituteName: user.data()?['instituteName'],

        phone: user.data()?['phone'],

        photo: user.data()?['photo'],

        qualification: user.data()?['qualification'],

      );

  }

  static setUserDatas(String userUid , String name ,String instituteName ,String phone ,String qualification, String? url)async{
    
    

    FirebaseFirestore.instance.collection('UserInformation').doc(userUid).update({

      "name": name,

      'instituteName': instituteName,

      'phone' : phone ,

      'qualification' : qualification ,

      'photo'  :  url ?? '',
      
      });

    final user = await FirebaseFirestore.instance.collection('UserInformation').doc(userUid).get();

    return UserClient(

        email:user.data()?['email'] ,

        name: user.data()?['name'],

        instituteName: user.data()?['instituteName'],

        phone: user.data()?['phone'],

        photo: user.data()?['photo'],

        qualification: user.data()?['qualification'],

      );

  }

}
