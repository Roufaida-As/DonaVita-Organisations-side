import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:secondapp/profile%20work/organisation_model.dart';
import 'package:secondapp/utils/dialogs.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<Organisation?> getOrganisationById(String orgId) async {
    try {
      DocumentSnapshot documentSnapshot =
          await _firestore.collection('organisationsAsUsers').doc(orgId).get();

      if (documentSnapshot.exists) {
        Map<String, dynamic> data =
            documentSnapshot.data() as Map<String, dynamic>;

        return Organisation(
          organizationName: data['fullname'],
          organizationEmail: data['email'],
          organizationLogoUrl: data['logoURL'],
          phoneNumber: data['phonenumber'],
          orgId: documentSnapshot.id,
          ville: data['ville']
        );
      } else {
        Dialogs.showSnackBar(
            'Error', 'Organisation with ID $orgId does not exist.', true);
        return null;
      }
    } catch (error) {
      // Handle error
      Dialogs.showSnackBar(
          'Error', 'Error fetching organisation: $error', true);
      return null;
    }
  }

  Future<String?> getCurrentUserId() async {
    User? user = _auth.currentUser;

    if (user != null) {
      return user.uid;
    } else {
      return null;
    }
  }
}
