import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:secondapp/profile%20work/announcement_model.dart';
import 'package:secondapp/utils/dialogs.dart';

class FetchAnnouncements {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<List<Announcement>> getAnnouncementsByOrganization() async {
    List<Announcement> announcements = [];

    try {
      String? currentUserId = await getCurrentUserId();
      if (currentUserId == null) {
        Dialogs.showSnackBar('Error', 'User not authenticated', true);
        return announcements;
      }

      QuerySnapshot querySnapshot = await _firestore
          .collection('organisationsAsUsers')
          .doc(currentUserId)
          .collection('annonces')
          .get();

      // Fetch the logoURL from the organisationAsUsers collection
      DocumentSnapshot orgDoc = await _firestore
          .collection('organisationsAsUsers')
          .doc(currentUserId)
          .get();

      if (!orgDoc.exists) {
        Dialogs.showSnackBar('Error', 'Organization not found', true);
        return announcements;
      }

      String organizationLogoUrl = orgDoc.get('logoURL') as String;

      for (var doc in querySnapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

        Announcement announcement = Announcement(
          organizationName: data['orgName'],
          orgId: data['OrganisationId'],
          category: data['category'],
          annonceTitle: data['annonceTitle'],
          description: data['description'],
          quantityNeeded: data['quantityNeeded'],
          endDate: data['endDate'],
          quantityDonated: data.containsKey('quantityDonated')
              ? data['quantityDonated']
              : "not found",
          imageUrl: data['ImageUrl'],
          organizationLogoUrl: organizationLogoUrl,
          annonceId: doc.id,
        );

        announcements.add(announcement);
      }

      return announcements;
    } catch (error) {
      // Handle error
      Dialogs.showSnackBar(
          'Error', 'Error fetching announcements: $error', true);
      return announcements;
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
