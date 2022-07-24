import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/theme.dart';

class EmptyExam extends StatelessWidget {
  const EmptyExam({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 220.w,
      child: Card(
        margin:
            EdgeInsets.only(left: 10.r, right: 10.r, top: 13.r, bottom: 20.r),
        borderOnForeground: true,
        color: ThemeColors.primary,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.add,
              color: ThemeColors.light,
              size: 130.sp,
            ),
                Text('Add Exam',
                style: TextStyle(
                  color: ThemeColors.dark,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w800
                ),
                )
          ],
        )
      ),
    );
  }
}