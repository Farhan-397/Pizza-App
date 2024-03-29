import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pizza_app/components/firebasepaths.dart';
import 'package:pizza_app/screens/HomeScreen/Home_Screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../components/Button.dart';

class CardInfo extends StatefulWidget {
  final String itemPrice,delivery,total;
   CardInfo({super.key, required this.delivery, required this.itemPrice, required this.total});

  @override
  State<CardInfo> createState() => _CardInfoState();
}

class _CardInfoState extends State<CardInfo> {
  TextEditingController cardNameController =  TextEditingController();
  TextEditingController cardNumberController =  TextEditingController();
  TextEditingController expiryDateController = TextEditingController();
  TextEditingController securityController =  TextEditingController();

  int val = 1;
  bool cardvisibility = false;
  bool cardvisibility2 = true;
  var cardName  = "";
  var cardNumber = "";
  var expiryDate = "";
  var security = "";

  @override
  late Map<String, String> userSpData = {};

  bool isSaveCard = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCardDetails();
    getViaSpUserData();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(title: const Text('Card Information'),
      centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body:  SingleChildScrollView(
        child: Column(
            children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              const Text('Choose a payment method',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
              const Text('You will not be charges until you received the order confirmation',),
                const SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Transform.scale(
                      scale: 1,
                      child: Radio(
                        value: 2, groupValue: val, onChanged: (value){
                        setState(() {
                          val = value!;
                          if(val == 2){
                            cardvisibility = true;
                            cardvisibility2 = false;
                          }
                        });
                        },
                        activeColor: Colors.black,
                      
                      
                      ),
                    ),
                    const Text('Credit Card',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),
                    Transform.scale(
                      scale: 1,
                      child: Radio(
                        value: 1, groupValue: val, onChanged: (value){
                        setState(() {
                          val = value!;
                          if(val == 1){
                            cardvisibility = false;
                            cardvisibility2 = true;
                          }
                        });
                      },
                        activeColor: Colors.black,


                      ),
                    ),
                    const Text('Cash on Delivery',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),
                  ],
                ),
                Visibility(
                  visible: cardvisibility2 ,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Shipping Address  ',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                      const SizedBox(height: 8,),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white,
                        ),
                        child: Row(
                          children: [
                          Column(children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                  width: 110,height: 100,
                                  child: Image.asset('assets/images/person.png',)),
                            )
                          ],),
                          const SizedBox(width: 15,),
                           Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(height: 9,),
                                const Text("Shipping Address",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),
                                const SizedBox(height: 4,),
                                Text(userSpData['street']?? 'Error',style: const TextStyle(fontSize: 16,)),
                                Text(userSpData['sector']?? 'Error',style: const TextStyle(fontSize: 16,)),
                                Text(userSpData['city']?? 'Error',style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                              ],),
                          )
                        ],
                      ),),
                    ],),
                ),
                Visibility(
                  visible: cardvisibility ,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    const Text('Name on card  ',style: TextStyle(fontSize: 20),),
                    const SizedBox(height: 8,),
                    Container(
                      color: Colors.white,
                      child: TextField(
                        controller: cardNameController,
                        decoration: const InputDecoration(
                            hintText: ' Lucky Cross',
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.transparent)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.transparent))),
                      ),
                    ),
                    const SizedBox(height: 8,),
                    const Text('Card Number',style: TextStyle(fontSize: 20),),
                    const SizedBox(height: 8,),
                    Container(
                      color: Colors.white,
                      child: TextField(
                        controller: cardNumberController,
                        decoration: const InputDecoration(
                            hintText: ' *************',
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.transparent)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.transparent))),
                      ),
                    ),
                    const SizedBox(height: 8,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Expiry Date',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                            const SizedBox(height: 6,),
                            Container(
                              width: Get.width/2.5,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                              ),
                              child: TextField(
                                controller: expiryDateController,
                                decoration: const InputDecoration(
                                    hintText: ' 05/25',
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.transparent)),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.transparent))),
                              ),
                            ),
                          ],),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Security Code',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                            const SizedBox(height: 6,),

                            Container(
                              width: Get.width/2.5,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                              ),
                              child: TextField(
                                controller: securityController,
                                decoration: const InputDecoration(
                                    hintText: ' 176 ',
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.transparent)),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.transparent))),
                              ),
                            ),
                          ],),
                      ],),
                      Row(children: [
                        Text('Remember card: ',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500)),
                        Checkbox(
                            activeColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            value: isSaveCard, onChanged: (bool? value){
                          setState(() {
                            isSaveCard = value!;
                            saveCardDetails();
                          });
                        }),
                      ],)
                  ],),
                ),

              ],),
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
                        Text(widget.itemPrice.toString(),style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
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
                        Text(widget.delivery.toString(),style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                      ],),
                    const SizedBox(height: 15,),

                    const Divider(
                      color: Colors.black,
                    ),
                    const SizedBox(height: 15,),

                     Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Total",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                        Text(widget.total.toString(),style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                      ],),
                    const SizedBox(height: 25,),
                    GlobalButton(onTap: (){
                      Get.defaultDialog(

                        content: const Center(
                          child: Column(
                            children: [
                              Icon(
                                Icons.check_circle,
                                color: Colors.green,
                                size: 50,
                              ),
                              SizedBox(height: 20),
                              Text(
                                'Your Order will be Delivered to you in 20-30 minutes',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        title: 'Thank You!',
                        titleStyle: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        backgroundColor: Colors.white,
                        radius: 16.0,

                      ).whenComplete(() {
                        Get.to(const HomeScreen());
                      });
                    }, text: 'Pay', color: Colors.black)
                  ]),
                ),
              )

            ]),
      ),
    );
  }
  Future<void> getViaSpUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String street = prefs.getString('street') ?? 'Default';
    final String sector = prefs.getString('sector') ?? 'Error';
    final String city = prefs.getString('city') ?? 'Error';

    setState(() {
      userSpData = {
        'street' : street.toString(),
        'sector': sector.toString(),
        'city' : city.toString()};
    });
  }

  void saveCardDetails() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
     prefs.setString('cardName', cardNameController.text);
     prefs.setString('cardNumber', cardNumberController.text);
    prefs.setString('expiryDate', expiryDateController.text);
     prefs.setString('securityCode', securityController.text);
      prefs.setBool('saveCardDetails', isSaveCard).whenComplete(() {

      FirebaseFirestore.instance.collection(FirebasePaths.COLLECTION_USERS)
          .doc(FirebasePaths.UID)
          .collection('card_details')
          .doc(FirebasePaths.autoId)
          .set({
        'cardName': cardNameController.text.toString(),
        'cardNumber': cardNumberController.text.toString(),
        'expiryDate': expiryDateController.text.toString(),
      'securityCode': securityController.text.toString(),
      });
    });
  }
  void getCardDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cardNameController.text = prefs.getString('cardName') ?? '';
    cardNumberController.text = prefs.getString('cardNumber') ?? '';
    expiryDateController.text = prefs.getString('expiryDate') ?? '';
    isSaveCard = prefs.getBool('saveCardDetails') ?? false;
    setState(() {

    });
  }
}
