import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:secondapp/Theme/colors.dart';
import 'package:secondapp/notifications%20work/DonnationService.dart';
import 'package:secondapp/notifications%20work/Donnation_card.dart';
import 'package:secondapp/notifications%20work/Donnation_model.dart';
import 'package:secondapp/notifications%20work/fetch_profilepic.dart';
import 'package:secondapp/profile%20work/organisation_service.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  late List<Donnation> donnations = [];
  late DonnationService donnationService;
  late Fetchpic fetchpic;
  String picpath = '';
  String userId = '';
  FirestoreService firestoreService = FirestoreService();

  @override
  void initState() {
    super.initState();
    getCurrentUserId().then((id) {
      setState(() {
        userId = id;
        donnationService = DonnationService(userId);
        getDonnations();
      });
    });
  }

  Future<String> getCurrentUserId() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return user.uid;
    } else {
      throw Exception('No user is currently signed in');
    }
  }

  void getDonnations() async {
    List<Donnation> fetchedDonnations = await donnationService.getDonnations();
    setState(() {
      donnations = fetchedDonnations;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Notifications",
          textAlign: TextAlign.left,
          style: TextStyle(
            fontSize: 32,
            color: AppColors.highicons,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: donnations.isEmpty
            ? Center(
                child: Text('No notifications yet',
                    style: TextStyle(color: AppColors.smallfont)))
            : ListView.builder(
                itemCount: donnations.length,
                itemBuilder: (BuildContext context, int index) {
                  return DonnationCard(donnation: donnations[index]);
                },
              ),
      ),
    );
  }
}