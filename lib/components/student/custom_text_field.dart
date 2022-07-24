import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:students_details_online/utils/theme.dart';
import 'package:students_details_online/view_model/crud_student_view_model.dart';

class CustomTextField extends StatelessWidget {
  
  const CustomTextField({Key? key, required this.label,required this.hint, required this.spacing,required this.controller}) : super(key: key);
  final String label ;
  final String hint ;
  final double spacing ;
  final TextEditingController controller ;

  @override
  Widget build(BuildContext context) {
    CrudStudentViewModel addStudentViewModel = context.watch<CrudStudentViewModel>();
    controller.text.isEmpty ? const SizedBox() : addStudentViewModel.setStudentDetails(label: label, text: controller.text) ;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 13.r),
      child: Row(
        children: [
          Text(
            label,
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w700,
                fontSize: 17.sp),
          ),
          SizedBox(width: spacing.sp),
          Text(
            '  :   ',
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w700,
                fontSize: 17.sp),
          ),
          Flexible(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.r),
              child: TextFormField(
                controller: controller,
                onChanged: (text){
                  addStudentViewModel.setStudentDetails(label: label, text: text);
                },
                decoration: InputDecoration(
                    border: InputBorder.none,
                    filled: true,
                    fillColor:ThemeColors.primary,
                    hintText: hint,
                    hintStyle: const TextStyle(
                      color: Color.fromARGB(155, 0, 0, 0),
                    )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
