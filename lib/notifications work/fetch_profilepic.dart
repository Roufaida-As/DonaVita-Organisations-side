import 'package:cloud_firestore/cloud_firestore.dart';

class Fetchpic {
  final String userId;
  late final DocumentReference userdoc;

  Fetchpic(this.userId) {
    userdoc = FirebaseFirestore.instance.collection('user').doc(userId);
  }

  Future<String> getPic() async {
 
    DocumentSnapshot snapshot = await userdoc.get();
    final data = snapshot.data()  as Map<String, dynamic>;
print(data['pic']);
return data['pic'];

  }
}
