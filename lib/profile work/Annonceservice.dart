import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:secondapp/profile%20work/announcement_model.dart';
//import 'package:firebase_storage/firebase_storage.dart';
//import 'package:projectfinal/pages/homepage%20work/storage_service.dart';
class AnnouncementService { 
  
  final String orgId; 
  final String annId;
  late final CollectionReference announcementsCollection;
  late final CollectionReference announcementsCollection2;
   final FirebaseFirestore db = FirebaseFirestore.instance;

  AnnouncementService(this.orgId,this.annId) {
   // ignore: unused_local_variable

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
Future<Map<String, dynamic>> getAnnonce() async {
  final docSnapshot = await db
      .collection("organisationsAsUsers")
      .doc(orgId)
      .collection("annonces")
      .doc(annId)
      .get();

  if (docSnapshot.exists) {
    final data = docSnapshot.data();
    final category = data?['category'];
    final title = data?['annonceTitle'];
    final quantityDonated = data?['quantityDonated'];

    return {
      'category': category,
      'title': title,
      'quantityDonated': quantityDonated,
    };
  } else {
    // Handle if the document does not exist
    throw Exception('Document does not exist');
  }
}

 
  
}