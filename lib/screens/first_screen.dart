import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pizza_app/components/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../components/next button.dart';
import '../components/onboarding.dart';
import '../components/primary_Button.dart';
import '../components/skip_button.dart';
import 'HomeScreen/Home_Screen.dart';
import 'create_acc/login_screen.dart';

class DoorHubOnboardingScreen extends StatefulWidget {
  const DoorHubOnboardingScreen({Key? key}) : super(key: key);

  @override
  DoorHubOnboardingScreenState createState() => DoorHubOnboardingScreenState();
}

class DoorHubOnboardingScreenState extends State<DoorHubOnboardingScreen> {




  static const Color kPrimary = Color(0xFF6759FF);
  static const Color kBackground = Color(0xFFF9F9F9);
  static const Color kHint = Color(0xFFD1D3D4);
  static const Color kAccent4 = Color(0xFFB5EBCD);
  int _currentPageIndex = 0;
  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackground,
      appBar: AppBar(
        backgroundColor: kBackground,
        actions: [
          SkipButton(
            onTap: () {Get.to(const LoginScreen());},
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: Column(
        children: [
          Expanded(
              child: PageView.builder(
                itemCount: onboardingList.length,
                controller: _pageController,
                physics: const BouncingScrollPhysics(),
                onPageChanged: (index) {
                  setState(() {
                    _currentPageIndex = index;
                  });
                },
                itemBuilder: (context, index) {
                  return OnboardingCard(
                    playAnimation: true,
                    onboarding: onboardingList[index],
                  );
                },
              )),
          SmoothPageIndicator(
              controller: _pageController,
              count: onboardingList.length,
              effect: WormEffect(
                  dotHeight: 8,
                  dotWidth: 8,
                  dotColor: AppColors.AppColor.withOpacity(0.3),
                  activeDotColor: Colors.black,
              ),
              onDotClicked: (index) {
                setState(() {
                  _currentPageIndex = index;
                });
                _pageController.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                );
              }),
          const SizedBox(height: 30),
          (_currentPageIndex < onboardingList.length - 1)
              ? NextButton(onTap: () {
            _pageController.nextPage(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
            );
          })
              : PrimaryButton(
            onTap: (){
              Get.to(LoginScreen());
            },
            text: 'Create an account',
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

}








