import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:students_details_online/view_model/add_exam_model_view.dart';

import '../../utils/theme.dart';

class SubjectModel extends StatelessWidget {
  const SubjectModel({Key? key,required this.index,required this.addExamModelView}) : super(key: key);
  final int index;
  final AddExamModelView addExamModelView ;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: 8.h,
        top: 8.h
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10.r),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.77,
              height: 50.h,
              child: ColoredBox(
                color: ThemeColors.primary,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 15.r),
                    child: Text(
                      addExamModelView.subjects[index],
                      style: TextStyle(
                          color: ThemeColors.dark,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w900),
                    ),
                  ),
                ),
              ),
            ),
          ),
          IconButton(
              padding: EdgeInsets.only(bottom: 13.r),
              onPressed: () {
                addExamModelView.removeSubject(index);
              },
              icon: Icon(
                Icons.remove_circle_outline,
                size: 35.sp,
              ))
        ],
      ),
    );
  }
}
