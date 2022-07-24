import 'package:flutter/material.dart';
import 'package:students_details_online/model/student_model.dart';
import 'package:students_details_online/view/exam/add_exam.dart';
import 'package:students_details_online/view/exam/subect_details.dart';
import 'package:students_details_online/view/student/add_new_student.dart';
import 'package:students_details_online/view/exam/all_exams.dart';
import 'package:students_details_online/view/auth/forget_password.dart';
import 'package:students_details_online/view/auth/log_in.dart';
import 'package:students_details_online/view/user/edit_user_screen.dart';
import 'package:students_details_online/view/exam/exam_details_view.dart';
import 'package:students_details_online/view/home_screen.dart';

import '../view/auth/sign_in.dart';
import '../view/student/selected_student_details.dart';
import '../view/student/sudents_details.dart';
import '../view/user/user_details_screen.dart';

void openStudentdDetails(context) {
  Navigator.push(context,
      MaterialPageRoute(builder: (context) => const StudentsDetails()));
}

void openSelectedStudentdDetails(context, index) {
  Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => SelectedStudentDetails(index: index)));
}

void openAddStudent(context, title, StudentModel? studentModel, int? index) {
  Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => AddNewStudent(
              title: title, studentModel: studentModel, index: index)));
}

void openSignInScreen(context) {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => const SignInScreen()));
}

void closeScreens(context) {
  Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LogInScreen()),
      (route) => false);
}

void openHomeScreen(context) {
  
  Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const HomeScreen()),
      (route) => false);
}

void openForgetPasswordScreen(context) {
  Navigator.push(context,
      MaterialPageRoute(builder: (context) => const ForgetPasswordScreen()));
}

void openUserDetails(context) {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => const UserDetails()));
}

void openEditUserDetails(context) {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => const EditUserDetails()));
}

void openAllExams(context) {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => const AllExams()));
}

void openExamDetails(context) {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => const ExamDetails()));
}

void openAddExamDetails(context) {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => const AddExam()));
}

void openSubjectDetails(context,String subjectName) {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => SubjectDetails(subjectName: subjectName)));
}