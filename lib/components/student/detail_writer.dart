import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/theme.dart';

class DetailWriter extends StatelessWidget {
  const DetailWriter({Key? key, this.label, this.value}) : super(key: key);

  final String? label;
  final String? value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20.r, right: 20.r, top: 30.r),
      child: Stack(
        children: [
          Row(
            children: [
              const Spacer(),
              Text(
                ' : ',
                style: TextStyle(
                    color: ThemeColors.dark,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w900),
              ),
              const Spacer()
            ],
          ),
          Row(
            children: [
              Text(
                '${label ?? 'no label'} ',
                style: TextStyle(
                    color: ThemeColors.dark,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w900),
              ),
              const Spacer(),
              Text(
                value ?? 'no value',
                style: TextStyle(
                    color: ThemeColors.dark,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w900),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
