import 'package:bottom_bar_matu/utils/app_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pizza_app/components/firebasepaths.dart';
import 'package:pizza_app/screens/HomeScreen/Home_Screen.dart';
import 'package:pizza_app/screens/information/information_screen.dart';

import '../../components/Button.dart';
import '../../components/Empty_cart.dart';

class MyCart extends StatefulWidget {
   MyCart({super.key, });

  @override
  State<MyCart> createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> {
  String? userUid = FirebaseAuth.instance.currentUser?.uid;
  double totalPrice = 0.0;
  double total = 0.0;
  double delivery = 150.0;
  int quantity = 1;
  @override
  void initState() {
    super.initState();
    // Call the function when the widget is initialized
    updateTotal();
  }

  // Function to update the total
  void updateTotal() async {
    double calculatedTotal = await calculateTotal();
    setState(() {
      total = calculatedTotal;
    });
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('My Cart'),
        centerTitle: true,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10)),
              child: const Icon(Icons.favorite,color: Colors.orange),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Container(
                  height:size.height*0.45 ,
                  width: size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.grey[150],
                  ),
                  child:  StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance.collection("Users").doc(userUid).collection('cart').snapshots(),
                    builder: (context,snapShots){
                      return (snapShots.connectionState == ConnectionState.waiting) ?
                      const Center(
                        child: CircularProgressIndicator(color: Colors.amber,),):
                      snapShots.data!.size<=0?
                       Padding(
                         padding: const EdgeInsets.symmetric(horizontal: 25.0),
                         child: EmptyBag(
                          image: 'assets/images/empty-cart.png',
                          text: "Cart Empty",
                          subtext: "Once You Added, Come back!",
                           onTap: (){
                             Get.to(HomeScreen());
                           },
                           buttontext: "Browse",
                                               ),
                       )
                          :ListView.builder(
                          itemCount: snapShots.data?.docs.length,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context,index){
                            var cart = snapShots.data?.docs[index].data() as Map<String,dynamic>;

                            return Dismissible(
                                key: Key(cart['cartID'].toString()),
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
                                .collection('cart')
                                .doc(cart['cartID'].toString())
                                .delete();
                            updateTotal();
                            Get.snackbar("Item Deleted", 'Successfully');
                            },
                            child:Padding(
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
                                      Row(
                                        children: [
                                        SizedBox(
                                            height: 70,
                                            width: 70,
                                            child: Image.network(cart[FirebasePaths.KEY_IMAGE ].toString(),)),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                                          child: SizedBox(
                                            width: size.width*0.40,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text(cart[FirebasePaths.KEY_NAME ].toString(),style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                                                const SizedBox(height: 5,),
                                                Text(cart[FirebasePaths.KEY_DESC].toString(),style: const TextStyle(fontSize: 12),
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                                const SizedBox(height: 5,),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                        height: 30,
                                                        width: 30,
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(3),
                                                          color: Colors.grey,

                                                        ),
                                                        child:  Center(child: GestureDetector(
                                                            onTap: (){
                                                              removeQuantity(cart[FirebasePaths.KEY_QUANTITY ], cart['cartID'].toString(),);
                                                            },
                                                            child: const Icon(Icons.remove,size: 25,)))),

                                                     Padding(
                                                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                                      child: Text(cart[FirebasePaths.KEY_QUANTITY ].toString(),
                                                          style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.orangeAccent)),
                                                    ),
                                                    Container(
                                                        height: 30,
                                                        width: 30,
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(3),
                                                          color: Colors.grey,
                                                        ),
                                                        child:  Center(child: GestureDetector(
                                                            onTap: (){
                                                              addQuantity(cart[FirebasePaths.KEY_QUANTITY ], cart['cartID'].toString(),);
                                                            },
                                                            child: const Icon(Icons.add,size: 25,)))),
                                                  ],)
                                              ],),
                                          ),
                                        ),
                                      ],),
                                       Padding(
                                        padding: const EdgeInsets.only(right: 14.0,top: 30),
                                        child: Text(cart[FirebasePaths.KEY_PRICE].toString(),style: const TextStyle(color: Colors.orangeAccent,fontWeight: FontWeight.bold,fontSize: 18),),
                                      )
                                    ]),
                              ),
                            ));
                          });},
                  )



                ),
                const Text('Add Ons',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,),),
                    Row(children: [
                      Image.asset('assets/images/coke.png',width: 45,height: 45,),
                      Container(
                        height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            color: Colors.white,
                          ),
                          child:  Center(child: GestureDetector(
                              onTap: (){
                                if(quantity >1){
                                  setState(() {
                                    quantity--;
                                  });
                                }
                              },
                              child: const Icon(Icons.remove,size: 20,)))),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text('0',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.orangeAccent)),
                      ),
                      Container(
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            color: Colors.white,
                          ),
                          child:  Center(child: GestureDetector(
                              onTap: (){
                                setState(() {
                                  quantity++;
                                });
                              },
                              child: const Icon(Icons.add,size: 20,))),
                      ),
                    ],)
              ]),
            ),
            const SizedBox(height: 20,),
            Container(
              height: size.height*0.4,
              width: size.width,
              decoration: const BoxDecoration(color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30))
              ),

              child:  Padding(
                padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 30),
                child: Column(children: [
                   Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Item Bill",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                      Text(total.toString(),style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                    ],),
                  const SizedBox(height: 15,),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Tax",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                      Text("0.0%",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                    ],),
                  const SizedBox(height: 15,),
                   Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Delivery Charges",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                      Text("Rs $delivery".toString(),style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                    ],),
                  const SizedBox(height: 15,),
                  const Divider(color: Colors.black,),
                  const SizedBox(height: 15,),
                   Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Total",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                      Text((delivery + total).toStringAsFixed(2),
                        style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                    ],),
                  const SizedBox(height: 25,),
                  GlobalButton(onTap: (){
                    Get.to(
                         InformationScreen(
                             itemPrice: total.toString(),
                             delivery: delivery.toString(),
                             total: (total + delivery).toString()
                         ));
                    },
                      text: 'Proceed to payment', color: Colors.black)
                ]),
              ),
            )
          ],
        ),
      ),
    );
  }

  void removeQuantity(quantity,cartID) {

    var credential =  FirebaseAuth.instance.currentUser?.uid;
    int quant = int.parse(quantity);
    if(quant>= 1){
      quant--;
      FirebaseFirestore.instance.collection(FirebasePaths.COLLECTION_USERS).doc(credential)
          .collection(FirebasePaths.COLLECTION_CART).doc(cartID).update({
        FirebasePaths.KEY_QUANTITY : quant.toString(),
      });
      updateTotal();
    }
  }

  void addQuantity(quantity,cartID) {
    var credential =  FirebaseAuth.instance.currentUser?.uid;
    int quant =   int.parse(quantity);
    quant++;
    FirebaseFirestore.instance.collection(FirebasePaths.COLLECTION_USERS).doc(credential)
    .collection(FirebasePaths.COLLECTION_CART).doc(cartID).update({
      FirebasePaths.KEY_QUANTITY  : quant.toString(),
    });
    updateTotal();

  }

  Future<double> calculateTotal () async {
    double total = 0.0;
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance
        .collection(FirebasePaths.COLLECTION_USERS)
        .doc(userUid).collection(FirebasePaths.COLLECTION_CART)
        .get();
    querySnapshot.docs.forEach((QueryDocumentSnapshot<Map<String, dynamic>> document) {
      double price = double.parse(document[FirebasePaths.KEY_PRICE].toString());
      int quantity = int.parse(document[FirebasePaths.KEY_QUANTITY].toString());
      total += price * quantity;
    });
    return total;
  }
}
