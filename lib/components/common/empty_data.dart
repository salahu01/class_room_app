import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/theme.dart';

class EmptyData extends StatelessWidget {
  const EmptyData({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        title,
        style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w800,
            color: ThemeColors.dark),
      ),
    );
  }
}
