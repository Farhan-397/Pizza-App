import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pizza_app/screens/cardInfo/card_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TrackOrder extends StatefulWidget {
  const TrackOrder({super.key});

  @override
  State<TrackOrder> createState() => _TrackOrderState();
}

class _TrackOrderState extends State<TrackOrder> {
  late Map<String, String> userData = {};


@override
  void initState() {
    // TODO: implement initState
    super.initState();
    getViaSpUserData();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Track Order'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          const Text('Order Information',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
          Container(
          width: Get.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.grey[200],
          ),
            child:  Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.0,vertical: 8),
                child: Row(children: [
                  Icon(Icons.timer,color: Colors.orangeAccent,),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text('Delivery Time: ',style: TextStyle(fontWeight: FontWeight.bold,),),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text('9:39 ',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.orangeAccent),),
                  ),

                ],),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.0,vertical: 8),
                child: Row(children: [
                  Icon(Icons.location_on,color: Colors.orangeAccent,),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text('Delivery Address: ',style: TextStyle(fontWeight: FontWeight.bold,),),
                  ),

                ],),
              ),
                  Padding(
                    padding: EdgeInsets.only(left: 60.0,right: 15,),
                    child: Text(userData['street'] != null
                        ? userData['street']!
                        : 'Default'),
                  ),
                Padding(
                 padding: EdgeInsets.only(left: 60.0,right: 15),
                 child: Text(userData['sector'] != null
                     ? userData['sector']!
                     : 'Default',) ,
               ),
                  Padding(
                    padding: EdgeInsets.only(left: 60.0,right: 15),
                    child: Text(userData['city'] != null
                        ? userData['city']!
                        : 'Default',),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0,vertical: 10.0),
                    child: Container(
                      height: 70,
                      width: Get.width,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                      color: Colors.grey[100],
                      ),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,

                          children: [
                        Row(

                          children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Container(
                              padding: EdgeInsets.all(8),
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(10)
                                ),
                                child: Image.asset('assets/images/person.png',)
                            ),
                          ),
                          const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Ahmad Raza',style: TextStyle(fontWeight: FontWeight.bold),),
                              SizedBox(height: 4,),
                              Text('Delivery Boy',style: TextStyle(
                                  color: Colors.grey
                              ),),
                            ],),
                        ],),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: GestureDetector(
                            onTap: (){
                            },
                            child: Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                                color: Colors.grey,
                              ),
                              child: const Icon(Icons.call,color: Colors.orangeAccent),
                            ),
                          ),
                        ),
                      ]),
                    ),
                  )

            ]),
          )
        ],),
      ),
    );
  }
  Future<void> getViaSpUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String street = prefs.getString('street') ?? 'Default';
    final String sector = prefs.getString('sector') ?? 'Error';
    final String city = prefs.getString('city') ?? 'Error';

    setState(() {
      userData = {
        'street' : street.toString(),
        'sector': sector.toString(),
        'city' : city.toString()};
    });
  }
}
