import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:secondapp/Theme/colors.dart';
import 'package:secondapp/login%20work/add_org_logo.dart';
import 'package:secondapp/profile%20work/announcement_card.dart';
import 'package:secondapp/profile%20work/announcement_model.dart';
import 'package:secondapp/profile%20work/organisation_model.dart';
import 'package:secondapp/utils/dialogs.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late Organisation organisation;

  XFile? _imageFile;
  final ImagePicker _picker = ImagePicker();
  late AddLogo addLogo;

  List<Announcement> announcements = [
    Announcement(
      annonceTitle: "Ramadan Iftar",
      annonceId: "145",
      category: "food",
      description: "hytttttttttttttttttt",
      endDate: "2024",
      imageUrl: "",
      orgId: "",
      organizationLogoUrl: "",
      organizationName: "",
      quantityDonated: "16",
      quantityNeeded: "20",
      time: "2024",
    )
  ];

  Future<void> fetchAnnouncements() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "Profile",
          textAlign: TextAlign.left,
          style: TextStyle(
              fontSize: 30,
              fontFamily: 'Nunito',
              color: AppColors.highicons,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Row(
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: const DecorationImage(
                      image: AssetImage("assets/Ellipse 30.png"),
                    )),
                child: Stack(
                  children: [
                    const Positioned(
                        top: 30,
                        left: 8,
                        child: Text(
                          textAlign: TextAlign.center,
                          "organisation ",
                          style: TextStyle(
                              color: AppColors.background,
                              fontSize: 12,
                              fontWeight: FontWeight.w700),
                        )),
                    const Positioned(
                        top: 45,
                        left: 32,
                        child: Text(
                          "logo",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: AppColors.background,
                              fontSize: 12,
                              fontWeight: FontWeight.w700),
                        )),
                    Positioned(
                        top: 48,
                        left: 22,
                        child: IconButton(
                          icon: const Icon(Icons.add,
                              color: AppColors.background),
                          onPressed: () async {
                            chooseImage(ImageSource.gallery);
                            uploadImage(_imageFile!);
                            addLogoUrl();
                          },
                        )),
                  ],
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(2),
                  width: 250,
                  child: const Text(
                    "Organisation name",
                    style: TextStyle(
                        color: AppColors.icons,
                        fontWeight: FontWeight.w400,
                        fontSize: 18),
                  ),
                ),

                //display the name
                Container(
                  width: 250,
                  margin: const EdgeInsets.all(5),
                  padding: const EdgeInsets.only(bottom: 5),
                  decoration: const BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                    color: AppColors.icons,
                    width: 1,
                  ))),
                  child: const Text(
                    "Al-Baraka"
                    //organisation.organizationName
                    ,
                    style: TextStyle(
                        fontFamily: 'Nunito',
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: AppColors.clear),
                  ),
                ),

                Container(
                  margin: const EdgeInsets.all(2),
                  padding: const EdgeInsets.only(top: 5),
                  width: 250,
                  child: const Text(
                    "Organisation email",
                    style: TextStyle(
                        color: AppColors.icons,
                        fontWeight: FontWeight.w400,
                        fontSize: 18),
                  ),
                ),

                //display the email
                Container(
                  width: 250,
                  margin: const EdgeInsets.all(7),
                  padding: const EdgeInsets.only(bottom: 5),
                  decoration: const BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                    color: AppColors.icons,
                    width: 1,
                  ))),
                  child: const Text(
                    "AlBarakaOrg@gmail.com"
                    //organisation.organizationEmail,
                    ,
                    style: TextStyle(
                        fontFamily: 'Nunito',
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: AppColors.clear),
                  ),
                ),

                Container(
                  margin: const EdgeInsets.all(2),
                  padding: const EdgeInsets.only(top: 5),
                  width: 250,
                  child: const Text(
                    "Phone number",
                    style: TextStyle(
                        color: AppColors.icons,
                        fontWeight: FontWeight.w400,
                        fontSize: 18),
                  ),
                ),

                //display the number
                Container(
                  width: 250,
                  margin: const EdgeInsets.all(7),
                  padding: const EdgeInsets.only(bottom: 5),
                  decoration: const BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                    color: AppColors.icons,
                    width: 1,
                  ))),
                  child: const Text(
                    "0558727069"
                    //organisation.phoneNumber,
                    ,
                    style: TextStyle(
                        fontFamily: 'Nunito',
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: AppColors.clear),
                  ),
                ),
              ],
            )
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Padding(
              padding: EdgeInsets.all(11.0),
              child: Text(
                "Announcements",
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Nunito',
                    color: AppColors.highicons,
                    fontWeight: FontWeight.w700),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                decoration: BoxDecoration(
                    color: AppColors.highicons,
                    borderRadius: BorderRadius.circular(30)),
                child: IconButton(
                    color: AppColors.highicons,
                    onPressed: () {},
                    icon: const Icon(
                      Icons.add,
                      color: AppColors.background,
                    )),
              ),
            )
          ],
        ),
        Expanded(
            child: ListView.builder(
          itemCount: announcements.length,
          itemBuilder: (context, index) {
            return SafeArea(
              child: AnnouncementCard(
                announcement: announcements[index],
              ),
            );
          },
        ))
      ]),
    );
  }

  void chooseImage(ImageSource source) async {
    XFile? pickedFile = await _picker.pickImage(source: source);
    setState(() {
      _imageFile = pickedFile;
    });
  }

  Future<String> uploadImage(XFile file) async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirImages =
        referenceRoot.child('userProfileImages/$fileName.jpg');
    Reference referenceImage = referenceDirImages.child(fileName);
    try {
      await referenceImage.putFile(File(file.path));
      String imageUrl = await referenceImage.getDownloadURL();
      return imageUrl;
    } catch (e) {
      return e.toString();
    }
  }

  void addLogoUrl() async {
    AddLogo addLogo = AddLogo();

    // Get current user ID
    String? userId = await addLogo.getCurrentUserId();
    if (userId != null) {
      // Add or update logo URL for the user
      await addLogo.addLogoURLForUser(userId, await uploadImage(_imageFile!));
    } else {
      Dialogs.showSnackBar('Error', 'No user signed in !', true);
    }
  }
}
