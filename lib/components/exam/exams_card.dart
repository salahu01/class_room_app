import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/theme.dart';

class ExamsCardModel extends StatelessWidget {
  const ExamsCardModel({Key? key,required this.title}) : super(key: key);
  final String title;

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
        child: Stack(
          children: [
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 20.r, top: 10.h),
                    child: Text(
                      title,
                      style: TextStyle(
                          color: ThemeColors.dark,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w900),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(left: 20.r, bottom: 12.h, right: 20.r),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Average Mark',
                          style: TextStyle(
                              color: ThemeColors.dark,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w700),
                        ),
                        Text(
                          '56',
                          style: TextStyle(
                              color: ThemeColors.dark,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w900),
                        ),
                      ],
                    ),
                  ),
                ]),
            Center(
              child: Icon(
                Icons.equalizer_sharp,
                color: ThemeColors.light,
                size: 150.sp,
              ),
            )
          ],
        ),
      ),
    );
  }
}
