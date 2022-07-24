import 'package:flutter/material.dart';
import 'package:students_details_online/utils/theme.dart';

class AuthLoading extends StatelessWidget {
  const AuthLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color.fromARGB(100, 0, 0, 0),
      body:Center(
        child: CircularProgressIndicator(
          strokeWidth: 8,
          color: ThemeColors.primary,
        ),
      )
    );
  }
}
