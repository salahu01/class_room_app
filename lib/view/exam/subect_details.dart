import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:students_details_online/components/exam/add_student_to_exam.dart';
import 'package:students_details_online/components/exam/over_all_card.dart';
import 'package:students_details_online/view_model/subject_view_model.dart';

import '../../utils/theme.dart';

class SubjectDetails extends StatelessWidget {
  const SubjectDetails({Key? key,required this.subjectName}): super(key: key);
  final String subjectName;

  @override
  Widget build(BuildContext context) {
    SubjectViewModel subjectViewModel = context.watch<SubjectViewModel>();
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 60.w,
        toolbarHeight: 80.h,
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: ThemeColors.white,
          statusBarIconBrightness: Brightness.dark,
        ),
        leading: Row(
          children: [
            const Spacer(),
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_ios_new_sharp,
                  color: ThemeColors.dark,
                  size: 30.sp,
                  shadows: const [
                    BoxShadow(offset: Offset(0, 2), color: ThemeColors.dark)
                  ],
                )),
            const Spacer(),
          ],
        ),
        title: Center(
          child: Text(
             subjectName,
            style: TextStyle(
                color: ThemeColors.dark,
                fontSize: 23.sp,
                fontWeight: FontWeight.w800),
          ),
        ),
        actions: [
          SizedBox(width: 50.w)
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(15.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10.h),
                  Text(
                    'OverAll',
                    style: TextStyle(
                        color: ThemeColors.dark,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w900),
                  ),
                  SizedBox(height: 10.h),
                  const OverAllCard(value: '56 %', title: 'Average Score'),
                  const OverAllCard(value: '97 %', title: 'Maximum Score'),
                  const OverAllCard(value: '27 %', title: 'Minimum Score'),
                  SizedBox(height: 10.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Students Scores',
                        style: TextStyle(
                            color: ThemeColors.dark,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w900),
                      ),
                  IconButton(
                  onPressed: () {
                    subjectViewModel.setShowAddStudent(true);
                  },
                  icon: Icon(
                    Icons.add,
                    color: ThemeColors.dark,
                    size: 30.sp,
                    shadows: const [
                      BoxShadow(offset: Offset(0, 2), color: ThemeColors.dark)
                    ],
                  ))
                    ],
                  ),
                  SizedBox(height: 15.h),
                ],
              ),
            ),
          ),
          Visibility(
            visible: subjectViewModel.showAddStudent,
            child: const Align(
              alignment: Alignment.bottomCenter,
              child: AddStudentCard())
            )
        ],
      ),
    );
  }
}
