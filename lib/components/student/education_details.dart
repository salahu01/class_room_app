import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../utils/theme.dart';
import '../../view_model/crud_student_view_model.dart';

class EducationDetails extends StatelessWidget {
  const EducationDetails({Key? key,required this.label,required this.value, required this.list}) : super(key: key);
  final String label;
  final String value;
  final List<String> list ;

  @override
  Widget build(BuildContext context) {
    CrudStudentViewModel  addStudentViewModel = context.watch<CrudStudentViewModel>();
    return Row(
      children: [
        Text(
        '$label   :   ',
          style: TextStyle(
              color: ThemeColors.dark,
              fontSize: 13.sp,
              fontWeight: FontWeight.w800),
        ),
        DropdownButton<String>(
          value: value,
          style: TextStyle(
              color: ThemeColors.dark,
              fontWeight: FontWeight.w800,
              fontSize: 14.sp),
          onChanged: (String? newValue) {
            addStudentViewModel.setEducationDetails(label: label, value: newValue);
          },
          items: list.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value.toString()),
            );
          }).toList(),
        ),
      ],
    );
  }

}