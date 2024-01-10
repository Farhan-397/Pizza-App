import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pizza_app/components/Button.dart';
import 'package:pizza_app/components/firebasepaths.dart';
import 'package:pizza_app/screens/adddress/add_address_Screen.dart';
import 'package:pizza_app/screens/cardInfo/card_info.dart';
import 'package:pizza_app/screens/promocode/promo_code.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InformationScreen extends StatefulWidget {
  final  String itemPrice,delivery,total;
  const InformationScreen({super.key, required this.itemPrice, required this.delivery, required this.total});

  @override
  State<InformationScreen> createState() => _InformationScreenState();
}

class _InformationScreenState extends State<InformationScreen> {
 
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController descController = TextEditingController();
  String userName = '';
  String userPhone = '';
  String userStreet = '';
  String userSector = '';
  String userCity = '';
  bool isAddressFound = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData();
    addressCheck();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Information',style: TextStyle(fontWeight: FontWeight.bold,)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Container(
                  width: size.width*0.85,
                  // height: size.height*0.18,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(11),
                    color: Colors.white
                  ),
                  child: Row(children: [
                    Column(children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(color: Colors.grey),
                            width: 110,height: 120,
                            child: Image.asset('assets/images/person.png',)),
                      )
                    ],),
                    const SizedBox(width: 15,),
                   isAddressFound ? Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 3,),
                          Row(children: [
                            const Text("Shipping Address",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),
                            IconButton(
                              icon: const Icon(FontAwesomeIcons.edit),
                              onPressed: (){
                                Get.to(AddAddressScreen());
                              },),
                          ],),
                        Text(userStreet.toString(),style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                        Text(userSector.toString(),style: const TextStyle(fontSize: 16)),
                        Text(userCity.toString() ,style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                      ],),
                    ) : Row(children: [
                     const Text("Shipping Address",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),
                     IconButton(
                       icon: const Icon(FontAwesomeIcons.penToSquare),
                       onPressed: (){
                         Get.to(const AddAddressScreen());
                       },),
                   ],),
                  ],
                    
                  ),
                ),
                    const SizedBox(height: 15,),
                    const Text('Personal Information',style: TextStyle(fontWeight: FontWeight.bold),),
                    const SizedBox(height: 10,),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child:  Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: TextField(
                          controller: nameController,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: Icon(Icons.person),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10,),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child:  Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: TextField(
                          controller: phoneController,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: Icon(Icons.call),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10,),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child:  Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: TextField(
                          maxLines: 3,
                          onTap: (){

                          },
                          controller: descController,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Add a note', 
                            prefixIcon: Icon(Icons.note_alt_sharp,color: Colors.black),
                            contentPadding: EdgeInsets.fromLTRB(24, 12, 12, 12), // Adjust the padding as needed

                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10,),
                    InkWell(
                      onTap: (){
                        Get.to(const PromoCode());
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: Container(
                          width: Get.width,
                          height: Get.height*0.08,
        
                          decoration:
                          BoxDecoration(
                              color: Colors.transparent,
                              borderRadius:BorderRadius.circular(8),
                            border: Border.all(
                              width: 2,
                              color: Colors.orange,
                            )
                          ),
                          child:  const Center(child:  Text('Apply Coupon',style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),)),
                        ),
                      ),
                    )
        
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
                      Text(widget.total.toString() ,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                    ],),
                  const SizedBox(height: 25,),
                  GlobalButton(onTap: (){
                    Get.to(
                        CardInfo(
                          itemPrice: widget.itemPrice.toString(),
                          delivery: widget.delivery.toString(),
                          total: widget.total.toString(),
                  ))
                  ;},
                      text: 'Check Out', color: Colors.black)
                ]),
              ),
            )
          ],
        ),
      ),
    );
  }
 void getUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      userName = prefs.getString(SharedPref.PREF_NAME) ?? 'Default';
      userPhone = prefs.getString(SharedPref.PREF_PHONE) ?? 'No phone Number available';
      phoneController.text = userPhone.toString() ;
      nameController.text = userName.toString() ;
      userStreet = prefs.getString(FirebasePaths.KEY_STREET) ?? 'Default';
      userSector = prefs.getString(FirebasePaths.KEY_SECTOR) ?? 'Error';
      userCity = prefs.getString(FirebasePaths.KEY_CITY) ?? 'Error';
    });

  }

      addressCheck() async{
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        if(prefs.containsKey(FirebasePaths.KEY_STREET)){
          isAddressFound = true;
        }else{
          isAddressFound = false;
        }
      }
}
