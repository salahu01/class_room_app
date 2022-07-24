import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:students_details_online/components/common/empty_data.dart';
import 'package:students_details_online/components/common/network_error.dart';
import 'package:students_details_online/components/student/student_tile.dart';
import 'package:students_details_online/utils/navigation_utils.dart';
import 'package:students_details_online/utils/theme.dart';
import 'package:students_details_online/view_model/crud_student_view_model.dart';

import '../../components/loading/app_loading.dart';
import '../../model/student_model.dart';
import '../../view_model/students_view_model.dart';

class StudentsDetails extends StatelessWidget {
  const StudentsDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    StudentViewModel userViewModel = context.watch<StudentViewModel>();
    CrudStudentViewModel addStudentViewModel =
        context.watch<CrudStudentViewModel>();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ThemeColors.white,
      appBar: AppBar(
        leadingWidth: 0,
        toolbarHeight: 100.h,
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: ThemeColors.white,
          statusBarIconBrightness: Brightness.dark,
        ),
        title: Row(
          children: [
            Flexible(
              child: DecoratedBox(
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                      color: Colors.black45,
                      blurRadius: 15.sp,
                      offset: const Offset(0, 0))
                ]),
                child: TextField(
                  style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w700,
                      color: ThemeColors.white),
                  decoration: InputDecoration(
                    isDense: true,
                    fillColor: ThemeColors.dark,
                    filled: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.r),
                        borderSide: BorderSide.none),
                    hintText: 'Search here',
                    hintMaxLines: 1,
                    hintStyle: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w700,
                        color: ThemeColors.white),
                  ),
                  onChanged: (text) {
                    userViewModel.serachStudets(text);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(child: _ui(userViewModel)),
        ],
      ),
      floatingActionButton: FloatingActionButton.small(
        onPressed: () {
          addStudentViewModel.setUpdateValues(null);
          openAddStudent(context, 'Add Student', null, null);
        },
        backgroundColor: ThemeColors.white,
        child: Icon(
          Icons.add,
          size: 35.sp,
          color: ThemeColors.dark,
        ),
      ),
    );
  }

  _ui(StudentViewModel userViewModel) {
    if (userViewModel.networkError == true) {
      return const NoNetwork();
    }
    if (userViewModel.loading == true) {
      return const AppLoading();
    }
    if (userViewModel.emptyData == true) {
      return const EmptyData(title: 'Add Students');
    }
    if (userViewModel.studentListModel.isNotEmpty) {
      return ListView.builder(
        itemCount: userViewModel.searchStudentListModel?.length ?? userViewModel.studentListModel.length,
        itemBuilder: (BuildContext context, int index) {
          StudentModel studentModel = userViewModel.searchStudentListModel? [index] ?? userViewModel.studentListModel[index];
          return InkWell(
              onTap: () {
                userViewModel.setSelectedStudent(studentModel);
                userViewModel.setSelectedStudentChartData(studentModel);
                openSelectedStudentdDetails(context, index);
              },
              child: StudentTile(index: index, studentModel: studentModel));
        },
      );
    }
  }
}
