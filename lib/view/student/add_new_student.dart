import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:students_details_online/components/common/aler_dialog.dart';
import 'package:students_details_online/components/student/custom_text_field.dart';
import 'package:students_details_online/components/student/education_details.dart';
import 'package:students_details_online/components/loading/saving_loading.dart';
import 'package:students_details_online/components/student/student_rating.dart';
import 'package:students_details_online/model/student_model.dart';
import 'package:students_details_online/utils/constansts.dart';
import 'package:students_details_online/view_model/crud_student_view_model.dart';
import 'package:students_details_online/view_model/students_view_model.dart';

import '../../utils/theme.dart';

class AddNewStudent extends StatelessWidget {
  const AddNewStudent(
      {Key? key, required this.title, this.studentModel, this.index})
      : super(key: key);

  final String title;
  final StudentModel? studentModel;
  final int? index;

  @override
  Widget build(BuildContext context) {
    StudentViewModel studentViewModel = context.watch<StudentViewModel>();
    return Stack(
      children: [
        Scaffold(
          backgroundColor: ThemeColors.white,
          appBar: AppBar(
            leadingWidth: 60.w,
            toolbarHeight: 80.h,
            backgroundColor: Colors.transparent,
            elevation: 0,
            systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor: ThemeColors.white,
              statusBarIconBrightness: Brightness.dark,
            ),
            leading: Row(
              children: [
                const Spacer(),
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back_ios_new_sharp,
                      color: ThemeColors.dark,
                      size: 30.sp,
                      shadows: const [
                        BoxShadow(offset: Offset(0, 2), color: ThemeColors.dark)
                      ],
                    )),
                const Spacer(),
              ],
            ),
            title: Center(
              child: Text(
                title,
                style: TextStyle(
                    color: ThemeColors.dark,
                    fontSize: 21.sp,
                    fontWeight: FontWeight.w800),
              ),
            ),
            actions: [
              Consumer<CrudStudentViewModel>(
                builder: (context, myType, child) {
                  return Center(
                    child: InkWell(
                      onTap: () {
                        CustomDialog.customShowDialog(context, myType , null);
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(13.r),
                        child: SizedBox(
                          height: 60.w,
                          width: 60.w,
                          child: DecoratedBox(
                              decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: AssetImage(
                                        'lib/assets/female.png',
                                      ))),
                              child: Icon(
                                Icons.add,
                                color: ThemeColors.white,
                                size: 30.w,
                                shadows: const [
                                  BoxShadow(
                                      offset: Offset(2, 2), color: ThemeColors.dark)
                                ],
                              )),
                        ),
                      ),
                    ),
                  );
                },
              ),
              SizedBox(width: 15.w)
            ],
          ),
          body: Stack(
            children: [
              SingleChildScrollView(
                  child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 13.r),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 20.r),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Select Student Rating',
                          style: TextStyle(
                              color: ThemeColors.dark,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w800),
                        ),
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20.r),
                      child: ColoredBox(
                          color: ThemeColors.primary,
                          child: SizedBox(
                            height: 100.h,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Consumer<CrudStudentViewModel>(
                                    builder: (context, myType, child) => StudentRating(
                                        label: 'last', value: myType.lastYear)),
                                Consumer<CrudStudentViewModel>(
                                    builder: (context, myType, child) => StudentRating(
                                        label: 'second', value: myType.secondYear)),
                                Consumer<CrudStudentViewModel>(
                                    builder: (context, myType, child) => StudentRating(
                                        label: 'third', value: myType.thirdYear)),
                                Consumer<CrudStudentViewModel>(
                                    builder: (context, myType, child) => StudentRating(
                                        label: 'fourth', value: myType.fourthYear)),
                                Consumer<CrudStudentViewModel>(
                                    builder: (context, myType, child) => StudentRating(
                                        label: 'fifth', value: myType.fifthYear))
                              ],
                            ),
                          )),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 20.r),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Education Details',
                          style: TextStyle(
                              color: ThemeColors.dark,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w800),
                        ),
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20.r),
                      child: ColoredBox(
                          color: ThemeColors.primary,
                          child: SizedBox(
                            height: 150.h,
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 9.r),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Consumer<CrudStudentViewModel>(
                                          builder: (context, myType, child) =>
                                              EducationDetails(
                                                  label: 'course',
                                                  value: myType.course,
                                                  list: Constants.courses)),
                                      SizedBox(
                                        width: 160.w,
                                        child: FittedBox(
                                          child: Consumer<CrudStudentViewModel>(
                                              builder: (context, myType, child) =>
                                                  EducationDetails(
                                                      label: 'department',
                                                      value: myType.department,
                                                      list: Constants.departments)),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Consumer<CrudStudentViewModel>(
                                        builder: (context, myType, child) =>
                                            EducationDetails(
                                                label: 'batch',
                                                value: myType.batch,
                                                list: Constants.batchs)),
                                    Consumer<CrudStudentViewModel>(
                                        builder: (context, myType, child) =>
                                            EducationDetails(
                                                label: 'year',
                                                value: myType.year,
                                                list: Constants.years)),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: 18.r),
                                      child: Consumer<CrudStudentViewModel>(
                                          builder: (context, myType, child) =>
                                              EducationDetails(
                                                  label: 'status',
                                                  value: myType.status,
                                                  list: Constants.status)),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 20.r),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Student Details',
                          style: TextStyle(
                              color: ThemeColors.dark,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w800),
                        ),
                      ),
                    ),
                    CustomTextField(
                        label: 'name',
                        hint: 'name',
                        spacing: 10,
                        controller:
                            TextEditingController(text: studentModel?.name ?? '')),
                    CustomTextField(
                        label: 'email',
                        hint: 'email',
                        spacing: 10,
                        controller:
                            TextEditingController(text: studentModel?.email ?? '')),
                    CustomTextField(
                        label: 'phone',
                        hint: 'phone',
                        spacing: 5,
                        controller:
                            TextEditingController(text: studentModel?.phone ?? '')),
                    CustomTextField(
                        label: 'dob',
                        hint: 'MM-DD-YYYY',
                        spacing: 24,
                        controller:
                            TextEditingController(text: studentModel?.dob ?? '')),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 20.r),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Parent Details',
                          style: TextStyle(
                              color: ThemeColors.dark,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w800),
                        ),
                      ),
                    ),
                    CustomTextField(
                        label: 'parent name',
                        hint: 'parent name',
                        spacing: 16,
                        controller:
                            TextEditingController(text: studentModel?.parent ?? '')),
                    CustomTextField(
                        label: 'parent relation',
                        hint: 'parent relation',
                        spacing: 1,
                        controller: TextEditingController(
                            text: studentModel?.parentRelation ?? '')),
                    CustomTextField(
                        label: 'parent phone',
                        hint: 'parent phone',
                        spacing: 12,
                        controller: TextEditingController(
                            text: studentModel?.parentPhone ?? '')),
                    SizedBox(height: 10.h)
                  ],
                ),
              )),
              Align(
                alignment: Alignment.bottomCenter,
                child: Consumer<CrudStudentViewModel>(
                  builder: (context, myType, child) {
                    return Visibility(
                        visible: myType.dialogShow,
                        child: Padding(
                          padding:  EdgeInsets.all(20.r),
                          child: AwesomeSnackbarContent(
                            title: myType.dialogTitle!,
                            message: myType.dialogMessage!,
                            contentType: ContentType.failure,
                          ),
                        ));
                  },
                ),
              ),
            ],
          ),
          bottomNavigationBar: Padding(
              padding:
                  EdgeInsets.only(top: 15.r, bottom: 15.r, left: 70.r, right: 70.r),
              child: Consumer<CrudStudentViewModel>(
                builder: (context, myType, child) {
                  return TextButton(
                      onPressed: () {
                        myType.checkValid(studentViewModel, context, index, myType);
                      },
                      style: ButtonStyle(
                          fixedSize:
                              MaterialStateProperty.all<Size>(Size(200.w, 50.h)),
                          shape: MaterialStateProperty.all<OutlinedBorder>(
                              const StadiumBorder()),
                          backgroundColor:
                              MaterialStateProperty.all(ThemeColors.primary)),
                      child: Text(
                        'Save Details',
                        style: TextStyle(
                          color: ThemeColors.dark,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w800,
                        ),
                      ));
                },
              )),
        ),

        Consumer<CrudStudentViewModel>(
          builder: (context, myType, child) {
            return  Visibility(
            visible: myType.loading,
            child:const SavingLoading() 
            );
          },
        ),

      ],
    );
  }
}