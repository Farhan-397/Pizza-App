import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pizza_app/components/Button.dart';
import 'package:pizza_app/components/firebasepaths.dart';
import 'package:pizza_app/screens/HomeScreen/Home_Screen.dart';
import 'package:pizza_app/screens/create_acc/signup_screen.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../components/colors.dart';
import '../googler_services/firebase_auth.dart';
import 'forget_password.dart';

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


  var name = '';
  var email = '';
  var image = '';
  var userUID = '';
  var phone = '';
  final AuthMethods _authMethods = AuthMethods();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  RoundedLoadingButtonController loginController = RoundedLoadingButtonController();
  RoundedLoadingButtonController googleController = RoundedLoadingButtonController();
  RoundedLoadingButtonController facebookController = RoundedLoadingButtonController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 20,),
                Center(
                  //padding: EdgeInsets.symmetric(horizontal: Get.width*0.25,vertical: 20),
                  child: Image.asset('assets/images/pizza.png', width: 150),
                ),
                const SizedBox(height: 20,),
                const Text('Login To your account',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                const SizedBox(height: 15,),
                const Text(
                  'Email', style: TextStyle(fontWeight: FontWeight.bold),),
                const SizedBox(height: 8,),

                Container(
                  color: Colors.white,
                  child: TextField(
                    controller: emailController,
                    decoration: const InputDecoration(
                        hintText: ' Active Email Address',
                        prefixIcon: Icon(Icons.email, color: Colors.black),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent))),
                  ),
                ),
                const SizedBox(height: 15,),
                const Text(
                  'Password', style: TextStyle(fontWeight: FontWeight.bold),),
                const SizedBox(height: 8,),
                Container(
                  color: Colors.white,
                  child: TextField(
                    controller: passwordController,
                    decoration: const InputDecoration(
                        hintText: ' Your Password',
                        prefixIcon: Icon(Icons.lock, color: Colors.black),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent))),
                  ),
                ),
                const SizedBox(height: 8,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                        onTap: () {
                          Get.to(const ForgetPassword());
                        },
                        child: const Text('Forget Password?',
                          style: TextStyle(fontWeight: FontWeight.bold),))
                  ],),
                const SizedBox(height: 20,),
                // GlobalButton(
                //   onTap: () {
                //     signInWithDatabase();
                //
                //   },
                //   text: 'Login',
                //   color: Colors.black,
                // ),
                RoundedLoadingButton(
                    controller: loginController,
                    successColor: Colors.black,
                    color: Colors.black,
                    elevation: 0,
                    borderRadius: 5,
                    width: size.width*0.6,
                    onPressed: (){
                      signInWithDatabase();
                    }, child: const Wrap(
                  children: [
                    Text('Log In', style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),)
                  ],
                )),
                const SizedBox(height: 20,),
                const Center(child: Text('Continue with Social Media?',
                  style: TextStyle(fontSize: 16),)),
                const SizedBox(height: 20,),
                RoundedLoadingButton(
                    controller: googleController,
                    onPressed: () {

                      signInWithGoogle();
                    },
                    successColor: Colors.green,
                    color: Colors.red,
                    elevation: 0,
                    borderRadius: 5,
                    width: size.width*0.7,
                    child: const Wrap(
                      children: [
                        Icon(FontAwesomeIcons.google,
                          size: 20,
                          color: Colors.white,
                        ),
                        SizedBox(width: 15,),
                        Text('Sign In with google', style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),)
                      ],
                    )),
                const SizedBox(height: 10,),
                // RoundedLoadingButton(controller: facebookController,
                //     onPressed: () {},
                //     successColor: Colors.blue,
                //     color: Colors.blue,
                //     elevation: 0,
                //     borderRadius: 5,
                //     width: size.width*0.6,
                //     child: const Wrap(
                //       children: [
                //         Icon(
                //           FontAwesomeIcons.facebook,
                //           size: 20,
                //           color: Colors.white,
                //         ),
                //         SizedBox(width: 15,),
                //         Text('Sign In with facebook', style: TextStyle(
                //           color: Colors.white,
                //           fontSize: 15,
                //           fontWeight: FontWeight.w500,
                //         ),)
                //       ],
                //     )),
                const SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account ? "),
                    InkWell(
                      onTap: () {
                        Get.to(const SignupScreen());
                      },
                      child: const Text("Sign Up", style: TextStyle(
                          color: AppColors.AppColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
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
        if (FirebaseAuth.instance.currentUser!.emailVerified) {
          loginController.success();
          Future.delayed(const Duration(milliseconds: 1000) ,(){
            Get.offAll(const HomeScreen());
          }

          );
          String userUid = FirebaseAuth.instance.currentUser!.uid.toString();
          getCurrentUserdata(userUid);
        }
        else {
          Get.snackbar('Please Verify Your Account', 'Check your  G-mail');
          loginController.reset();
        }
      }).catchError((e) {
        if (e is FirebaseAuthException) {
          if (e.code == 'user-not-found') {
            Get.snackbar('No user found for that email.', 'Sorry');
          } else if (e.code == 'wrong-password') {
            Get.snackbar(
                'Wrong password provided for that user.', 'Wrong Password');
          }
        } else {
          Get.snackbar('Error:', ' $e');
        }
      });
    } catch (e) {
      Get.snackbar('Error', ' $e');
    }
  }

   void signInWithGoogle() async {
    bool result = await _authMethods.signInWithGoogle(context);

    if (result) {
      saveUserSpData(
          "google",
          _authMethods.user.displayName,
          _authMethods.user.email.toString(),
          _authMethods.user.uid,
         _authMethods.user.phoneNumber.toString(),
         _authMethods.user.photoURL.toString()
      );
      googleController.success();
      Future.delayed(const Duration(milliseconds: 1000), () {
        Get.offAll(const HomeScreen());
      });
    }
    else {
      Get.snackbar('Error', 'Something went wrong');
      googleController.reset();
    }
  }
  void saveUserSpData(type,name,email,userUID,phone,image) async{

    final SharedPreferences sp =  await SharedPreferences.getInstance();
    sp.setString(SharedPref.PREF_NAME, name);
    sp.setString(SharedPref.PREF_EMAIL, email);
    sp.setString(SharedPref.PREF_UID, userUID);
    sp.setString(SharedPref.PREF_PHONE, phone);
    sp.setString(SharedPref.PREF_IMAGE, image);
    sp.setString(SharedPref.PREF_TYPE, type);

  }

  void getCurrentUserdata(String userUID) async{
    await FirebaseFirestore.instance.collection('Users').doc(userUID).get().then((value) {
      if (value.exists) {
     name =  value.get('name').toString();
     email = value.get('email').toString();
     phone = value.get('phone').toString();

}else{
        Get.snackbar('No Data Exist','Sorry');
      }
        }).whenComplete(() {
          saveUserSpData("custom", name, email, userUID, phone, "");
    });
}
}

