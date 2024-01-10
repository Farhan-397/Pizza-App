
import 'package:bottom_bar_matu/bottom_bar_item.dart';
import 'package:bottom_bar_matu/bottom_bar_label_slide/bottom_bar_label_slide.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pizza_app/components/Button.dart';
import 'package:pizza_app/components/firebasepaths.dart';
import 'package:pizza_app/screens/HomeScreen/confirmation_Screen.dart';
import 'package:pizza_app/screens/create_acc/login_screen.dart';
import 'package:pizza_app/screens/trackorder/track_order.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../adddress/addressScreen.dart';
import '../cart/cart.dart';
import '../favourite/favorite.dart';
import '../setting/SettingScreen.dart';

class HomeScreen extends StatefulWidget {

  const HomeScreen({super.key,});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final int bottomBarIndex = 0;
   bool  isfavorite = false;



  var selectBrandColor;
  late Map<String, String> userData = {};
  String userName = '';
  String userEmail = '';
  String userPhone = '';
  String userImage = '';
  String userType = '';
  var categoryType = 'all';
  TextEditingController phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Builder(builder: (BuildContext context){
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: (){
                Scaffold.of(context).openDrawer();},
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.amber,
                ),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(userImage.toString()))
                //Image.asset('assets/images/person.png'),
              ),
            ),
          );
        }),
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Welcome!'),
            const SizedBox(height: 4),
            Text('$userName'.toString().toUpperCase(),
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.black,
              ),
            ),
          ],
        ),
        centerTitle: false,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap:  (){
              },
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: const Icon(Icons.notifications, color: Colors.black),
              ),
            ),
          ),

        ],

      ),
      drawer: Drawer(
        elevation: 3,
        width: size.width * 0.79,
        backgroundColor: Colors.black,

        child: ListView(
          children: [
            DrawerHeader(
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.amber,
                      ),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(userImage.toString())),
                      //Image.asset('assets/images/person.png'),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Text(userName.toString(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.white
                      ),
                      ),
                    ),
                  ],
                )),
            ListTile(
              leading: const Icon(Icons.person,
                  color: Colors.white, size: 18),
              title: Text(userName.toString(),
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.white
                ),
              ),

              trailing: const Icon(Icons.edit, color: Colors.white),
            ),
            ListTile(
              leading: const Icon(Icons.mail,
                  color: Colors.white, size: 18),
              title: Text(userEmail.toString(),
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.white
                ),
              ),
              trailing: const Icon(Icons.edit, color: Colors.white),
            ),
             ListTile(
              leading: const Icon(Icons.call,
                  color: Colors.white, size: 22),
              title: userPhone.toString() == "null" ?
              const Text("set phone number",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Colors.white
              ),) :
              Text(userPhone.toString(),
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.white
                ),
              ),
              trailing: GestureDetector(
                  onTap: (){
                    Get.bottomSheet(
                      Container(
                        color: Colors.white,
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10.0),
                              child: Container(
                                color: Colors.grey[100],
                                child: TextField(
                                  controller: phoneController,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      hintText: "e.g: 03001234567",
                                      hintStyle: const TextStyle(
                                        color: Colors.grey,
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide.none,
                                        gapPadding: 0,
                                      ),
                                    )
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 25.0,vertical: 15.0),
                              child: GlobalButton(onTap: (){
                                setPhoneNumber();
                              }, text: 'Update Phone Number', color: Colors.black),
                            ),

                          ],
                        ),
                      ));
                  },
                  child: const Icon(Icons.edit, color: Colors.white)),
            ),
             ListTile(
              onTap: (){Get.to(const AddressScreen());},
              leading: const Icon(
                  Icons.settings, color: Colors.white, size: 22),
              title: const Text('Addresses',
                  style: TextStyle(color: Colors.white,fontSize: 14)),
            ),
             ListTile(
              onTap: (){Get.to(const SettingScreen());},
              leading: const Icon(Icons.settings,
                  color: Colors.white, size: 22),
              title: const Text('Setting',
                  style: TextStyle(color: Colors.white,fontSize: 14)),
            ),
            const Divider(),
            SizedBox(height: size.height * 0.012),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 5.0,),
              child: GlobalButton(
                  onTap: () async {
                    await GoogleSignIn().signOut();
                    await FirebaseAuth.instance.signOut().whenComplete(() {
                      Get.to(const LoginScreen());
                      clearPrefsData();
                    });

                  },
                  text: 'Log Out',
                  color: Colors.grey),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 5.0),
              child: GlobalButton(
                  onTap: ()  {
                    deleteUser();
                      Get.to(const LoginScreen());
                  },
                  text: 'Delete Account',
                  color: Colors.grey),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: size.height * 0.03),
              SizedBox(
                height: 150,
                width: 350,
                child:  StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('Banner')
                    .snapshots(),
                builder: (context, snapShots) {
                return (snapShots.connectionState == ConnectionState.waiting)
                ? const Center(child: CircularProgressIndicator(color: Colors.amber,))
                    : CarouselSlider.builder(
                  itemCount: snapShots.data?.docs.length,
                  itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) {
                    var banner = snapShots.data?.docs[itemIndex].data() as Map<String, dynamic>;
                    return ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(banner['image'], fit: BoxFit.cover));
                  },
                  options: CarouselOptions(
                      height: 200.0,
                      scrollPhysics: const BouncingScrollPhysics(),
                      enlargeCenterPage: true,
                      autoPlay: true,
                      aspectRatio: 16 / 9,
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enableInfiniteScroll: false,
                      autoPlayAnimationDuration:
                      const Duration(milliseconds: 600),
                      viewportFraction: 0.8,
                    ),
                );
              }),
              ),
              SizedBox(height: size.height * 0.03),
              const Text('Our Categories',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              Row(
                children: [
                  SizedBox(
                    height: size.height * 0.12,
                    width: size.width/1.18,
                    child:
                    StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection("Categories")
                            .snapshots(),
                        builder: (context, snapShots) {
                          return (snapShots.connectionState ==
                              ConnectionState.waiting)
                              ? const Center(
                            child: CircularProgressIndicator(
                              color: Colors.amber,
                            ),
                          )
                              : ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  physics: const BouncingScrollPhysics(),
                                  itemCount: snapShots.data?.docs.length,
                                  itemBuilder: (ctx, index) {
                                    var category = snapShots.data?.docs[index]
                                        .data() as Map<String, dynamic>;

                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            selectBrandColor =
                                                category['name'].toString();
                                            categoryType = category['name'].toString().toLowerCase();
                                          });
                                        },
                                        child: Container(
                                          height: 80,
                                          width: 60,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(5),
                                            color: selectBrandColor ==
                                                category['name'].toString()
                                                ? Colors.black
                                                : Colors.white,
                                          ),
                                          child: Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              children: [
                                                Image.network(
                                                  category['image'],
                                                  width: 30,
                                                  height: 25,
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                    category['name']
                                                        .toString()
                                                        .toUpperCase(),
                                                    style: TextStyle(
                                                        color: selectBrandColor ==
                                                            category['name']
                                                                .toString()
                                                            ? Colors.white
                                                            : Colors.black)),
                                              ]),
                                        ),
                                      ),
                                    );
                                  });
                        }),
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.02),
              SizedBox(
                height: size.height * 0.4,
                width: size.width,
                child:  categoryType.toString().toLowerCase() == 'all'.toLowerCase()?
                StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance.collection(FirebasePaths.COLLECTION_PRODUCT)
                        .snapshots(),
                    builder: (context, snapShots) {
                      return (snapShots.connectionState == ConnectionState.waiting)
                          ? const Center(child: CircularProgressIndicator(color: Colors.amber,))
                          : GridView.builder(
                          gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 1/1.2,
                          ),
                          itemCount: snapShots.data?.docs.length,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) {
                            var product = snapShots.data?.docs[index].data() as Map<String, dynamic>;
                            return GestureDetector(
                                  onTap: () {
                                    Get.to(ConfirmationScreen(
                                      Pizzaprice:
                                      product[FirebasePaths.KEY_PRICE].toString(),
                                      PizzaMainImage: product[FirebasePaths.KEY_IMAGE],
                                      PizzaName: product[FirebasePaths.KEY_NAME].toString(),
                                      PizzaingredientsName: product[FirebasePaths.KEY_DESC].toString(),
                                      id: product[FirebasePaths.KEY_ID],
                                      categoryType: product['categoryType'].toString(),
                                    ));
                                  },

                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 12.0,right: 18,top: 5),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5)
                                  ),
                                  child: Stack(
                                      children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 30),
                                        child: Container(
                                                      height: size.height * 0.30,
                                                      decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                          BorderRadius.circular(8)),
                                                    ),
                                      ),
                                      Align(
                                        alignment: Alignment.topCenter,
                                        child: Image.network(
                                          product[FirebasePaths.KEY_IMAGE].toString(),
                                          height: 100,
                                          width: 100,
                                          fit: BoxFit.cover,

                                                    ),
                                      ),
                                      Positioned(
                                        top: 110,
                                        left: 10,
                                        child: Text(
                                        product[FirebasePaths.KEY_NAME].toString().toUpperCase(),
                                        style: const TextStyle(
                                        overflow: TextOverflow.clip,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                        )),
                                      Positioned(
                                        top: 130,
                                        left: 11,
                                        child: Text(
                                          product[FirebasePaths.KEY_DESC].toString(),
                                          style: const TextStyle(
                                              overflow: TextOverflow.clip,
                                              fontSize: 12),
                                        )),
                                      Positioned(
                                              top: 150,
                                              left: 3,
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(
                                                    horizontal: 10.0),
                                                child: Text(
                                                  'RS ${product[FirebasePaths.KEY_PRICE]}'
                                                      .toString(),
                                                  style: const TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                              ),
                                            ),
                                          ]),
                                ),
                              ),
                            );
                          });
                    }) :
                StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance.collection(FirebasePaths.COLLECTION_PRODUCT)
                          .where('categoryType', isEqualTo: categoryType.toString().toLowerCase())
                        .snapshots(),
                    builder: (context, snapShots) {
                      return (snapShots.connectionState == ConnectionState.waiting)
                          ? const Center(child: CircularProgressIndicator(color: Colors.amber,))
                          : GridView.builder(
                          gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 1/1.2,
                          ),
                          itemCount: snapShots.data?.docs.length,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) {
                            var product = snapShots.data?.docs[index].data() as Map<String, dynamic>;
                            return GestureDetector(
                              onTap: () {
                                Get.to(ConfirmationScreen(
                                  Pizzaprice:
                                  product[FirebasePaths.KEY_PRICE].toString(),
                                  PizzaMainImage: product[FirebasePaths.KEY_IMAGE],
                                  PizzaName: product[FirebasePaths.KEY_NAME].toString(),
                                  PizzaingredientsName: product[FirebasePaths.KEY_DESC].toString(),
                                  id: product[FirebasePaths.KEY_ID],
                                  categoryType: product['categoryType'].toString().toLowerCase(),
                                ));
                              },

                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 12.0,right: 18,top: 5),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5)
                                  ),
                                  child: Stack(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(top: 30),
                                          child: Container(
                                            height: size.height * 0.30,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                BorderRadius.circular(8)),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.topCenter,
                                          child: Image.network(
                                            product[FirebasePaths.KEY_IMAGE].toString(),
                                            height: 100,
                                            width: 100,
                                            fit: BoxFit.cover,

                                          ),
                                        ),
                                        Positioned(
                                            top: 110,
                                            left: 10,
                                            child: Text(
                                              product[FirebasePaths.KEY_NAME].toString().toUpperCase(),
                                              style: const TextStyle(
                                                  overflow: TextOverflow.clip,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16),
                                            )),
                                        Positioned(
                                            top: 130,
                                            left: 11,
                                            child: Text(
                                              product[FirebasePaths.KEY_DESC].toString(),
                                              style: const TextStyle(
                                                  overflow: TextOverflow.ellipsis,
                                                  fontSize: 14),
                                            )),
                                        Positioned(
                                          top: 150,
                                          left: 3,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10.0),
                                            child: Text(
                                              'RS ${product[FirebasePaths.KEY_PRICE]}'
                                                  .toString(),
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16),
                                            ),
                                          ),
                                        ),
                                      ]),
                                ),
                              ),
                            );
                          });
                    })
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomBarLabelSlide(
        backgroundColor: Colors.black,
        color: Colors.orangeAccent,
        selectedIndex: bottomBarIndex,
        height: size.height * 0.082,
        items: [
          BottomBarItem(iconData: Icons.home, label: 'Home'),
          BottomBarItem(iconData: Icons.favorite, label: 'Favourite'),
          BottomBarItem(iconData: Icons.map_outlined, label: 'Maps'),
          BottomBarItem(iconData: Icons.shopping_cart, label: 'Cart'),
        ],
        onSelect: (index) {
          switch (index) {
            case 0:
              Get.to( const HomeScreen(
              ));
              break;
            case 1:
              Get.to(const FavouriteScreen());
              break;
            case 2:
              Get.to(const TrackOrder());
              break;
              case 3:
            // Navigate to Cart screen
              Get.to( MyCart());
              break;
          }
        },
      ),
    );
  }
//getting through shared preferences
  void getUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    userName = prefs.getString(SharedPref.PREF_NAME)!;
    userEmail = prefs.getString(SharedPref.PREF_EMAIL)!;
    userPhone = prefs.getString(SharedPref.PREF_PHONE,)!;
    userImage = prefs.getString(SharedPref.PREF_IMAGE)!;
    userType = prefs.getString(SharedPref.PREF_TYPE)!;
    setState(() {});
  }
  void setPhoneNumber() async{
      String? UID=  FirebaseAuth.instance.currentUser?.uid;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(SharedPref.PREF_PHONE, phoneController.text.toString())
        .whenComplete(() {
      FirebaseFirestore.instance.collection(FirebasePaths.COLLECTION_USERS)
          .doc(UID)
          .update(
        {
          'phone': phoneController.text.toString(),
        }
      ).whenComplete(() {
        setState(() {
          userPhone = prefs.getString( SharedPref.PREF_PHONE,)!;
        });
        Get.back();
      });

    });
  }
  void deleteUser() async{
        String? userUid = FirebasePaths.UID;
        User? user = FirebaseAuth.instance.currentUser;
    if(user !=null){
      await FirebaseFirestore.instance.collection("Users")
          .doc(userUid)
          .delete().whenComplete(() async {
        Get.to(const LoginScreen());
        Get.snackbar("user Deleted", 'Successfully');
        await user.delete();
        clearPrefsData();
      });
    }

  }

  void clearPrefsData() async{
    SharedPreferences prefs =  await SharedPreferences.getInstance();
    prefs.clear();

  }



}
