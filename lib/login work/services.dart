import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:secondapp/home_screen.dart';
import 'package:secondapp/login%20work/login_page.dart';
import 'package:secondapp/login%20work/verify_email_page.dart';
import 'package:secondapp/utils/dialogs.dart';

class Services {
  static void signOut() {
    FirebaseAuth.instance.signOut();
    Get.offAll(() => const Login());
  }

  static void signup(
    String email,
    String password,
    String fullname,
    String phonenumber,
    String ville,
  ) async {
    try {
      Dialogs.showLoadingDialog();
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await FirebaseFirestore.instance
          .collection('organisationsAsUsers')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({
        'id': FirebaseAuth.instance.currentUser!.uid,
        'email': email,
        'fullname': fullname,
        'phonenumber': phonenumber,
        'logoURL': "",
        'ville': ville,
      });
      Get.back();
      Get.to(() => const VerifyEmail(), transition: Transition.fadeIn);
    } on FirebaseAuthException catch (e) {
      Get.back();
      if (e.code == 'weak-password') {
        Dialogs.showSnackBar(
            'Error', 'The password provided is too weak.', true);
      } else if (e.code == 'email-already-in-use') {
        Dialogs.showSnackBar(
            'Error', 'The account already exists for that email.', true);
      }
    } catch (e) {
      Get.back();
      Dialogs.showSnackBar('Error', 'Something went wrong !', true);
    }
  }

  static void loginn(
    String email,
    String password,
  ) async {
    Dialogs.showLoadingDialog();
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      Dialogs.showSnackBar('Success', 'login successfully', false);
      Get.back();
      Get.to(() => const HomeScreen(), transition: Transition.fadeIn);

      Dialogs.showSnackBar('Success', 'login successfully', false);
    } catch (e) {
      Get.back();
      Dialogs.showSnackBar('Error', 'Something went wrong !', true);
    }
  }
}
