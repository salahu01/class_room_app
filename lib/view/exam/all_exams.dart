import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:students_details_online/components/exam/exams_card.dart';
import 'package:students_details_online/utils/navigation_utils.dart';
import 'package:students_details_online/view_model/exams_view_model.dart';

import '../../components/common/empty_data.dart';
import '../../components/common/network_error.dart';
import '../../components/loading/app_loading.dart';
import '../../utils/theme.dart';

class AllExams extends StatelessWidget {
  const AllExams({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ExamsViewModel examsViewModel = context.watch<ExamsViewModel>();
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
              'Exams',
              style: TextStyle(
                  color: ThemeColors.dark,
                  fontSize: 23.sp,
                  fontWeight: FontWeight.w800),
            ),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  openAddExamDetails(context);
                },
                icon: Icon(
                  Icons.add,
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
        children: [
          Expanded(child: _ui(examsViewModel)),
        ],
      ));
  }

  _ui(ExamsViewModel examsViewModel) {
    if (examsViewModel.networkError == true) {
      return const NoNetwork();
    }
    if (examsViewModel.loading == true) {
      return const AppLoading();
    }
    if (examsViewModel.emptyData == true) {
      return const EmptyData(title: 'Add Exams');
    }
    if (examsViewModel.examsListModel.isNotEmpty) {
      return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.88,
        ),
        itemCount: examsViewModel.examsListModel.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            overlayColor: MaterialStateProperty.all<Color>(Colors.transparent),
            onTap: () {},
            child: InkWell(
                onTap: () { 
                  examsViewModel.setSelectedExam(index);
                  openExamDetails(context);
                  },
                child: ExamsCardModel(title: examsViewModel.examsListModel[index].examName!)),
          );
        },
      );
    }
  }
}
