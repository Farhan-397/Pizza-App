import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pizza_app/components/Button.dart';

class PromoCode extends StatefulWidget {
  const PromoCode({super.key});

  @override
  State<PromoCode> createState() => _PromoCodeState();
}

class _PromoCodeState extends State<PromoCode> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(title: const Text('Promo Code'),
      centerTitle: true,
      ),
      body: Center(
        child: Container(
          height: Get.height*0.27,
          width: Get.width*0.9,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),
          color: Colors.white),
          child: Column(children: [
            const SizedBox(height: 10,),

            const Text('Apply Promotion Code',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
            const SizedBox(height: 15,),
            Form(child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width: 54,height: 58,
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey), // Change color as needed
                        borderRadius: BorderRadius.circular(15),
                      ),
                      fillColor: Colors.grey[100],
                      filled: true,

                    ),
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    cursorColor: Colors.black,
                    style: const TextStyle(fontSize: 20),
                    inputFormatters: [LengthLimitingTextInputFormatter(1),
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                  ),),
                const SizedBox(width: 8,),
                SizedBox(width: 54,height: 58,
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey), // Change color as needed
                        borderRadius: BorderRadius.circular(15),
                      ),
                      fillColor: Colors.grey[100],
                      filled: true,

                    ),
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    cursorColor: Colors.black,
                    style: const TextStyle(fontSize: 20),
                    inputFormatters: [LengthLimitingTextInputFormatter(1),
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                  ),),
                const SizedBox(width: 8,),
                SizedBox(width: 54,height: 58,
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey), // Change color as needed
                        borderRadius: BorderRadius.circular(15),
                      ),
                      fillColor: Colors.grey[100],
                      filled: true,

                    ),
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    cursorColor: Colors.black,
                    style: const TextStyle(fontSize: 20),
                    inputFormatters: [LengthLimitingTextInputFormatter(1),
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                  ),),
                const SizedBox(width: 8,),
                SizedBox(width: 54,height: 58,
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey), // Change color as needed
                        borderRadius: BorderRadius.circular(15),
                      ),
                      fillColor: Colors.grey[100],
                      filled: true,

                    ),
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    cursorColor: Colors.black,
                    style: const TextStyle(fontSize: 20),
                    inputFormatters: [LengthLimitingTextInputFormatter(1),
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                  ),),
              ],)),
            const SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 85.0),
              child: GlobalButton(onTap: (){}, text: 'Apply', color: Colors.black),
            )

          ]),
        ),
      ),
    );
  }
}
