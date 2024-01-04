import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'colors.dart';

class SkipButton extends StatelessWidget {
  final VoidCallback onTap;
  const SkipButton({required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: const Text(
          'Skip',
          style: TextStyle(
              fontSize: 18,color: AppColors.AppColor,decoration: TextDecoration.underline,decorationColor: AppColors.AppColor, fontWeight: FontWeight.w400,),
        ),
      ),
    );
  }
}
