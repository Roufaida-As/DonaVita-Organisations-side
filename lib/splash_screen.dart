import "dart:async";
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:secondapp/Theme/colors.dart';
import 'package:secondapp/login%20work/login_page.dart';
import 'package:secondapp/login%20work/verify_email_page.dart';
import 'package:secondapp/profile%20work/profile_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      initialScreen();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/logo 2.png", width: 130, height: 102.78),
            Image.asset("assets/Name.png", width: 145, height: 44),
            Image.asset("assets/Slogan.png", width: 152, height: 19),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}

void initialScreen() {
  if (FirebaseAuth.instance.currentUser != null) {
    if (FirebaseAuth.instance.currentUser!.emailVerified == false) {
      Get.to(() => const VerifyEmailPage(),
          transition: Transition.fadeIn,
          duration: const Duration(milliseconds: 500));
    } else {
      Get.to(() => const ProfilePage(),
          transition: Transition.fadeIn,
          duration: const Duration(milliseconds: 500));
    }
  } else {
    Get.to(() => const LoginPage(),
        transition: Transition.fadeIn,
        duration: const Duration(milliseconds: 500));
  }
}
