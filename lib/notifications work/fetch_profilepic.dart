import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Fetchpic {
  final String userId;
  late final DocumentReference userdoc;

  Fetchpic(this.userId) {
    userdoc = FirebaseFirestore.instance.collection('users').doc(userId);
  }

  Future<String> getPic() async {
    try {
      DocumentSnapshot snapshot = await userdoc.get();
      
      // Check if the document exists and has data
      if (snapshot.exists && snapshot.data() != null) {
        final data = snapshot.data() as Map<String, dynamic>;

        if (data.containsKey('pic')) {
          print(data['pic']);
          return data['pic'] as String;
        } else {
          throw Exception('The pic field does not exist in the document.');
        }
      } else {
        throw Exception('Document does not exist or has no data.');
      }
    } catch (e) {
      print('Error fetching pic: $e');
      return ''; // Return a default value or handle the error accordingly
    }
  }
}
