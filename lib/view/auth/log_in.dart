import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:students_details_online/components/loading/auth_loading.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:students_details_online/utils/navigation_utils.dart';
import 'package:students_details_online/view_model/auth_view_model.dart';

class LogInScreen extends StatelessWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthViewModel authViewModel = context.watch<AuthViewModel>();
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarIconBrightness: Brightness.dark,
            ),
            toolbarHeight: 0,
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          backgroundColor: Colors.white,
          body: SafeArea(
              child: Stack(
            children: [
              Center(
                child: SizedBox(
                  width: 300.w,
                  height: 400.h,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Log in',
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
                            hintText: 'Email or Phone number',
                            hintStyle: TextStyle(
                              color: Color.fromARGB(104, 0, 0, 0),
                            )),
                        onChanged: (email) {
                          authViewModel.setLogingEmail(email);
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
                          authViewModel.setLoginPassword(password);
                        },
                      ),
                      SizedBox(height: 30.h),
                      SizedBox(
                        width: 300.w,
                        height: 40.h,
                        child: TextButton(
                            onPressed: () {
                              authViewModel.checkLogInValid(context);
                            },
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.black)),
                            child: Text('Log in',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 15.sp))),
                      ),
                      SizedBox(height: 10.h),
                      Center(
                        child: Text('OR',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w800,
                                fontSize: 15.sp)),
                      ),
                      SizedBox(height: 10.h),
                      SizedBox(
                        width: 300.w,
                        height: 40.h,
                        child: ElevatedButton(
                            onPressed: () {},
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.black)),
                            child: Text('Google',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 15.sp))),
                      ),
                      SizedBox(height: 30.h),
                      Align(
                          alignment: Alignment.center,
                          child: InkWell(
                            onTap: () => openSignInScreen(context),
                            child: Text(
                                'Not a member yet? Start your free account!',
                                style: TextStyle(
                                    color: const Color.fromARGB(255, 0, 0, 0),
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w800)),
                          )),
                      const Expanded(child: SizedBox()),
                      Align(
                          alignment: Alignment.center,
                          child: InkWell(
                            onTap: () => openForgetPasswordScreen(context),
                            child: Text('Forget Your Password?',
                                style: TextStyle(
                                    color: const Color.fromARGB(155, 0, 0, 0),
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500)),
                          )),
                    ],
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
                          padding:  EdgeInsets.all(20.r),
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
