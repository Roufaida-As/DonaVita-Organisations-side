import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:secondapp/Theme/colors.dart';
import 'package:secondapp/profile%20work/Announcment_details.dart';
import 'package:secondapp/profile%20work/add_org_logo.dart';
import 'package:secondapp/profile%20work/announcement_card.dart';
import 'package:secondapp/profile%20work/announcement_model.dart';
import 'package:secondapp/profile%20work/edit_profile_page.dart';
import 'package:secondapp/profile%20work/organisation_service.dart';
import 'package:secondapp/profile%20work/organisation_model.dart';
import 'package:secondapp/utils/dialogs.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Organisation? organisation;

  Future<void> fetchOrganisationInfos() async {
    FirestoreService firestoreService = FirestoreService();

    String? userId = await firestoreService.getCurrentUserId();
    try {
      if (userId != null) {
        Organisation? organisation =
            await firestoreService.getOrganisationById(userId);
        if (mounted) {
          setState(() {
            this.organisation = organisation;
          });
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('debug: $Error fetching announcements');
      }
    }
  }

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
  @override
  void initState() {
    super.initState();
    fetchOrganisationInfos();
  }

  @override
  Widget build(BuildContext context) {
    bool isLogoHidden = organisation?.organizationLogoUrl == "";
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Profile",
              style: TextStyle(
                  fontSize: 30,
                  fontFamily: 'Nunito',
                  color: AppColors.highicons,
                  fontWeight: FontWeight.bold),
            ),
            GestureDetector(
              onTap: () => Get.to(() => const EditProfile()),
              child: const Text(
                "Edit profile",
                style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'Nunito',
                    color: AppColors.highicons,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Row(
          children: [
            Padding(
                padding: const EdgeInsets.all(10.0),
                child: isLogoHidden
                    ? Container(
                        margin: const EdgeInsets.only(left: 10),
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
                                    setState(() {
                                      isLogoHidden = !isLogoHidden;
                                    });
                                    fetchOrganisationInfos();
                                  },
                                )),
                          ],
                        ),
                      )
                    : Container(
                        margin: const EdgeInsets.only(left: 10),
                        width: 90,
                        height: 90,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              45), // Half of width/height to make it a circle
                          color: Colors
                              .transparent, // Set a transparent background color
                        ),
                        child: ClipOval(
                          child: Image.network(
                            organisation?.organizationLogoUrl ?? "",
                            width: 90,
                            height: 90,
                            fit: BoxFit.cover, // Cover the entire container
                          ),
                        ),
                      )),
            const SizedBox(
              width: 4,
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
                  child: Text(
                    organisation?.organizationName ?? "",
                    style: const TextStyle(
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
                  child: Text(
                    organisation?.organizationEmail ?? "",
                    style: const TextStyle(
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
                  child: Text(
                    organisation?.phoneNumber ?? "",
                    style: const TextStyle(
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
              padding:  const EdgeInsets.all(10.0),
              child: Container(
                decoration: BoxDecoration(
                    color: AppColors.highicons,
                    borderRadius: BorderRadius.circular(30)),
                child: IconButton(
                    color: AppColors.highicons,
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                  builder: (BuildContext context) =>
                     AnnonceDetails(organisation: organisation!)),
            );
                    },
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
