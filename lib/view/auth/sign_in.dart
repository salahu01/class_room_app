import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:students_details_online/view_model/auth_view_model.dart';

import '../../components/loading/auth_loading.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthViewModel authViewModel = context.watch<AuthViewModel>();
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarIconBrightness: Brightness.dark,
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              onPressed: () {
                authViewModel.removeValues();
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios_new,
                color: Colors.black,
                size: 28.sp,
              ),
            ),
          ),
          body: SafeArea(
              child: Stack(
                children: [
                  Center(
            child: SizedBox(
                  width: 300.w,
                  height: double.maxFinite,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 90.h),
                        Text('Sign in',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 30.sp,
                                fontWeight: FontWeight.w800)),
                        SizedBox(height: 20.h),
                        TextField(
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            filled: true,
                            fillColor: Color.fromARGB(77, 163, 155, 155),
                            hintText: 'Name',
                            hintStyle: TextStyle(
                              color: Color.fromARGB(104, 0, 0, 0),
                            ),
                          ),
                          onChanged: (name) {
                            authViewModel.setSignInName(name);
                          },
                        ),
                        SizedBox(height: 10.h),
                        TextField(
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              filled: true,
                              fillColor: Color.fromARGB(77, 163, 155, 155),
                              hintText: 'Email or Phone number',
                              hintStyle: TextStyle(
                                color: Color.fromARGB(104, 0, 0, 0),
                              )),
                          onChanged: (email) {
                            authViewModel.setSignInEmail(email);
                          },
                        ),
                        SizedBox(height: 10.h),
                        TextField(
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              filled: true,
                              fillColor: const Color.fromARGB(77, 163, 155, 155),
                              hintText: 'Password',
                              hintStyle: const TextStyle(
                                color: Color.fromARGB(104, 0, 0, 0),
                              ),
                              suffixIcon: InkWell(
                                onTap: () {},
                                child: const Icon(Icons.remove_red_eye),
                              )),
                          onChanged: (password) {
                            authViewModel.setSignInPassword(password);
                          },
                        ),
                        SizedBox(height: 10.h),
                        TextField(
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              filled: true,
                              fillColor: const Color.fromARGB(77, 163, 155, 155),
                              hintText: 'Confirm Password',
                              hintStyle: const TextStyle(
                                color: Color.fromARGB(104, 0, 0, 0),
                              ),
                              suffixIcon: InkWell(
                                onTap: () {},
                                child: const Icon(Icons.remove_red_eye),
                              )),
                          onChanged: (confirmPassword) {
                            authViewModel.setSignInConfirmPassword(confirmPassword);
                          },
                        ),
                        SizedBox(height: 30.h),
                        SizedBox(
                          width: 300.w,
                          height: 40.h,
                          child: TextButton(
                              onPressed: () {
                                authViewModel.checkSignInValid(context);
                              },
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.black)),
                              child: Text('Sign in',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w800,
                                      fontSize: 15.sp))),
                        ),
                        SizedBox(height: 30.h),
                        Align(
                            alignment: Alignment.center,
                            child: InkWell(
                              onTap: () {},
                              child: Text('Reset Values ?',
                                  style: TextStyle(
                                      color: const Color.fromARGB(255, 0, 0, 0),
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w800)),
                            )),
                      ],
                    ),
                  ),
            ),
          ),
          Align(
                alignment: Alignment.bottomCenter,
                child: Consumer<AuthViewModel>(
                  builder: (context, myType, child) {
                    return Visibility(
                        visible: myType.dialogShow,
                        child: Padding(
                          padding: EdgeInsets.all(20.r),
                          child: AwesomeSnackbarContent(
                            title: myType.dialogTitle,
                            message: myType.dialogMessage,
                            contentType: ContentType.failure,
                          ),
                        ));
                  },
                ),
              ),
                ],
              )),
        ),
        Consumer<AuthViewModel>(
          builder: (context, myType, child) {
            return Visibility(
                visible: myType.authLoading, child: const AuthLoading());
          },
        ),
      ],
    );
  }
}
