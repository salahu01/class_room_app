import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:students_details_online/components/common/custom_image.dart';
import 'package:students_details_online/components/exam/empty_exam.dart';
import 'package:students_details_online/components/exam/exams_card.dart';
import 'package:students_details_online/utils/navigation_utils.dart';
import 'package:students_details_online/utils/theme.dart';
import 'package:students_details_online/view_model/auth_navigation.dart';
import 'package:students_details_online/view_model/exams_view_model.dart';

import '../view_model/students_view_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    StudentViewModel userViewModel = context.watch<StudentViewModel>();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ThemeColors.white,
      appBar: AppBar(
        leadingWidth: 90.w,
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
            ClipRRect(
              borderRadius: BorderRadius.circular(13.r),
              child: InkWell(
                onTap: (){
                  openUserDetails(context);
                },
                child: Consumer<AuthNavigationViewModel>(
                  builder: (context, myType, child) {
                    return CustomImage(image: myType.userClient?.photo);
                  },
                )
              ),
            ),
            const Spacer(),
          ],
        ),
        title: Center(
          child: Consumer<AuthNavigationViewModel>(
            builder: (context, myType, child) {
              return Text(
            myType.userClient?.name! ?? 'netWork Error',
            style: TextStyle(
                color: ThemeColors.dark,
                fontSize: 20.sp,
                fontWeight: FontWeight.w800),
          );
            },
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.search,
                color: ThemeColors.dark,
                size: 30.sp,
                shadows: const [
                  BoxShadow(offset: Offset(0, 2), color: ThemeColors.dark)
                ],
              )),
          SizedBox(width: 15.w)
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 20.r, top: 20.r),
            child: Text(
              'Students Details',
              style: TextStyle(
                  color: ThemeColors.dark,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w900),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                left: 10.r, right: 10.r, top: 10.r, bottom: 30.r),
            child: SizedBox(
              height: 100.h,
              width: double.maxFinite,
              child: Card(
                borderOnForeground: true,
                color: ThemeColors.primary,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.only(left: 20.r, top: 10.h, bottom: 10.h),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Total Students',
                              style: TextStyle(
                                  color: ThemeColors.dark,
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w700),
                            ),
                            Text(
                              userViewModel.studentListModel.length
                                      .toString(),
                              style: TextStyle(
                                  color: ThemeColors.dark,
                                  fontSize: 30.sp,
                                  fontWeight: FontWeight.w900),
                            ),
                          ]),
                    ),
                    IconButton(
                        onPressed: () {
                          openStudentdDetails(context);
                        },
                        icon: const Icon(
                          Icons.arrow_forward_ios_sharp,
                          color: ThemeColors.dark,
                          shadows: [
                            BoxShadow(
                                offset: Offset(0, 2), color: ThemeColors.dark)
                          ],
                        ))
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20.r, right: 20.r),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Exams',
                    style: TextStyle(
                        color: ThemeColors.dark,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w900),
                  ),
                  InkWell(
                    onTap: () => openAllExams(context),
                    child: Text(
                      'View All',
                      style: TextStyle(
                          color: ThemeColors.dark,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ]),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.r),
            child: SizedBox(
              height: 220.w,
              child: Consumer<ExamsViewModel>(
                builder: (context, myType, child) {
                if (myType.examsListModel.isEmpty) {
                  return InkWell(
                    onTap: () => openAddExamDetails(context),
                    child: const EmptyExam());
                }
                return ListView.builder(
                itemCount: myType.examsListModel.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    overlayColor: MaterialStateProperty.all<Color>(Colors.transparent),
                    onTap: (){ 
                      myType.setSelectedExam(index);
                      openExamDetails(context);
                      },
                    child:  ExamsCardModel(title: myType.examsListModel[index].examName!));
                },
              );
                },
              )
            ),
          ),
          const Expanded(child: SizedBox()),
          Padding(
            padding: EdgeInsets.only(left: 20.r),
            child: Text(
              'Presents Details',
              style: TextStyle(
                  color: ThemeColors.dark,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w900),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10.r, right: 10.r, top: 10.r),
            child: SizedBox(
              height: 100.h,
              width: double.maxFinite,
              child: Card(
                borderOnForeground: true,
                color: ThemeColors.primary,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.only(left: 20.r, top: 10.h, bottom: 10.h),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Average Presents',
                              style: TextStyle(
                                  color: ThemeColors.dark,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w800),
                            ),
                            Text(
                              '67 %',
                              style: TextStyle(
                                  color: ThemeColors.dark,
                                  fontSize: 25.sp,
                                  fontWeight: FontWeight.w900),
                            ),
                          ]),
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.arrow_forward_ios_sharp,
                          color: ThemeColors.dark,
                          shadows: [
                            BoxShadow(
                                offset: Offset(0, 2), color: ThemeColors.dark)
                          ],
                        ))
                  ],
                ),
              ),
            ),
          ),
          const Expanded(child: SizedBox()),
        ],
      ),
    );
  }
}