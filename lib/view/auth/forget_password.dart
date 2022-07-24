import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:students_details_online/view_model/auth_view_model.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthViewModel authViewModel = context.watch<AuthViewModel>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
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
          child: Center(
        child: SizedBox(
          width: 300.w,
          height: double.maxFinite,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 90.h),
                Text('Forget Password',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 30.sp,
                        fontWeight: FontWeight.w800)),
                SizedBox(height: 40.h),
                TextField(
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      filled: true,
                      fillColor: Color.fromARGB(77, 163, 155, 155),
                      hintText: 'Enter mail here',
                      hintStyle: TextStyle(
                        color: Color.fromARGB(104, 0, 0, 0),
                      )),
                  onChanged: (email) {
                    authViewModel.setSignInEmail(email);
                  },
                ),
                SizedBox(height: 30.h),
                SizedBox(
                  width: 300.w,
                  height: 40.h,
                  child: TextButton(
                      onPressed: () {
                        // write forget password expression
                      },
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.black)),
                      child: Text('Sent mail',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                              fontSize: 15.sp))),
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
