import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../HomeScreen/Home_Screen.dart';
import '../first_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // String? userUID = "";
  //
  // @override
  // void initState() {
  //   userCheck();
  //   // TODO: implement initState
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return  Scaffold(
      backgroundColor: Colors.black,
      body: Column(
          children: [
            SizedBox(height: size.height*0.12),
            Center(child: Image.asset('assets/images/pizza.png',width: 250.0)),
        SizedBox(height: size.height*0.12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: RichText(text: const TextSpan(
            text: 'Fastest ',style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),
            children: [
              TextSpan(
                text: 'Delivery ',style: TextStyle(color: Colors.deepOrange),
              ),
              TextSpan(text: 'any time \n       at Your '),
              TextSpan(text: 'Doorstep',style: TextStyle(color: Colors.deepOrange),),
            ]
          )),
        ),
            SizedBox(height: size.height*0.03),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: Text('     Keep tabs on your delivery with real-time order tracking. Know exactly when your delicious meal will arrive at your doorstep.',
              style: TextStyle(color: Colors.white), overflow: TextOverflow.ellipsis,maxLines: 3,
              ),
            ),
            SizedBox(height: size.height*0.05),
            InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (Context)=> DoorHubOnboardingScreen()));
              },
              child: Container(
                height: size.height*0.09,
                width: size.width*0.8,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                ),
                child: Center(child: const Text('Get Started',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)),
              ),
            )
      ]),
    );
  }
  // void userCheck(){
  //   userUID =  FirebaseAuth.instance.currentUser?.uid;
  //   if(userUID!=null)
  //   {
  //     Get.to(const HomeScreen());
  //   }
  // }
}
