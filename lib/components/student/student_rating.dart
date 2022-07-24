import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:students_details_online/utils/theme.dart';
import 'package:students_details_online/view_model/crud_student_view_model.dart';

class StudentRating extends StatelessWidget {
  const StudentRating({Key? key, required this.value, required this.label})
      : super(key: key);
  final int value;
  final String label;

  @override
  Widget build(BuildContext context) {
    CrudStudentViewModel addStudentViewModel =
        context.watch<CrudStudentViewModel>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          label,
          style: TextStyle(
              color: ThemeColors.dark,
              fontSize: 15.sp,
              fontWeight: FontWeight.w800),
        ),
        DropdownButton<int>(
          value: value,
          style: TextStyle(
              color: ThemeColors.dark,
              fontWeight: FontWeight.w800,
              fontSize: 16.sp),
          onChanged: (int? newValue) {
            addStudentViewModel.setStudentRating(
                label: label, value: newValue!);
          },
          items: <int>[1, 2, 3, 4, 5].map<DropdownMenuItem<int>>((int value) {
            return DropdownMenuItem<int>(
              value: value,
              child: Text(value.toString()),
            );
          }).toList(),
        ),
      ],
    );
  }
}
