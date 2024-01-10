import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:pizza_app/components/Button.dart';
import 'package:pizza_app/components/firebasepaths.dart';
import 'package:pizza_app/components/spinLoading.dart';
import 'package:pizza_app/screens/create_acc/login_screen.dart';
import 'package:pizza_app/screens/googler_services/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'otp_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return  Scaffold(
      backgroundColor: Colors.grey[100],
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20,),
                Center(
                  // padding: EdgeInsets.symmetric(horizontal: Get.width*0.25,vertical: 20),
                  child: Image.asset('assets/images/pizza.png',width: 150),
                ),
                const SizedBox(height: 20,),
                const Text('Create An Account',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                const SizedBox(height: 15,),
                const Text('User Name',style: TextStyle(fontWeight: FontWeight.bold),),
                const SizedBox(height: 8,),
                Container(
                  color: Colors.white,
                  child: TextField(
                    controller: nameController,
                    decoration: const InputDecoration(
                        hintText: ' Enter Your Name',
                        prefixIcon: Icon(Icons.person,color: Colors.black),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent))),
                  ),
                ),
                const SizedBox(height: 8,),
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
                const Text('Phone Number',style: TextStyle(fontWeight: FontWeight.bold),),
                const SizedBox(height: 8,),
                Container(
                  color: Colors.white,
                  child: TextField(
                    controller: phoneController,
                    decoration: const InputDecoration(
                        hintText: ' Active Phone Number',
                        prefixIcon: Icon(Icons.call,color: Colors.black),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent))),
                  ),
                ),
                const SizedBox(height: 20,),
                GlobalButton(
                  onTap: (){
                   // _saveUserData();
                    crateAcc();},
                  text: 'Send OTP',
                  color: Colors.black,
                ),
                const SizedBox(height: 20,),
              ],
            ),
          ),
        ),
      ),
    );
  }
  void crateAcc() async{
    String email = emailController.text.toString().trim();
    String password = passwordController.text.toString().trim();
    String name = nameController.text.toString().trim();
    String phone = phoneController.text.toString().trim();

    if (email.isEmpty || password.isEmpty || name.isEmpty || phone.isEmpty) {
      Get.snackbar('Error', 'Please enter all required fields.');
      return;
    }
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
      ).whenComplete(() {
        saveDataToDatabase();
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Get.snackbar('Sorry', 'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        Get.snackbar('Sorry', 'The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }
  void saveDataToDatabase() async{
    String? credential = FirebaseAuth.instance.currentUser?.uid.toString();
    FirebaseFirestore.instance.collection('Users').doc(credential)
        .set(
        {
          'name': nameController.text.toString(),
          'email': emailController.text.toString(),
          'password': passwordController.text.toString(),
          'UserUid': credential.toString(),
          'phone': phoneController.text.toString(),
        }
    ).whenComplete(() async{
      EasyLoading.dismiss();
      try{
        await FirebaseAuth.instance.currentUser!.sendEmailVerification();
      } on FirebaseException catch(e){
        // final ex = TExceptions.fr
      }
      Get.snackbar('Activate your account', "Check your gmail for Link");
      Get.to(const LoginScreen());
    });

  }
  // Future<void> _saveUserData() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setString(SharedPref.PREF_NAME, nameController.text);
  //   prefs.setString(SharedPref.PREF_EMAIL, emailController.text);
  //   prefs.setString(SharedPref.PREF_PHONE, phoneController.text);
  //   prefs.setString(SharedPref.PREF_IMAGE, FirebaseAuth.instance.currentUser!.photoURL.toString());
  //   prefs.setString(SharedPref.PREF_TYPE, 'custom' );
  // }
}
