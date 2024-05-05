import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:secondapp/profile%20work/announcement_model.dart';
//import 'package:firebase_storage/firebase_storage.dart';
//import 'package:projectfinal/pages/homepage%20work/storage_service.dart';
class AnnouncementService { 
  final String orgId;
  late final CollectionReference announcementsCollection;
  late final CollectionReference announcementsCollection2;

  AnnouncementService(this.orgId) {
    announcementsCollection = FirebaseFirestore.instance.collection('Organisations');
    announcementsCollection2 = FirebaseFirestore.instance.collection('organisationsAsUsers').doc(orgId).collection('annonces');
  }

  Future<List<Announcement>> getAnnouncements() async {
    QuerySnapshot querySnapshot = await announcementsCollection.get();

    List<Announcement> announcements = [];

    for (QueryDocumentSnapshot doc in querySnapshot.docs) {
      String orgName = doc['name'];
      String orgLogoUrl = doc['logoURL'];
      String OrganisationId=doc.id;
      

      QuerySnapshot orgAnnouncementsSnapshot =
          await doc.reference.collection('annonces').get();

      for (var annDoc in orgAnnouncementsSnapshot.docs) {
        Map<String, dynamic> data = annDoc.data() as Map<String, dynamic>;
        announcements.add(Announcement(
          organizationName: orgName,
          organizationLogoUrl: orgLogoUrl,
          orgId: OrganisationId,
annonceId: annDoc.id,
          category: annDoc['category'],
          annonceTitle: annDoc['annonceTitle'],
          description: annDoc['description'],
          quantityNeeded: annDoc['quantityNeeded'],
          endDate: annDoc['endDate'],
          imageUrl: annDoc['imageUrl'],
          quantityDonated: data.containsKey('quantityDonated')
              ? data['quantityDonated']
              : "not found",
              time: '',
        ));
      }
    }

    return announcements;
  }
  Future<void> addAnnonce(String orgname,String orglogourl,String orgId,String category,String title,String description,String quantityNeeded,String deadline,String imageUrl){
    return announcementsCollection2.add({
'orgName' : orgname,
'OrganisationId':orgId,
'category':category,
'annonceTitle':title,
'description':description,
'quantityNeeded':quantityNeeded,
'endDate':deadline,
'quantityDonated':'0',
'ImageUrl':imageUrl,

    });
   
  }
  
}