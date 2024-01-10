import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pizza_app/components/Button.dart';


class EmptyBag extends StatefulWidget {
   final image,text,subtext,buttontext;
   final VoidCallback onTap;

   const EmptyBag({super.key,  required this.image, required this.text, required this.subtext, required this.buttontext, required this.onTap, });

  @override
  State<EmptyBag> createState() => _EmptyBagState();
}

class _EmptyBagState extends State<EmptyBag> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: width,
      height: height*0.6,
      child:  Column(
        mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Image.asset(widget.image,height: 100,width: 150),
            ),
             Text(widget.text.toString(),style: const TextStyle(fontSize: 30, )),
             Text(widget.subtext.toString(),
                style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 75.0,vertical: 15),
              child: GlobalButton(onTap: widget.onTap, text: widget.buttontext, color: Colors.black),
            )
      ]),
    );
  }
}
