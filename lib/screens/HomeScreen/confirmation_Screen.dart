import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pizza_app/components/Button.dart';
import 'package:pizza_app/screens/information/information_screen.dart';

import '../../components/firebasepaths.dart';
import '../cart/cart.dart';
import '../favourite/favorite.dart';

class ConfirmationScreen extends StatefulWidget {
  String? Pizzaprice,PizzaMainImage,PizzaName,PizzaingredientsName,id,categoryType;
   ConfirmationScreen({super.key,required this.PizzaName,required this.categoryType,required this.id, required this.PizzaingredientsName, required ,required this.Pizzaprice,required this.PizzaMainImage});

  @override
  State<ConfirmationScreen> createState() => _ConfirmationScreenState();
}

class _ConfirmationScreenState extends State<ConfirmationScreen> {
  int val = 1;
  int valu = 1;
   int  quantity =1 ;

   var favouriteIcon = Icons.favorite_border;

   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkFavourite();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Confirmation',style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: GestureDetector(
              onTap: (){

                checkFavorite(
                  widget.id.toString(),
                  widget.Pizzaprice.toString(),
                  widget.PizzaName.toString(),
                  widget.PizzaingredientsName.toString(),
                  widget.PizzaMainImage.toString(),
                );
                },

              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child:  Icon(
                    favouriteIcon,color: Colors.orange),
              ),
            ),
          ),
        ],
      ),
      body: Stack(
          children: [
            Column(children: [
              Expanded(
                flex: 3,
                child: Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                  ),
                  child: Image.network(
                    widget.PizzaMainImage.toString(),
                  ),
                ),),

              Expanded(
                flex: 4,
                  child: Container(
                    height: size.height*0.5,
                    width: size.width,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(25),topRight: Radius.circular(25),),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 25,right: 25.0,top: 20,bottom: 5),
                      child: ListView(
                        children: [
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                 Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(widget.PizzaName.toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                                    Text(widget.Pizzaprice.toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                                  ],),
                                const SizedBox(height: 10,),
                                Row(children: [
                                  Icon(Icons.star,color: Colors.orangeAccent.shade100,),
                                  Icon(Icons.star,color: Colors.orangeAccent.shade100,),
                                  Icon(Icons.star,color: Colors.orangeAccent.shade100,),
                                  Icon(Icons.star,color: Colors.orangeAccent[200],),
                                  const Text(' 4.6 Rating',style: TextStyle(fontWeight: FontWeight.bold),)
                                ],),
                                const SizedBox(height: 10,),
                                const Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Ingredients',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                                    Row(children: [
                                      Icon(Icons.alarm_on_outlined,color: Colors.black,),
                                      Text(' 20-25 minutes',style: TextStyle(fontWeight: FontWeight.bold),)

                                    ],),
                                  ],),
                                const SizedBox(height: 10,),
                                 Text(widget.PizzaingredientsName.toString(),
                                  style: const TextStyle(fontWeight: FontWeight.w400,fontSize: 14),),
                                const SizedBox(height: 10,),
                                Center(
                                  child: Container(
                                      height: size.height*0.05,
                                      width: size.width*0.35,
                                      decoration:  BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: const BorderRadius.all(Radius.circular(8)),
                                          border: Border.all()
                                      ),
                                      child:  Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          IconButton(onPressed: (){
                                            if(quantity> 1){
                                              setState(() {
                                                quantity--;
                                              });
                                            }
                                          }, icon: const Icon(Icons.remove,size: 25,)),
                                           Text(quantity.toString(),style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color: Colors.orangeAccent)),
                                          IconButton(onPressed: (){
                                              setState(() {
                                                quantity++;
                                              });
                                          }, icon: const Icon(Icons.add,size: 25,)),
                                        ],)


                                  ),
                                ),
                                const SizedBox(height: 10,),
                               Visibility(
                                   visible:  widget.categoryType == 'burger'? false : true,
                                   child: const Text('Select Size',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),)),
                                 Visibility(
                                  visible: widget.categoryType == 'burger'? false : true,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Transform.scale(
                                        scale: 1,
                                        child: Radio(
                                          value: 1, groupValue: val, onChanged: (value){
                                          setState(() {
                                            val = value!;
                                          });
                                        },
                                          activeColor: Colors.black,


                                        ),
                                      ),
                                      const Text('Small',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14)),
                                      const SizedBox(width: 10,),
                                      Transform.scale(
                                        scale: 1,
                                        child: Radio(
                                          value: 2, groupValue: val, onChanged: (value){
                                          setState(() {
                                            val = value!;
                                          });
                                        },
                                          activeColor: Colors.black,


                                        ),
                                      ),
                                      const Text('Medium',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14)),
                                      const SizedBox(width: 10,),
                                      Transform.scale(
                                        scale: 1,
                                        child: Radio(
                                          value: 3, groupValue: val, onChanged: (value){
                                          setState(() {
                                            val = value!;
                                          });
                                        },
                                          activeColor: Colors.black,


                                        ),
                                      ),
                                      const Text('Large',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14)),
                                    ],
                                  ),
                                ),
                                const Text('Extras',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                                Row(children: [
                                  Transform.scale(
                                    scale: 1,
                                    child: Radio(
                                      value: 4, groupValue: valu, onChanged: (value){
                                      setState(() {
                                        valu = value!;
                                      });
                                    },
                                      activeColor: Colors.black,

                                    ),
                                  ),
                                  const Text('Dip Sauce',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14)),
                                ],),
                                const SizedBox(height: 10,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                  // GestureDetector(
                                  //   onTap: (){
                                  //     Get.to(MyCart());
                                  //   },
                                  //   child: Container(
                                  //     width: size.width*0.2,
                                  //     height: 50,
                                  //     decoration: BoxDecoration(
                                  //       borderRadius: BorderRadius.circular(5),
                                  //       color: Colors.grey[300],
                                  //     ),
                                  //     child: const Icon(Icons.shopping_cart,size: 30),
                                  //   ),
                                  // ),
                                  // const SizedBox(width: 10,),
                                  Container(
                                    height: size.height*0.06,
                                    width: size.width*0.65,
                                    child: GlobalButton(
                                        onTap: (){
                                     cartDataToDatabase();
                                      Get.to(InformationScreen(
                                        itemPrice: widget.Pizzaprice.toString(),
                                        delivery: '',
                                        total: '',
                                      ));
                                    }, text: 'Add to cart'
                                        , color: Colors.black),
                                  )
                                ],)
                              ]),
                        ],
                      ),
                    ),
                  )),
            ],),


      ]),
    );
  }
  void cartDataToDatabase() async{
    String? userUid = FirebaseAuth.instance.currentUser?.uid;
    String? cartID = FirebaseFirestore.instance.collection("Users").doc().id.toString();
    FirebaseFirestore.instance.collection('Users').doc(userUid).collection('cart')
        .doc(cartID).set({
      "cartID" : cartID.toString(),
      FirebasePaths.KEY_NAME  : widget.PizzaName.toString(),
      FirebasePaths.KEY_IMAGE : widget.PizzaMainImage.toString(),
      FirebasePaths.KEY_DESC : widget.PizzaingredientsName.toString(),
      FirebasePaths.KEY_PRICE : widget.Pizzaprice.toString(),
      FirebasePaths.KEY_QUANTITY : quantity.toString(),
      "Size": getSize(),
      "Extras": getExtras(),

    }).whenComplete(() {
      Get.snackbar("Added to cart", 'Successfully');
      //Get.to(MyCart(),
      //);
    });
  }
  String getSize() {
    switch (val) {
      case 1:
        return "Small";
      case 2:
        return "Medium";
      case 3:
        return "Large";
      default:
        return "";
    }
  }

  List<String> getExtras() {
    List<String> selectedExtras = [];

    if (valu == 4) {
      selectedExtras.add("Dip Sauce");
    }

    // Add more conditions for other extras if needed

    return selectedExtras;
  }
  void checkFavorite(id,price,name,desc,image) {
    String? credential = FirebaseAuth.instance.currentUser?.uid.toString();
    FirebaseFirestore.instance.collection(FirebasePaths.COLLECTION_USERS).doc(credential).collection(FirebasePaths.COLLECTION_FAVOURITE)
        .doc(id).set({
      FirebasePaths.KEY_ID : id,
      FirebasePaths.KEY_PRICE : price,
      FirebasePaths.KEY_NAME :  name,
      FirebasePaths.KEY_DESC : desc,
      FirebasePaths.KEY_IMAGE: image,
      FirebasePaths.KEY_QUANTITY : quantity.toString(),
      "Extras": getExtras(),

    }).whenComplete(() {
      Get.snackbar('Successfully', 'Added to favourite');
    });
  }

  void checkFavourite() {
    String? credential = FirebaseAuth.instance.currentUser?.uid.toString();
     FirebaseFirestore.instance.collection(FirebasePaths.COLLECTION_USERS)
    .doc(credential)
    .collection(FirebasePaths.COLLECTION_FAVOURITE)
    .doc(widget.id.toString()).get().then((value) {
      if(value.exists){
        setState(() {
          favouriteIcon = Icons.favorite;
        });
      }else{

       setState(() {
         favouriteIcon = Icons.favorite_border;
       });
      }
     });
  }
}
