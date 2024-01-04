import 'package:banner_carousel/banner_carousel.dart';
import 'package:bottom_bar_matu/bottom_bar/bottom_bar_bubble.dart';
import 'package:bottom_bar_matu/bottom_bar_double_bullet/bottom_bar_double_bullet.dart';
import 'package:bottom_bar_matu/bottom_bar_item.dart';
import 'package:bottom_bar_matu/bottom_bar_label_slide/bottom_bar_label_slide.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pizza_app/components/Button.dart';
import 'package:pizza_app/components/firebasepaths.dart';
import 'package:pizza_app/screens/HomeScreen/confirmation_Screen.dart';
import 'package:pizza_app/screens/adddress/add_address_Screen.dart';
import 'package:pizza_app/screens/create_acc/login_screen.dart';
import 'package:pizza_app/screens/trackorder/track_order.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../adddress/addressScreen.dart';
import '../cart/cart.dart';
import '../favourite/favorite.dart';

class HomeScreen extends StatefulWidget {

  const HomeScreen({Key? key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final int bottomBarIndex = 0;
  Set<String> favoriteProductIds = Set<String>();
   bool  isfavorite = false;

  List pizaaimage = [
    'assets/images/burger-icon.png',
    'assets/images/pizza-icon7.png',
    'assets/images/burger-icon.png',
    'assets/images/french-fries-icon.png',
    'assets/images/pizza-icon7.png',
  ];
  final List<String> imagePaths = [
    'assets/images/Pizza-Banner.jpeg',
    'assets/images/Pizza-Banner.jpeg',
    'assets/images/Pizza-Banner.jpeg',
  ];
  var selectBrandColor;
  late Map<String, String> userData = {};
  var categoryType = 'all';

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
          return GestureDetector(
            onTap: (){Scaffold.of(context).openDrawer();},
            child: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.amber,
              ),
              child: Image.asset('assets/images/person.png'),
            ),
          );
        }),
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Welcome!'),
            const SizedBox(height: 4),
            Text(
                userData['name'] != null
                    ? userData['name']!.toUpperCase()
                    : 'Default',
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 18)),
          ],
        ),
        actions: [
          GestureDetector(
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
                      child: Image.asset('assets/images/person.png'),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                        userData['email'] != null
                            ? userData['email']!
                            : 'Default' ,
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                  ],
                )),
            ListTile(
              leading: const Icon(Icons.person,
                  color: Colors.white, size: 18),
              title: Text(userData['name']?.toUpperCase() != null
                  ? userData['name']!
                  : 'Default',
                  style: const TextStyle(
                      color: Colors.white,)),
              trailing: const Icon(Icons.edit, color: Colors.white),
            ),
            ListTile(
              leading: const Icon(Icons.mail,
                  color: Colors.white, size: 18),
              title: Text(userData['email'] ?? '',
                  style: const TextStyle(color: Colors.white)),
              trailing: const Icon(Icons.edit, color: Colors.white),
            ),
             ListTile(
              leading: const Icon(Icons.call,
                  color: Colors.white, size: 22),
              title: Text(
                userData['phone'] ?? '',
                style: const TextStyle(color: Colors.white),
              ),
              trailing: const Icon(Icons.edit, color: Colors.white),
            ),
             ListTile(
              onTap: (){Get.to(AddressScreen());},
              leading: const Icon(Icons.settings,
                  color: Colors.white, size: 22),
              title: const Text('Addresses',
                  style: TextStyle(color: Colors.white)),
            ),
            const ListTile(
              leading: Icon(Icons.settings,
                  color: Colors.white, size: 22),
              title: Text('Setting',
                  style: TextStyle(color: Colors.white)),
            ),
            SizedBox(height: size.height * 0.26),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: GlobalButton(
                  onTap: () async {
                    await FirebaseAuth.instance.signOut().whenComplete(() {
                      Get.to(const LoginScreen());
                    });
                  },
                  text: 'Log Out',
                  color: Colors.black),
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
              // ListTile(
              //   onTap: (){},
              //   leading: Builder(builder: (BuildContext context){
              //     return GestureDetector(
              //       child: Container(
              //         height: 50,
              //         width: 50,
              //         decoration: BoxDecoration(
              //           borderRadius: BorderRadius.circular(10),
              //           color: Colors.amber,
              //         ),
              //         child: Image.asset('assets/images/person.png'),
              //       ),
              //     );
              //   }),
              //   title: Column(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       const Text('Welcome!'),
              //       const SizedBox(height: 4),
              //       Text(
              //           userData['name'] != null
              //               ? userData['name']!.toUpperCase()
              //               : 'Default',
              //           style: const TextStyle(
              //               fontWeight: FontWeight.bold, fontSize: 18)),
              //     ],
              //   ),
              //   trailing: GestureDetector(
              //     onTap:  (){
              //     },
              //     child: Container(
              //       height: 50,
              //       width: 50,
              //       decoration: BoxDecoration(
              //         borderRadius: BorderRadius.circular(10),
              //         color: Colors.white,
              //       ),
              //       child: const Icon(Icons.notifications, color: Colors.black),
              //     ),
              //   ),
              // ),
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
                  GestureDetector(
                    onTap: () {
                      setState(() {
                      selectBrandColor = categoryType.toString();
                      categoryType = 'All';
                      });
                      },
                    child: Container(
                      height: size.height * 0.12,
                      width: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: selectBrandColor ==
                          'All'
                            ? Colors.black
                            : Colors.white,
                      ),
                      child: Column(
                          mainAxisAlignment:
                          MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/fast-food.png',
                              width: 30,
                              height: 25,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                                'All',
                                style: TextStyle(
                                    color: selectBrandColor ==
                                        'All'
                                        ? Colors.white
                                        : Colors.black)),
                          ]),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.12,
                    width: size.width/1.4,
                    child: StreamBuilder<QuerySnapshot>(
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

                            // return Padding(
                            //   padding: const EdgeInsets.only(bottom: 8.0,top: 10),
                            //   child: GestureDetector(
                            //     onTap: () {
                            //       Get.to(ConfirmationScreen(
                            //         Pizzaprice:
                            //         product[FirebasePaths.KEY_PRODUCT_PRICE].toString(),
                            //         PizzaMainImage: product[FirebasePaths.KEY_PRODUCT_IMAGE],
                            //         PizzaName: product[FirebasePaths.KEY_PRODUCT_NAME].toString(),
                            //         PizzaingredientsName: product[FirebasePaths.KEY_PRODUCT_DESC].toString(),
                            //         id: product[FirebasePaths.KEY_PRODUCT_ID],
                            //       ));
                            //     },
                            //     child: Container(
                            //       color: Colors.red,
                            //       height: size.height * 0.32,
                            //       width: 170,
                            //       child: Stack(
                            //           alignment: Alignment.bottomCenter,
                            //           children: [
                            //             Container(
                            //               height: size.height * 0.20,
                            //               width: size.width * 0.36,
                            //               decoration: BoxDecoration(
                            //                   color: Colors.white,
                            //                   borderRadius:
                            //                   BorderRadius.circular(8)),
                            //             ),
                            //             Positioned(
                            //                 left: 25,
                            //                 top: -10,
                            //                 right: 25,
                            //                 child: Padding(
                            //                   padding: const EdgeInsets.symmetric(
                            //                       horizontal: 12.0,),
                            //                   child: Container(
                            //                     color: Colors.red,
                            //                     child: Image.network(
                            //                       product[FirebasePaths.KEY_PRODUCT_IMAGE].toString(),
                            //                       height: 110,
                            //                       width: 100,
                            //
                            //                     ),
                            //                   ),
                            //                 )),
                            //             Positioned(
                            //                 top: 90,
                            //                 left: 25,
                            //                 child: Text(
                            //                   product[FirebasePaths.KEY_PRODUCT_NAME].toString(),
                            //                   style: const TextStyle(
                            //                       overflow: TextOverflow.clip,
                            //                       fontWeight: FontWeight.bold,
                            //                       fontSize: 14),
                            //                 )),
                            //             Positioned(
                            //                 top: 112,
                            //                 left: 25,
                            //                 child: Text(
                            //                   product[FirebasePaths.KEY_PRODUCT_DESC].toString(),
                            //                   style: const TextStyle(
                            //                       overflow: TextOverflow.clip,
                            //                       fontSize: 12),
                            //                 )),
                            //             Positioned(
                            //               top: 130,
                            //               left: 20,
                            //               right: 15,
                            //               child: Padding(
                            //                 padding: const EdgeInsets.symmetric(
                            //                     horizontal: 10.0),
                            //                 child: Text(
                            //                   product[FirebasePaths.KEY_PRODUCT_PRICE]
                            //                       .toString(),
                            //                   style: const TextStyle(
                            //                       fontWeight: FontWeight.bold,
                            //                       fontSize: 18),
                            //                 ),
                            //               ),
                            //             ),
                            //           ]),
                            //     ),
                            //   ),
                            // );
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
              Get.to( HomeScreen(
              ));
              break;
            case 1:
              Get.to(const FavouriteScreen());
              break;
            case 2:
              Get.to(TrackOrder());
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
  Future<void> getUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String name = prefs.getString('user_name') ?? 'Default';
    final String email = prefs.getString('user_email') ?? '';
    final String phone = prefs.getString('user_phone_number') ?? '';

    setState(() {
      userData = {
        'name': name.toString(),
        'email': email.toString(),
        'phone':phone.toString()};
    });
  }



}
