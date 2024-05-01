import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:secondapp/login%20work/login_page.dart';
import 'package:secondapp/profile%20work/profile_page.dart';
import 'package:secondapp/utils/dialogs.dart';

class Services {
  static void signOut() {
    FirebaseAuth.instance.signOut();
    Get.offAll(() => const LoginPage());
  }

  static void signInWithEmailAndPassword(
    String email,
    String password,
    String fullname,
    String phonenumber,
    
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
      });
      Get.back();
      Get.to(() => const ProfilePage());
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
}
