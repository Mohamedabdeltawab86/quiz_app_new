import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomImage extends StatelessWidget {
  final double? width;
  final double? height;
  final String imageUrl;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final double borderRadius;
  final Widget? child;

  const CustomImage({
    super.key,
    this.height,
    this.width,
    required this.imageUrl,
    this.borderRadius = 20,
    this.padding,
    this.margin,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          height: 200.sp,
          width: 400.sp,
          margin: margin,
          padding: padding,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                  image: AssetImage(imageUrl), fit: BoxFit.cover)),
          child: child),
    );
  }
}
