import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:students_details_online/components/exam/subject_card.dart';
import 'package:students_details_online/model/exam_model.dart';
import 'package:students_details_online/view_model/add_exam_model_view.dart';
import 'package:students_details_online/view_model/exams_view_model.dart';

import '../../utils/theme.dart';
import '../../view_model/crud_student_view_model.dart';

class AddExam extends StatelessWidget {
  const AddExam({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AddExamModelView addExamModelView = context.watch<AddExamModelView>();
    return Scaffold(
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
            'Add Exam Details',
            style: TextStyle(
                color: ThemeColors.dark,
                fontSize: 23.sp,
                fontWeight: FontWeight.w800),
          ),
        ),
        actions: [SizedBox(width: 50.w)],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 20.r, top: 20.r, right: 20.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Add Exam Name',
                style: TextStyle(
                    color: ThemeColors.dark,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w900),
              ),
              SizedBox(height: 5.h),
              ClipRRect(
                borderRadius: BorderRadius.circular(10.r),
                child: TextField(
                  onChanged: (text) {
                    addExamModelView.setExamtName(text);
                  },
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      filled: true,
                      fillColor: ThemeColors.primary,
                      hintText: 'Enter Exam name ',
                      hintStyle: TextStyle(
                        color: Color.fromARGB(155, 0, 0, 0),
                      )),
                ),
              ),
               SizedBox(height: 25.h),
              Text(
                'Add Subject',
                style: TextStyle(
                    color: ThemeColors.dark,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w900),
              ),
              SizedBox(height: 15.h),
              Row(
                children: [
                  Flexible(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.r),
                      child: TextField(
                        onChanged: (text) {
                          addExamModelView.setSubjectName(text);
                        },
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            filled: true,
                            fillColor: ThemeColors.primary,
                            hintText: 'Enter subject name ',
                            hintStyle: TextStyle(
                              color: Color.fromARGB(155, 0, 0, 0),
                            )),
                      ),
                    ),
                  ),
                  IconButton(
                      padding: EdgeInsets.only(bottom: 13.r),
                      onPressed: () {
                        addExamModelView.addSubject();
                      },
                      icon: Icon(
                        Icons.add,
                        size: 40.sp,
                        color: ThemeColors.dark,
                      )),
                ],
              ),
              Visibility(
                visible: addExamModelView.subjectVisible,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 25.h),
                    Text(
                      'Added Subjects',
                      style: TextStyle(
                          color: ThemeColors.dark,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w900),
                    ),
                    SizedBox(height: 13.h),
                    ListView.builder(
                      primary: false,
                      shrinkWrap: true,
                      itemCount: addExamModelView.subjects.length,
                      itemBuilder: (BuildContext context, int index) {
                        return  SubjectModel(index: index, addExamModelView: addExamModelView);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
          padding: EdgeInsets.only(top: 15.r, bottom: 15.r, left: 70.r, right: 70.r),
          child: Consumer<CrudStudentViewModel>(
            builder: (context, myType, child) {
              return Consumer<ExamsViewModel>(
                builder: (context, myType, child) {
                  return TextButton(
                  onPressed: () {
                    bool response = addExamModelView.checkValid();
                    if (response == true) {
                     myType.setExam(addExamModelView.createObject() as ExamModel , context); 
                    }
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
              );
            },
          )),
    );
  }
}