import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:students_details_online/components/common/custom_image.dart';
import 'package:students_details_online/components/student/detail_writer.dart';
import 'package:students_details_online/utils/theme.dart';
import 'package:students_details_online/view_model/crud_student_view_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../model/chart_model.dart';
import '../../model/student_model.dart';
import '../../utils/navigation_utils.dart';
import '../../view_model/students_view_model.dart';

class SelectedStudentDetails extends StatelessWidget {
  const SelectedStudentDetails({Key? key,required this.index}) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    StudentViewModel userViewModel = context.watch<StudentViewModel>();
    CrudStudentViewModel addStudentViewModel = context.watch<CrudStudentViewModel>();
    StudentModel? studentModel = userViewModel.selectedStudent;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ThemeColors.white,
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
            studentModel?.name ?? 'Can\'t find',
            style: TextStyle(
                color: ThemeColors.dark,
                fontSize: 23.sp,
                fontWeight: FontWeight.w800),
          ),
        ),
        actions: [
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(13.r),
              child: CustomImage(image: studentModel?.image)
            ),
          ),
          SizedBox(width: 15.w)
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 25.h),
            Text(
              'Last 5 Years Perfomance',
              style: TextStyle(
                  decoration: TextDecoration.underline,
                  decorationStyle: TextDecorationStyle.solid,
                  decorationColor: ThemeColors.dark,
                  shadows: const [
                    BoxShadow(offset: Offset(0, -5), color: ThemeColors.dark)
                  ],
                  decorationThickness: 2.sp,
                  fontSize: 18.sp,
                  color: Colors.transparent,
                  fontWeight: FontWeight.w900),
            ),
            SizedBox(height: 25.h),
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                height: 300.w,
                width: 300.w,
                child: SfCartesianChart(
                    primaryXAxis: DateTimeAxis(),
                    series: <ChartSeries>[
                      LineSeries<PerfomanceData, DateTime>(
                          dataSource: userViewModel.chartData!,
                          xValueMapper: (PerfomanceData perfomanceData, _) =>
                              perfomanceData.year,
                          yValueMapper: (PerfomanceData perfomanceData, _) =>
                              perfomanceData.perfomance)
                    ]),
              ),
            ),
            DetailWriter(label: 'Current Status', value: studentModel!.status!),
            DetailWriter(label: 'Course', value: studentModel.course!),
            DetailWriter(label: 'Batch', value: studentModel.batch!),
            DetailWriter(label: 'Department', value: studentModel.department!),
            DetailWriter(label: 'Date of Birth', value: studentModel.dob!),
            DetailWriter(label: 'Email', value: studentModel.email!),
            DetailWriter(label: 'Phone', value: studentModel.phone!),
            DetailWriter(label: 'Year', value: studentModel.year!),
            DetailWriter(label: 'Parent Name', value: studentModel.parent!),
            DetailWriter(label: 'Parent Relation', value: studentModel.parentRelation!),
            DetailWriter(label: 'Parent Phone', value: studentModel.parentPhone),
            SizedBox(height: 60.h)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.small(
        onPressed: () {
          addStudentViewModel.setUpdateValues(studentModel);
          openAddStudent(context,'Update Student',studentModel,index);
        },
        backgroundColor: ThemeColors.primary,
        child: Icon(
          Icons.update,
          size: 35.sp,
          color: ThemeColors.dark,
        ),
      ),
    );
  }
}
