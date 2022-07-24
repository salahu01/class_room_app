import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/theme.dart';

class UserDetailModel extends StatelessWidget {
  const UserDetailModel({Key? key, required this.defualtValue,required this.label,required this.spacing, this.data})
      : super(key: key);
  final String? data;
  final String defualtValue;
  final String label;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 17.h, horizontal: 25.w),
      child: Stack(
        children: [
          Row(
            children: [
              Text(
                label,
                style: TextStyle(
                  color: ThemeColors.dark,
                  fontWeight: FontWeight.w800,
                  fontSize: 15.sp,
                ),
              ),
            ],
          ),
          Row(
            children: [
              SizedBox(width: spacing),
              Text(
                "  :  ${data ?? defualtValue}"  ,
                style: TextStyle(
                  color: ThemeColors.dark,
                  fontWeight: FontWeight.w800,
                  fontSize: 15.sp,
                ),
              ),
              const Spacer(),
            ],
          ),
        ],
      ),
    );
  }
}
