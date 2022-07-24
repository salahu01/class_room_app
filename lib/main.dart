import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:students_details_online/view/auth/log_in.dart';
import 'package:students_details_online/view/home_screen.dart';
import 'package:students_details_online/view_model/add_exam_model_view.dart';
import 'package:students_details_online/view_model/auth_navigation.dart';
import 'package:students_details_online/view_model/auth_view_model.dart';
import 'package:students_details_online/view_model/crud_student_view_model.dart';
import 'package:students_details_online/view_model/exams_view_model.dart';
import 'package:students_details_online/view_model/subject_view_model.dart';

import 'view_model/students_view_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => SubjectViewModel()),
          ChangeNotifierProvider(create: (_) => ExamsViewModel()),
          ChangeNotifierProvider(create: (_) => AddExamModelView()),
          ChangeNotifierProvider(create: (_) => AuthNavigationViewModel()),
          ChangeNotifierProvider(create: (_) => AuthViewModel()),
          ChangeNotifierProvider(create: (_) => StudentViewModel()),
          ChangeNotifierProvider(create: (_) => CrudStudentViewModel())
        ],
        child: ScreenUtilInit(
          builder: (context, child) => MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Consumer<AuthNavigationViewModel>(
              builder: (context, myType, child) {
                return myType.user == null
                    ? const LogInScreen()
                    : const HomeScreen();
              },
            ),
          ),
          designSize: const Size(357.6470655113494, 758.0392298612263),
        ));
  }
}
