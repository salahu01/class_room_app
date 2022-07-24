import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:students_details_online/view_model/crud_student_view_model.dart';
import 'package:students_details_online/view_model/students_view_model.dart';

import '../../model/student_model.dart';
import '../../utils/theme.dart';

class StudentTile extends StatelessWidget {
  const StudentTile({Key? key, required this.index, required this.studentModel}) : super(key: key);
  final int index;
  final StudentModel studentModel;
  @override
  Widget build(BuildContext context) {
    CrudStudentViewModel crudStudentViewModel = context.watch<CrudStudentViewModel>();
    StudentViewModel studentViewModel = context.watch<StudentViewModel>();
    return Padding(
      padding: EdgeInsets.only(bottom: 15.r, left: 15.r, right: 15.r),
      child: Stack(
        children: [
          Slidable(
            endActionPane: ActionPane(motion: const ScrollMotion(), children: [
              SlidableAction(
                onPressed: (_) async{
                  await crudStudentViewModel.deleteStudent(studentViewModel, index);
                  log('....................aksjhsadjsadjhsadkjhjs');
                },
                borderRadius: BorderRadius.circular(20.r),
                icon: Icons.delete,
              )
            ]),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15.r),
              child: ColoredBox(
                color: ThemeColors.primary,
                child: SizedBox(
                  height: 100.h,
                  child: ListTile(
                    title: Text('          ${studentModel.name}',
                        style: TextStyle(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.w700,
                          color: ThemeColors.dark,
                        )),
                    trailing: Padding(
                      padding: EdgeInsets.only(top: 20.r),
                      child: Text('${studentModel.status}',
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w700,
                            color: ThemeColors.dark,
                          )),
                    ),
                  ),
                ),
              ),
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(200.r),
              topLeft: Radius.circular(50.r),
            ),
            child: SizedBox(
              width: 60.w,
              height: 60.w,
              child: ColoredBox(
                color: ThemeColors.dark,
                child: Padding(
                  padding: EdgeInsets.only(top: 14.r, left: 7.r),
                  child: Text('# ${index + 1} ',
                      style: TextStyle(
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w900,
                        color: ThemeColors.white,
                      )),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 70.r, right: 15.r),
            child: Align(
              alignment: Alignment.bottomRight,
              child: Text('Rating  :  ${studentModel.rating} / 5',
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w700,
                    color: ThemeColors.dark,
                  )),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 70.r, left: 15.r),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text('${studentModel.course}   ${studentModel.department}',
                  style: TextStyle(
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w800,
                    color: ThemeColors.dark,
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
