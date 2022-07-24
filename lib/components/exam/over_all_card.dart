import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/theme.dart';

class OverAllCard extends StatelessWidget {
  const OverAllCard({Key? key, required this.value, required this.title})
      : super(key: key);
  final String value;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h, top: 8.h),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.r),
        child: SizedBox(
          width: double.maxFinite,
          height: 50.h,
          child: ColoredBox(
            color: ThemeColors.primary,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 15.r),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                          color: ThemeColors.dark,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w900),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10.r),
                      child: Text(
                        value,
                        style: TextStyle(
                          color: ThemeColors.dark,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w800
                        ),
                      )
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}