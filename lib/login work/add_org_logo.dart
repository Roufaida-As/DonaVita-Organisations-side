import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:secondapp/utils/dialogs.dart';

class AddLogo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String?> getCurrentUserId() async {
    User? user = _auth.currentUser;

    if (user != null) {
      return user.uid;
    } else {
      return null;
    }
  }

  Future<void> addLogoURLForUser(String userId, String logoURL) async {
    try {
      DocumentReference docRef =
          _firestore.collection('organisationsAsUsers').doc(userId);

      await docRef.update({'logoURL': logoURL});

      
      Dialogs.showSnackBar('Error', 'LogoURL added successfully for user $userId', true);
    } catch (error) {
        Dialogs.showSnackBar('Error', 'Failed to add logoURL for user $userId: $error', true);
    }
  }
}
