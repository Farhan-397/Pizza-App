import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pizza_app/components/Empty_cart.dart';
import 'package:pizza_app/components/firebasepaths.dart';

import '../../components/Button.dart';
import '../HomeScreen/Home_Screen.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  String? userUid = FirebaseAuth.instance.currentUser?.uid;
  late Set<String> favoriteProductIds = Set<String>();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(title: const Text('Favourite',style: TextStyle(fontWeight: FontWeight.bold)),
      centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: const Icon(Icons.favorite,color: Colors.orangeAccent),
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection(FirebasePaths.COLLECTION_USERS).doc(userUid)
            .collection(FirebasePaths.COLLECTION_FAVOURITE).snapshots(),
        builder: (context, snapShots) {
         return (snapShots.connectionState == ConnectionState.waiting)?
             const Center(child: CircularProgressIndicator(color: Colors.black),)
             : snapShots.data!.size<=0?
              EmptyBag(
               image: 'assets/images/empty-cart.png',
               text: "No Favourite Saved",
               subtext: "Once You Added, Come back!",
               onTap: (){
                 Get.to(HomeScreen());
               },
                buttontext: "Let's Browse some Favourites",
                           )
             : ListView.builder(
            itemCount: snapShots.data?.docs.length,
            itemBuilder: (context, index) {
              var favourite = snapShots.data?.docs[index].data() as Map<String,dynamic> ;

              return Dismissible(
                key: Key(favourite['id'].toString()),
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
                  FirebaseFirestore.instance
                      .collection("Users")
                      .doc(userUid)
                      .collection('favourite')
                      .doc(favourite['id'].toString())
                      .delete();
                  Get.snackbar("Item Deleted", 'Successfully');
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10.0),
                  child: Container(
                    padding: const EdgeInsets.only(left: 5),
                    height: size.height*0.15,
                    width: size.width,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(children: [
                            SizedBox(
                                height: 70,
                                width: 70,
                        child: Image.network(favourite['image'].toString(),)),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 6.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(favourite['name'].toString(),style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                                  Text(favourite['desc'].toString(),softWrap: true,style: const TextStyle(fontSize: 14),),
                                  const SizedBox(height: 5,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                          height: 20,
                                          width: 20,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(3),
                                            color: Colors.grey,

                                          ),
                                          child: const Center(child: Icon(Icons.remove,size: 20,))),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                        child: Text(favourite['quantity'].toString(),style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.orangeAccent)),
                                      ),
                                      Container(
                                        height: 20,
                                        width: 20,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(3),
                                          color: Colors.grey,

                                        ),
                                        child: const Center(child: Icon(Icons.add,size: 20,)),
                                      ),
                                    ],)
                                ],),
                            ),
                          ],),
                          Padding(
                            padding: const EdgeInsets.only(right: 14.0,top: 30),
                            child: Text(favourite['Price'].toString(),style: const TextStyle(color: Colors.orangeAccent,fontWeight: FontWeight.bold,fontSize: 18),),
                          )
                        ]),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
