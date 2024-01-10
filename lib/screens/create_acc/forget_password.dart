import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pizza_app/components/Button.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forget Password'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,

      ),
      body:  Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
        'Enter your email to reset your password',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
            )),
            SizedBox(height: 10,),
             TextField(
              controller: emailController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Email',
              ),
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              keyboardType: TextInputType.emailAddress,

            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 55.0,vertical: 15.0),
              child: GlobalButton(onTap: (){
                sendForgetEmail();
              }, text: 'Send E-mail ', color: Colors.black),
            )
          ],
        ),
      ),
    );
  }

  void sendForgetEmail() async{
    await FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text.toString()

    );
  }
}
