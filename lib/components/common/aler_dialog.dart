import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:students_details_online/utils/theme.dart';
import 'package:students_details_online/view_model/auth_navigation.dart';
import 'package:students_details_online/view_model/crud_student_view_model.dart';

class CustomDialog {
  static customShowDialog(context,CrudStudentViewModel? crudStudentViewModel,AuthNavigationViewModel? authNavigationViewModel) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: ThemeColors.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.r)
            ),
            title: Column(
              children: [
                SizedBox(height: 10.h),
                Text('Select Image Source',
                style: TextStyle(
                  color: ThemeColors.dark,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w800
                ),
                ),
                SizedBox(height: 30.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                  onTap: () {
                    crudStudentViewModel?.setImage('gallery') ?? authNavigationViewModel?.setImage('gallery');
                  },
                  child: Icon(
                    Icons.image,
                    color: ThemeColors.dark,
                    size: 40.sp,
                  )),
              InkWell(
                  onTap: () {
                     crudStudentViewModel?.setImage('camera') ?? authNavigationViewModel?.setImage('camera');
                  },
                  child: Icon(
                    Icons.camera_alt,
                    color: ThemeColors.dark,
                    size: 40.sp,
                  ))
                  ],
                ),
                SizedBox(height: 10.h),
              ],
            ),
          );
        });
  }
}
