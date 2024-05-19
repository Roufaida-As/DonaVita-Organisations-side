import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:secondapp/utils/dialogs.dart';

class AddImageUrl{

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
  
  // ignore: non_constant_identifier_names
  Future<void> addImageURLForannonce(String userId, String ImageURL,String annonceId) async {
    try {
      DocumentReference docRef =
          _firestore.collection('organisationsAsUsers').doc(userId).collection('annonces').doc(annonceId);

      await docRef.update({'imageUrl': ImageURL});

      
      Dialogs.showSnackBar('Success', 'ImageURL added successfully for user $userId', false);
    } catch (error) {
        Dialogs.showSnackBar('Error', 'Failed to add ImageURL for user $userId: $error', true);
    }
  }


} 