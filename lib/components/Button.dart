import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GlobalButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final Color color;
  const GlobalButton({required this.onTap, super.key, required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: Container(
          width: Get.width,
          height: Get.height*0.08,

          decoration:
          BoxDecoration(
              color: color,
              borderRadius:BorderRadius.circular(5)
          ),
          child:  Center(child:  Text(text,style: const TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),)),
        ),
      ),
    );
  }
}