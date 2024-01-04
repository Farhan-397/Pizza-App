import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:pizza_app/components/Button.dart';
import 'package:pizza_app/components/firebasepaths.dart';
import 'package:pizza_app/screens/adddress/addressScreen.dart';
import 'package:pizza_app/screens/trackorder/track_order.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AddAddressScreen extends StatefulWidget {
  const AddAddressScreen({super.key});

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  TextEditingController streetController = TextEditingController();
  TextEditingController sectorController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(' Add Address',style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Padding(
        padding:  const EdgeInsets.symmetric(horizontal: 25.0),
        child:  SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // const SizedBox(height: 15,),
              // const Padding(
              //   padding: EdgeInsets.symmetric(horizontal: 100.0),
              //   child: Divider(
              //     height: 5.0,
              //     thickness: 5,
              //     color: Colors.black,
              //   ),
              // ),
              // const SizedBox(height: 15,),
               const Text('Address Detail',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
              // const SizedBox(height: 15,),
              //
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Container(
              //       height: 50,
              //       width: 40,
              //       decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
              //         color: Colors.grey[100],
              //       ),
              //       child: const Icon(Icons.location_on,color: Colors.orangeAccent,size: 30),
              //     ),
              //     const Flexible(
              //       child: Padding(
              //         padding: EdgeInsets.only(left: 8.0),
              //         child: Column(
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           children: [
              //           Text('Madina Tayyaba Building Material',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
              //           Text('Faisalabad',),
              //         ],),
              //       ),
              //     ),
              //     const Icon(Icons.mode_edit_sharp,color: Colors.black,size: 35,)
              //   ],
              // ),
              const SizedBox(height: 15,),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                const Text('Street & House #',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                const SizedBox(height: 15,),
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child:  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: TextField(
                      controller: streetController,
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'e.g: Street no 1 house no 4',
                          hintStyle: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold
                          )
                      ),
                    ),
                  ),
                ),
              ],),
              const SizedBox(height: 15,),
              const Text('Sector / Block / Plot number',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
              const SizedBox(height: 15,),

              Container(
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child:  Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: TextField(
                    controller: sectorController,
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Sector / Block / Plot number',
                        hintStyle: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold
                        )
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15,),

              const Text('City',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
              const SizedBox(height: 15,),

              Container(
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child:  Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: TextField(
                    controller: cityController,
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'City',
                        hintStyle: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold
                        )
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15,),

              GlobalButton(
                onTap: (){
                saveUserAddress();
                saveViaSpUserAddress();
                },
                text: 'Save And Continue', color: Colors.black,)


            ],
          ),
        ),
      ),
    );
  }

  void saveUserAddress() {
     String? userUid = FirebaseAuth.instance.currentUser?.uid;
     var autoId = FirebaseFirestore.instance.collection(FirebasePaths.COLLECTION_USERS).doc().id;
    FirebaseFirestore.instance.collection(FirebasePaths.COLLECTION_USERS)
        .doc(userUid).collection(FirebasePaths.COLLECTION_ADDRESS)
        .doc(autoId).set({
      FirebasePaths.KEY_STREET : streetController.text.toString(),
      FirebasePaths.KEY_SECTOR : sectorController.text.toString(),
      FirebasePaths.KEY_CITY : cityController.text.toString(),
      FirebasePaths.KEY_ID : autoId.toString(),
    }).whenComplete(() {
      EasyLoading.dismiss();
      Get.snackbar('Your Address Is Added', "Enjoy");
      Get.to(const AddressScreen());
    });
  }
  Future<void> saveViaSpUserAddress() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('street', streetController.text.toString());
    prefs.setString('sector', sectorController.text.toString());
    prefs.setString('city', cityController.text.toString());
  }
}
