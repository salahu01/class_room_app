import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:students_details_online/utils/theme.dart';

class SavingLoading extends StatelessWidget {
  const SavingLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(100, 0, 0, 0),
      body:Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25.r),
          child: SizedBox(
            height: 100.h,
            width: 290.w,
            child: ColoredBox(color: ThemeColors.primary,
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.r),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Saving Details ...',
                    style: TextStyle(
                      color: ThemeColors.dark,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w800
                    ),
                    ),
                    SizedBox(
                      height: 28.h,
                      child: const FittedBox(
                        child:  CircularProgressIndicator(
                          color: ThemeColors.dark,
                          strokeWidth: 10,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
            ),
          ),
        )
      )
    );
  }
}
