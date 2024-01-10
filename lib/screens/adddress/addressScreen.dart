import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:pizza_app/components/firebasepaths.dart';
import 'package:pizza_app/screens/adddress/add_address_Screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../components/Button.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  String? userUid = FirebaseAuth.instance.currentUser?.uid;
  TextEditingController streetController = TextEditingController();
  TextEditingController sectorController = TextEditingController();
  TextEditingController cityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Addresses'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child:  SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 8.0),
            child: Column(
              children: [
                Container(
                  height: 50,
                  width: Get.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.grey[200],
                  ),
                  child: InkWell(
                    onTap: (){
                      Get.to(const AddAddressScreen());
                    },
                    child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                       Row(children: [
                         Icon(Icons.add_circle_outline,color: Colors.black,),
                         Text("Add New Address",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                       ],),
                      Icon(Icons.arrow_right,color: Colors.grey,)
                    ]),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  height: Get.height*80,
                  child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection(FirebasePaths.COLLECTION_USERS).doc(userUid)
                      .collection(FirebasePaths.COLLECTION_ADDRESS).snapshots(),
                  builder: (context, snapShots) {
                  return (snapShots.connectionState == ConnectionState.waiting) ?
                  const Center(child: CircularProgressIndicator(color: Colors.amber,),):
                  ListView.builder(
                      itemCount: snapShots.data?.docs.length,
                      itemBuilder: (context, index){
                    var address =  snapShots.data?.docs[index].data() as Map<String,dynamic>;
                    return   Padding(
                      padding:  const EdgeInsets.symmetric(vertical: 8.0),
                      child: Dismissible(
                        key: Key(address[FirebasePaths.KEY_ID].toString()),
                        direction: DismissDirection.endToStart,
                        background: Container(
                          color: Colors.black,
                          child: const Align(
                            alignment: Alignment.centerRight,
                            child: Padding(padding: EdgeInsets.only(right: 20.0),
                              child: Icon(Icons.delete,size: 50,
                                color: Colors.white,
                              ),),),),
                          onDismissed: (direction) {
                          clearPref();
                    FirebaseFirestore.instance
                        .collection(FirebasePaths.COLLECTION_USERS)
                        .doc(userUid)
                        .collection(FirebasePaths.COLLECTION_ADDRESS)
                        .doc(FirebasePaths.autoId)
                        .delete();
                    Get.snackbar("Address Deleted", 'Successfully');
                    },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),

                          ),
                          child: ListTile(
                            leading: Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                                color: Colors.grey[100],
                              ),
                              child: const Icon(Icons.location_on,color: Colors.orangeAccent,size: 30),
                            ),
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(address[FirebasePaths.KEY_STREET].toString().toUpperCase(),style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                                Text(address[FirebasePaths.KEY_SECTOR],style: const TextStyle(fontSize: 14),),
                                Text(address[FirebasePaths.KEY_CITY],style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 14),),
                              ],),
                            trailing: IconButton(
                                onPressed: (){
                                  streetController.text = address[FirebasePaths.KEY_STREET].toString();
                                  sectorController.text = address[FirebasePaths.KEY_SECTOR].toString();
                                  cityController.text = address[FirebasePaths.KEY_CITY].toString();
                                  Get.bottomSheet(
                                      backgroundColor: Colors.grey[100],
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(15)
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: SingleChildScrollView(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              const Text('Update Your Address: ',style: TextStyle(
                                                fontWeight: FontWeight.bold,fontSize: 18,
                                              )),
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
                                                    decoration:  const InputDecoration(
                                                        border: InputBorder.none,
                                                        hintText: 'e.g: Street no 1',
                                                        hintStyle: TextStyle(
                                                            color: Colors.grey,
                                                            fontWeight: FontWeight.bold
                                                        )
                                                    ),
                                                  ),
                                                ),
                                              ),
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
                                                    decoration:  const InputDecoration(
                                                        border: InputBorder.none,
                                                        hintText: 'Sector / Block /',
                                                        hintStyle: TextStyle(
                                                            color: Colors.grey,
                                                            fontWeight: FontWeight.bold
                                                        )
                                                    ),
                                                  ),
                                                ),
                                              ),
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
                                                    decoration:  const InputDecoration(
                                                        border: InputBorder.none,
                                                        hintText: 'e.g: Faisalabad ',
                                                        hintStyle: TextStyle(
                                                            color: Colors.grey,
                                                            fontWeight: FontWeight.bold
                                                        )
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(height: 15,),
                                              Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 45.0),
                                                child: Center(
                                                  child: GlobalButton(
                                                    onTap: (){
                                                      updateAddress();
                                                    },
                                                    color: Colors.black,
                                                    text: 'Update',
                                                  ),
                                                ),
                                              ),
                                            ],),
                                        ),
                                      )
                                  );
                                },
                                icon: const Icon(Icons.mode_edit_sharp,color: Colors.orangeAccent,size: 35,)),
                          ),
                        )
                      ),
                    );
                  });
                          },
                        ),
                ),

              ],
            ),
          ),
        )),
    );
  }

  void updateAddress() async{
    String? UserUid = FirebasePaths.UID;
    var autoId = FirebaseFirestore.instance.collection(FirebasePaths.COLLECTION_USERS).doc().id;
    await FirebaseFirestore.instance.collection(FirebasePaths.COLLECTION_USERS).doc(UserUid).collection(FirebasePaths.COLLECTION_ADDRESS)
        .doc(autoId).update({
      FirebasePaths.KEY_STREET : streetController.text.toString(),
      FirebasePaths.KEY_SECTOR : sectorController.text.toString(),
      FirebasePaths.KEY_CITY : cityController.text.toString()
    }).whenComplete(() {

    }).whenComplete(() {
      EasyLoading.dismiss();
      Get.snackbar('Your Acc Is Updated', "Successfully");
      Get.back();
    });

    }

  void clearPref() async {
    SharedPreferences prefs =  await SharedPreferences.getInstance();
      prefs.clear();

  }
}
