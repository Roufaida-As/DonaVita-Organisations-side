import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:secondapp/notifications%20work/Donnation_model.dart';

class DonnationService {
  final String orgId;
  late final CollectionReference donnationCollection;
  List<Donnation> donnations = [];

  DonnationService(this.orgId) {
    donnationCollection = FirebaseFirestore.instance
        .collection('organisationsAsUsers')
        .doc(orgId)
        .collection('annonces');
  }

  Future<List<Donnation>> getDonnations() async {
    try {
      final querySnapshot = await donnationCollection.get();
      donnations.clear(); // Clear existing entries before fetching new ones

      for (final doc in querySnapshot.docs) {
        final orgDonnationsSnapshot = await doc.reference.collection('Donations').get();
        for (final donDoc in orgDonnationsSnapshot.docs) {
          final data = donDoc.data() as Map<String, dynamic>;
          donnations.add(Donnation(
            adress: data['adress'],
            quantitydonated: data['quantitydonated'],
            fullname: data['fullname'],
            phonenumber: data['phonenumber'],
            personId: data['personId'] ?? '', // Handle potentially null value
            annonceId:doc.id, // Handle potentially null value
            orgId: orgId,
            seen: data['seen'] ,
            donnationId: donDoc.id,
          ));
        }
      }
      return donnations;
    } on FirebaseException catch (e) {
      // Handle Firebase errors (e.g., network timeouts, permission issues)
      print('Error fetching donations: ${e.message}');
      return [];
    }}}