import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pizza_app/components/Button.dart';

import '../HomeScreen/Home_Screen.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Comfirmation'),
         centerTitle: true,
      ),
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              children: [
                const SizedBox(height: 20,),
                Center(
                  child: Image.asset('assets/images/pizza.png',width: 150),
                ),
                const SizedBox(height: 20,),
                const Text('Enter Verification Code',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22),),
                const SizedBox(height: 10,),

                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.0),
                  child: Text('Verification Code is sent to your phone number which you added',textAlign: TextAlign.center,style: TextStyle(fontSize: 16,color: Colors.grey),),
                ),
                const SizedBox(height: 20,),
                Form(child: Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                  SizedBox(width: 64,height: 68,
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white), // Change color as needed
                        borderRadius: BorderRadius.circular(15),
                      ),
                      fillColor: Colors.white,
                      filled: true,

                    ),
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    cursorColor: Colors.black,
                    style: TextStyle(fontSize: 20),
                    inputFormatters: [LengthLimitingTextInputFormatter(1),
                    FilteringTextInputFormatter.digitsOnly,
                    ],
                  ),),
                  SizedBox(width: 8,),
                  SizedBox(width: 64,height: 68,
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white), // Change color as needed
                        borderRadius: BorderRadius.circular(15),
                      ),
                      fillColor: Colors.white,
                      filled: true,

                    ),
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    cursorColor: Colors.black,
                    style: TextStyle(fontSize: 20),
                    inputFormatters: [LengthLimitingTextInputFormatter(1),
                    FilteringTextInputFormatter.digitsOnly,
                    ],
                  ),),
                     SizedBox(width: 8,),
                  SizedBox(width: 64,height: 68,
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white), // Change color as needed
                        borderRadius: BorderRadius.circular(15),
                      ),
                      fillColor: Colors.white,
                      filled: true,

                    ),
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    cursorColor: Colors.black,
                    style: TextStyle(fontSize: 20),
                    inputFormatters: [LengthLimitingTextInputFormatter(1),
                    FilteringTextInputFormatter.digitsOnly,
                    ],
                  ),),
                     SizedBox(width: 8,),
                  SizedBox(width: 64,height: 68,
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white), // Change color as needed
                        borderRadius: BorderRadius.circular(15),
                      ),
                      fillColor: Colors.white,
                      filled: true,

                    ),
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    cursorColor: Colors.black,
                    style: TextStyle(fontSize: 20),
                    inputFormatters: [LengthLimitingTextInputFormatter(1),
                    FilteringTextInputFormatter.digitsOnly,
                    ],
                  ),),
                ],)),
                const SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  Text("Didn't recieve any code? "),
                  Text('Resend',style: TextStyle(color: Colors.orange,fontSize: 18,fontWeight: FontWeight.bold)),
                ],),
                const SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: GlobalButton(onTap: (){Get.to( HomeScreen(
                  ));}, text: "Confirm", color: Colors.black),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
