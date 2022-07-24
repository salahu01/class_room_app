import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:students_details_online/view_model/students_view_model.dart';

import '../../utils/theme.dart';

class NoNetwork extends StatelessWidget {
  const NoNetwork({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    StudentViewModel studentViewModel = context.watch<StudentViewModel>();
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'No Network !',
            style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w800,
                color: ThemeColors.dark),
          ),
          SizedBox(height: 10.h),
          TextButton(
            onPressed: () {
              studentViewModel.getStudents();
            },
            style: ButtonStyle(
                fixedSize: MaterialStateProperty.all<Size>(Size(100.w, 30.h)),
                shape: MaterialStateProperty.all<OutlinedBorder>(
                    const StadiumBorder()),
                backgroundColor:
                    MaterialStateProperty.all(ThemeColors.primary)),
            child: Text(
              'Refresh',
              style: TextStyle(
                color: ThemeColors.dark,
                fontSize: 18.sp,
                fontWeight: FontWeight.w800,
              ),
            ))
        ],
      ),
    );
  }
}