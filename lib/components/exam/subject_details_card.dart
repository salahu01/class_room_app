import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:students_details_online/utils/navigation_utils.dart';
import 'package:students_details_online/view_model/exams_view_model.dart';

import '../../utils/theme.dart';

class SubjectDetailsCard extends StatelessWidget {
  const SubjectDetailsCard(
      {Key? key, required this.index, required this.examsViewModel}): super(key: key);
  final int index;
  final ExamsViewModel examsViewModel;
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
                      examsViewModel.selectedExamModel?.subjectsList[index],
                      style: TextStyle(
                          color: ThemeColors.dark,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w900),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10.r),
                      child: InkWell(
                        overlayColor: MaterialStateProperty.all<Color>(Colors.transparent),
                        onTap: ()=>openSubjectDetails(context,examsViewModel.selectedExamModel?.subjectsList[index]),
                        child: Icon(
                              Icons.arrow_forward_ios_sharp,
                              size: 25.sp,
                              shadows: const [
                                BoxShadow(
                                  offset: Offset(0, -1)
                                )
                              ],
                            ),
                      ),
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
