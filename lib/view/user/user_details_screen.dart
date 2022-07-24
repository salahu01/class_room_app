import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:students_details_online/components/common/custom_image.dart';
import 'package:students_details_online/components/user/user_detail_row.dart';
import 'package:students_details_online/model/user_model.dart';
import 'package:students_details_online/utils/navigation_utils.dart';
import 'package:students_details_online/view_model/auth_navigation.dart';
import '../../utils/theme.dart';

class UserDetails extends StatelessWidget {
  const UserDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthNavigationViewModel authNavigationViewModel =
        context.watch<AuthNavigationViewModel>();
    UserClient? userClient = authNavigationViewModel.userClient;
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
            'Details',
            style: TextStyle(
                color: ThemeColors.dark,
                fontSize: 23.sp,
                fontWeight: FontWeight.w800),
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                openEditUserDetails(context);
              },
              icon: Icon(
                Icons.edit,
                color: ThemeColors.dark,
                size: 28.sp,
              )),
          SizedBox(width: 15.w)
        ],
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 25.h),
            ClipRRect(
                borderRadius: BorderRadius.circular(30.r),
                child: CustomImage(
                  image: userClient?.photo,
                  size: 120,
                )),
            SizedBox(height: 40.h),
            UserDetailModel(defualtValue: 'Add Name', data: userClient?.name, label: 'Name', spacing: 108.r,),
            UserDetailModel(defualtValue: 'Add Email', data: userClient?.email, label: 'Email', spacing: 108.r,),
            UserDetailModel(defualtValue: 'Add Phone', data: userClient?.phone, label: 'Phone', spacing: 108.r,),
            UserDetailModel(
                defualtValue: 'Add Current Institute',
                data: userClient?.instituteName, label: 'Institute', spacing: 108.r,),
            UserDetailModel(
                defualtValue: 'Add Qualifiaction',
                data: userClient?.qualification, label: 'Qualification', spacing: 108.r,),
            const Expanded(flex: 3, child: SizedBox()),
            TextButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          backgroundColor: ThemeColors.primary,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.r)),
                          title: Column(
                            children: [
                              SizedBox(height: 10.h),
                              Text(
                                'Do you want Logout ?',
                                style: TextStyle(
                                    color: ThemeColors.dark,
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w800),
                              ),
                              SizedBox(height: 30.h),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  InkWell(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: Icon(
                                        Icons.arrow_back,
                                        color: ThemeColors.dark,
                                        size: 30.sp,
                                      )),
                                  InkWell(
                                      onTap: () {
                                        authNavigationViewModel.logOutUser(context);
                                      },
                                      child: Icon(
                                        Icons.logout,
                                        color: ThemeColors.dark,
                                        size: 30.sp,
                                      ))
                                ],
                              ),
                              SizedBox(height: 10.h),
                            ],
                          ),
                        );
                      });
                },
                style: ButtonStyle(
                    fixedSize:
                        MaterialStateProperty.all<Size>(Size(200.w, 50.h)),
                    shape: MaterialStateProperty.all<OutlinedBorder>(
                        const StadiumBorder()),
                    backgroundColor:
                        MaterialStateProperty.all(ThemeColors.primary)),
                child: Text(
                  'Log Out',
                  style: TextStyle(
                    color: ThemeColors.dark,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w800,
                  ),
                )),
            const Expanded(child: SizedBox()),
          ],
        ),
      ),
    );
  }
}
