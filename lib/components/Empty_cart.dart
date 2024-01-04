import 'package:flutter/cupertino.dart';


class EmptyBag extends StatefulWidget {
   final image,text,subtext;
  const EmptyBag({super.key,  required this.image, required this.text, required this.subtext});

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
              padding: const EdgeInsets.all(50.0),
              child: Image.asset(widget.image,height: 150,width: 150),
            ),
             Text(widget.text.toString(),style: TextStyle(fontSize: 30, )),
             Text(widget.subtext.toString(),
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
            ),
      ]),
    );
  }
}
