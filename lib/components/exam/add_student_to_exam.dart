import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:students_details_online/utils/theme.dart';
import 'package:students_details_online/view_model/students_view_model.dart';
import 'package:students_details_online/view_model/subject_view_model.dart';

class AddStudentCard extends StatelessWidget {
  const AddStudentCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(25.r),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.r),
        child: ColoredBox(
          color: ThemeColors.primary,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(15.r),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Add Students',
                              style: TextStyle(
                                  color: ThemeColors.dark,
                                  fontSize: 23.sp,
                                  fontWeight: FontWeight.w800),
                            ),
                            Consumer<SubjectViewModel>(
                              builder: (context, myType, child) {
                                return IconButton(
                                    onPressed: () {
                                      myType.setShowAddStudent(false);
                                    },
                                    icon: Icon(
                                      Icons.close,
                                      color: ThemeColors.dark,
                                      size: 30.sp,
                                    ));
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: 20.h),
                        SizedBox(
                          height:500.h,
                          child: Consumer<StudentViewModel>(
                            builder: (context, myType, child) {
                              return ListView.separated(
                            itemCount:myType.studentListModel.length,
                            separatorBuilder: (BuildContext context, int index) {
                              return const Divider();
                            },
                            itemBuilder: (BuildContext context, int index) {
                              return ClipRRect(
                                borderRadius: BorderRadius.circular(20.r),
                                child: ColoredBox(
                                  color: ThemeColors.dark,
                                  child: ListTile(
                                    title: Text(
                                      myType.studentListModel[index].name!,
                                      style: TextStyle(
                                          color: ThemeColors.white,
                                          fontSize:17.sp,
                                          fontWeight: FontWeight.w800),
                                    ),
                                    trailing: IconButton(onPressed: (){}, icon: Icon(Icons.add,
                                    color: ThemeColors.white,
                                    size: 25.sp,
                                    )),
                                  ),
                                ),
                              );
                            },
                          );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
