import 'package:flutter/material.dart';
import 'package:students_details_online/utils/theme.dart';

class AppLoading extends StatelessWidget {
  const AppLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
    color: ThemeColors.dark,
    strokeWidth: 10,
      ),
    );
  }
}