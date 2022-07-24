import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomImage extends StatelessWidget {
  const CustomImage({Key? key, required this.image,this.size}) : super(key: key);
  final String? image;
  final double? size;

  @override
  Widget build(BuildContext context) {
    if (image == null || image == "") {
      return Image.asset(
        'lib/assets/female.png',
        fit: BoxFit.cover,
        width:size ?? 60.w,
        height:size ?? 60.w,
      );
    } else {
      return DecoratedBox(
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              offset: Offset(0, -1),
              spreadRadius: 3,
            )
          ]
        ),
        child: Image.network(
          image!,
          fit: BoxFit.cover,
          width:size ?? 60.w,
          height:size ?? 60.w,
        ),
      );
    }
  }
}
