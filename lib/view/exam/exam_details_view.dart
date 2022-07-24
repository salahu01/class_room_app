import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:students_details_online/components/exam/over_all_card.dart';
import 'package:students_details_online/components/exam/subject_details_card.dart';
import 'package:students_details_online/view_model/exams_view_model.dart';

import '../../utils/theme.dart';

class ExamDetails extends StatelessWidget {
  const ExamDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ExamsViewModel examsViewModel = context.watch<ExamsViewModel>();
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
            examsViewModel.selectedExamModel?.examName ?? 'Can\' find',
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
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(15.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 25.h),
              Text(
                'Subjects',
                style: TextStyle(
                    color: ThemeColors.dark,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w900),
              ),
              SizedBox(height: 13.h),
              ListView.builder(
                primary: false,
                shrinkWrap: true,
                itemCount:
                    examsViewModel.selectedExamModel?.subjectsList.length,
                itemBuilder: (BuildContext context, int index) {
                  return SubjectDetailsCard(index: index, examsViewModel: examsViewModel);
                },
              ),
              SizedBox(height: 13.h),
              Text(
                'OverAll',
                style: TextStyle(
                    color: ThemeColors.dark,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w900),
              ),
              const OverAllCard(value: '56 %', title: 'Average Score'),
              const OverAllCard(value: '97 %', title: 'Maximum Score'),
              const OverAllCard(value: '27 %', title: 'Minimum Score'),
            ],
          ),
        ),
      ),
    );
  }
}
