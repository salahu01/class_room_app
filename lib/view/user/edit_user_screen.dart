import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:students_details_online/components/common/custom_image.dart';
import 'package:students_details_online/components/loading/saving_loading.dart';
import 'package:students_details_online/components/user/user_edit_field.dart';
import 'package:students_details_online/model/user_model.dart';
import 'package:students_details_online/view_model/auth_navigation.dart';
import '../../components/common/aler_dialog.dart';
import '../../utils/theme.dart';

class EditUserDetails extends StatelessWidget {
  const EditUserDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthNavigationViewModel authNavigationViewModel =context.watch<AuthNavigationViewModel>();
    UserClient? userClient = authNavigationViewModel.userClient;
    return Stack(
      children: [
        Scaffold(
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
                      Icons.close,
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
                'Edit Details',
                style: TextStyle(
                    color: ThemeColors.dark,
                    fontSize: 23.sp,
                    fontWeight: FontWeight.w800),
              ),
            ),
            actions: [
              SizedBox(width: 40.w)
            ],
          ),
          body: Center(
            child: Column(
              children: [
                SizedBox(height: 25.h),
                ClipRRect(
                    borderRadius: BorderRadius.circular(30.r),
                    child: InkWell(
                      overlayColor: MaterialStateProperty.all<Color>(Colors.transparent),
                      onTap: (){
                        CustomDialog.customShowDialog(context, null ,authNavigationViewModel);
                      },
                      child: Stack(
                        children: [
                          CustomImage(
                            image: userClient?.photo,
                            size: 120,
                          ),
                          Padding(
                            padding: EdgeInsets.all(10.r),
                            child: Icon(Icons.add,
                            size: 100.r,
                            color: ThemeColors.white,
                            ),
                          )
                        ],
                      ),
                    )),
                SizedBox(height: 40.h),
                EditDetailsField(label: 'Name', hint: 'name', spacing: 56, controller: TextEditingController(text: userClient?.name ?? '')),
                EditDetailsField(label: 'Phone', hint: 'Phone', spacing: 54, controller: TextEditingController(text: userClient?.phone ?? '')),
                EditDetailsField(label: 'Institue', hint: 'Institue', spacing: 45, controller: TextEditingController(text: userClient?.instituteName ?? '')),
                EditDetailsField(label: 'Qualification', hint: 'Qualification', spacing: 8, controller: TextEditingController(text: userClient?.qualification ?? '')),
                const Expanded(flex: 3, child: SizedBox()),
                TextButton(
                    onPressed: () {
                      authNavigationViewModel.updateUserClient(context);
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
                    )),
                const Expanded(child: SizedBox()),
              ],
            ),
          ),
        ),
        Visibility(
          visible: authNavigationViewModel.loading,
          child:const SavingLoading() 
          )
      ],
    );
  }
}
