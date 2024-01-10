import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'colors.dart';

class Onboarding {
  String image;
  String title;
  String description;

  Onboarding(
      {required this.description, required this.image, required this.title});
}

List<Onboarding> onboardingList = [
  Onboarding(

      image: AppAssets.kOnboardingFirst,
      title: 'Order from your favourite store or vendor',
      description: '',),
      //'Welcome to "Slice of Heaven Pizzeria" – where passion meets flavor! At our cozy pizza haven, we craft culinary delights that will take your taste buds on a journey of pure bliss.'),
  Onboarding(
      description: '',
      image: AppAssets.kOnboardingSecond,
      title: ' Choose from a wide range of different meals'),
  Onboarding(
      description:
      '',
      image: AppAssets.kOnboardingThird,
      title: 'Enjoy instant delivery \n and payment'),

];
class OnboardingAnimations {
  static AnimationController createSlideController(TickerProvider vsync) {
    return AnimationController(
      vsync: vsync,
      duration: const Duration(milliseconds: 1000),
    );
  }

  static AnimationController createController(TickerProvider vsync) {
    return AnimationController(
      vsync: vsync,
      duration: const Duration(milliseconds: 1000),
    );
  }

  static AnimationController createFadeController(TickerProvider vsync) {
    return AnimationController(
      vsync: vsync,
      duration: const Duration(milliseconds: 200),
    );
  }

  static Animation<Offset> openSpotsSlideAnimation(
      AnimationController controller) {
    return Tween<Offset>(
      begin: const Offset(0.0, -0.8),
      end: const Offset(0.0, -0.05),
    ).animate(CurvedAnimation(
      parent: controller,
      curve: const ElasticOutCurve(1.2),
    ));
  }

  static Animation<Offset> digitalPermitsSlideAnimation(
      AnimationController controller) {
    return Tween<Offset>(
      begin: const Offset(0.0, 1.0),
      end: const Offset(0.0, 0.07),
    ).animate(CurvedAnimation(
      parent: controller,
      curve: const ElasticOutCurve(1.2),
    ));
  }

  static Animation<Offset> rewardsSlideAnimation(
      AnimationController controller) {
    return Tween<Offset>(
      begin: const Offset(0.0, -0.8),
      end: const Offset(0.0, -0.05),
    ).animate(CurvedAnimation(
      parent: controller,
      curve: const ElasticOutCurve(1.2),
    ));
  }

  static Animation<double> fadeAnimation(AnimationController controller) {
    return Tween<double>(
      begin: 0.5,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: controller,
      curve: Curves.easeIn,
    ));
  }
}

class OnboardingCard extends StatefulWidget {
  final bool playAnimation;
  final Onboarding onboarding;
  const OnboardingCard(
      {required this.playAnimation, super.key, required this.onboarding});

  @override
  State<OnboardingCard> createState() => _OnboardingCardState();
}

class _OnboardingCardState extends State<OnboardingCard>
    with TickerProviderStateMixin {
  late AnimationController _slideAnimationController;
  late Animation<Offset> _slideAnimation;

  Animation<Offset> get slideAnimation => _slideAnimation;
  AnimationController get slideAnimationController => _slideAnimationController;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (widget.playAnimation) {
      _slideAnimationController.forward();
    } else {
      _slideAnimationController.animateTo(
        1,
        duration: const Duration(milliseconds: 0),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _slideAnimationController =
        OnboardingAnimations.createSlideController(this);
    _slideAnimation =
        OnboardingAnimations.openSpotsSlideAnimation(_slideAnimationController);
  }

  @override
  void dispose() {
    _slideAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slideAnimation,
      child: Column(
        children: [
          SizedBox(height: Get.height*0.05,),
          Text(
            widget.onboarding.title,
            style: const TextStyle(
                fontSize: 24, fontWeight: FontWeight.w700, color: Colors.black),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 20),
          Image.asset(
            widget.onboarding.image,
            width: 200,
            fit: BoxFit.fitWidth,
          ),
          const SizedBox(height: 12),
          Text(
            widget.onboarding.description,
            style: const TextStyle(
                fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}