import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pizza_app/components/firebasepaths.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthMethods{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<User?> get authChanges => _auth.authStateChanges();
  User get user => _auth.currentUser!;
  Future <bool>signInWithGoogle(BuildContext context) async{
    bool result = false;
    try{
      final GoogleSignInAccount? googleUser= await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      UserCredential  userCredential =
      await _auth.signInWithCredential(credential);
      User? user = userCredential.user;
      if(user!=null){
        if(userCredential.additionalUserInfo!.isNewUser){
         await _firestore.collection(FirebasePaths.COLLECTION_USERS)
             .doc(user.uid.toString())
             .set({
            'username': user.displayName,
            'userid': user.uid.toString(),
            'profilePhoto': user.photoURL,
            'email': user.email.toString(),
            'phone': user.phoneNumber.toString(),

         });
        }
        result = true;
      }
    } on FirebaseAuthException catch(e){
      Get.snackbar('An error occurred', '$e.message!');
      result = false;
    }
    return result;
  }
}