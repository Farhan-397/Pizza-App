import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pizza_app/components/Button.dart';
import 'package:pizza_app/screens/HomeScreen/Home_Screen.dart';
import 'package:pizza_app/screens/create_acc/signup_screen.dart';

import '../../components/colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // String? userUID = "";
  //
  //
  // @override
  // void initState() {
  //   userCheck();
  //   // TODO: implement initState
  //   super.initState();
  // }
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return  Scaffold(
      backgroundColor: Colors.grey[100],
      body: SizedBox(
        height: size.height,
        width: Get.width,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20,),
                Center(
                 //padding: EdgeInsets.symmetric(horizontal: Get.width*0.25,vertical: 20),
                  child: Image.asset('assets/images/pizza.png',width: 150),
                ),
                const SizedBox(height: 20,),
                const Text('Login To your account',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                const SizedBox(height: 15,),
                const Text('Email',style: TextStyle(fontWeight: FontWeight.bold),),
                const SizedBox(height: 8,),

                Container(
                  color: Colors.white,
                  child: TextField(
                    controller: emailController,
                    decoration: const InputDecoration(
                        hintText: ' Active Email Address',
                        prefixIcon: Icon(Icons.email,color: Colors.black),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent))),
                  ),
                ),
                const SizedBox(height: 15,),
                const Text('Password',style: TextStyle(fontWeight: FontWeight.bold),),
                const SizedBox(height: 8,),
                Container(
                  color: Colors.white,
                  child: TextField(
                    controller: passwordController,
                    decoration: const InputDecoration(
                        hintText: ' Your Password',
                        prefixIcon: Icon(Icons.lock,color: Colors.black),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent))),
                  ),
                ),
                const SizedBox(height: 8,),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                  Text('Forget Password?',style: TextStyle(fontWeight: FontWeight.bold),)
                ],),
                const SizedBox(height: 20,),
                GlobalButton(
                  onTap: (){
                    signInWithDatabase();
                  },
                  text: 'Login',
                  color: Colors.black,
                ),
                const SizedBox(height: 20,),
                const Center(child: Text('Continue with Social Media?',style: TextStyle(fontSize: 16),)),
                const SizedBox(height: 20,),
                GlobalButton(onTap: (){}, text: 'Facebook', color: Colors.blue),
                const SizedBox(height: 20,),
          InkWell(
            onTap: (){},
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Container(
                width: Get.width,
                height: Get.height*0.08,

                decoration:
                BoxDecoration(
                    color: Colors.white,
                    borderRadius:BorderRadius.circular(5),
                  border: Border.all(color: Colors.black,)
                ),
                child:  const Center(child:  Text('Google',style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),)),
              ),
            ),
          ),
                const SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  const Text("Don't have an account ? "),
                  InkWell(
                    onTap: (){
                      Get.to(const SignupScreen());
                    },
                    child: const Text("Sign Up",style: TextStyle(color: AppColors.AppColor,fontWeight: FontWeight.bold,fontSize: 16),
                    ),
                  ),
                ],),
                const SizedBox(height: 20,),
              ],
            ),
          ),
        ),
      ),
    );
  }
  // void userCheck(){
  //   userUID =  FirebaseAuth.instance.currentUser?.uid;
  //   if(userUID!=null)
  //   {
  //     Get.to(const HomeScreen());
  //   }
  // }
  void signInWithDatabase() async {
    String email = emailController.text.toString().trim();
    String password = passwordController.text.toString().trim();

    if (email.isEmpty || password.isEmpty) {
      Get.snackbar('Error', 'Please enter both email and password.');
      return;
    }

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      ).then((userCredential) {
        Get.offAll( HomeScreen(
        ));
      }).catchError((e) {
        if (e is FirebaseAuthException) {
          if (e.code == 'user-not-found') {
            Get.snackbar('No user found for that email.', 'Sorry');
          } else if (e.code == 'wrong-password') {
            Get.snackbar('Wrong password provided for that user.', 'Wrong Password');
          }
        } else {
          print('Error: $e');
        }
      });
    } catch (e) {
      print('Error: $e');
    }
  }

}
