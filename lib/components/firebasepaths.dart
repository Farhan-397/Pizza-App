import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebasePaths{
  static const String COLLECTION_PRODUCT='products';
  static const String COLLECTION_FAVOURITE= 'favourite';
  static const String COLLECTION_USERS='Users';
  static const String COLLECTION_CART='cart';
  static const String COLLECTION_ADDRESS='address';

  static const String KEY_ID='id';
  static const String KEY_PRICE= 'Price';
  static const String KEY_DESC='desc';
  static const String KEY_IMAGE= 'image';
  static const String KEY_NAME='name';
  static const String KEY_QUANTITY='quantity';
  static const String KEY_STREET='street';
  static const String KEY_SECTOR='sector';
  static const String KEY_CITY='city';





  static  String? UID=  FirebaseAuth.instance.currentUser?.uid;
  static String?  autoId = FirebaseFirestore.instance.collection(FirebasePaths.COLLECTION_USERS).doc().id;

}

class SharedPref{
  static const String PREF_UID = 'uid';
  static const String PREF_EMAIL = 'email';
  static const String PREF_NAME = 'name';
  static const String PREF_IMAGE = 'image';
  static const String PREF_PHONE = 'phone';
  static const String PREF_TYPE ='type';
}