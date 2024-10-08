import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:secondapp/Theme/colors.dart';
import 'package:secondapp/home_screen.dart';
import 'package:secondapp/profile%20work/Annonceservice.dart';
import 'package:secondapp/profile%20work/Mytextfield.dart';
import 'package:date_format_field/date_format_field.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:secondapp/profile%20work/add_org_logo.dart';
import 'package:secondapp/profile%20work/organisation_model.dart';
import 'package:secondapp/utils/dialogs.dart';

class AnnonceDetails extends StatefulWidget {
  final Organisation organisation;
  const AnnonceDetails({super.key, required this.organisation});

  @override
  State<AnnonceDetails> createState() => _AnnonceDetailsState();
}

class _AnnonceDetailsState extends State<AnnonceDetails> {
  late AnnouncementService annonceservice =
      AnnouncementService(widget.organisation.orgId, '');

  TextEditingController titlecontroller = TextEditingController();
  TextEditingController descriptioncontroller = TextEditingController();
  TextEditingController quantitycontroller = TextEditingController();
  TextEditingController deadlinecontroller = TextEditingController();
  XFile? _imageFile;
  String imageurl = "imageurl";
  final ImagePicker _picker = ImagePicker();
  late AddLogo addLogo;
  late String annonceId;
  bool imageselected = false;
  String category = "money";
  bool food = true;
  bool clothes = true;
  bool money = true;
  String annonceid = "";
  bool picadded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.clear,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            "Donation Details",
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 32,
              color: AppColors.highicons,
              fontWeight: FontWeight.bold,
            ),
          ),
          leading: const Padding(
            padding: EdgeInsets.only(left: 10.0),
            child: BackButton(
              color: AppColors.highicons,
            ),
          ),
        ),
        body: Padding(
            padding: const EdgeInsets.only(
              top: 40,
            ),
            child: Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(60),
                    topRight: Radius.circular(60),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF000000).withOpacity(0.2),
                      spreadRadius: 0, // spread radius
                      blurRadius: 30,
                    )
                  ],
                ),
                child: Padding(
                    padding:
                        const EdgeInsets.only(top: 40, left: 40, right: 40),
                    child: SingleChildScrollView(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Select a category:',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: AppColors.icons,
                              fontSize: 20,
                              fontFamily: 'Nunito',
                              fontWeight: FontWeight.w800),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          //  mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            //food category
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      food ? AppColors.highicons : Colors.grey,
                                ),
                                onPressed: () {
                                  setState(() {
                                    food = true;
                                    category = 'Food';
                                    clothes = false;
                                    money = false;
                                  });
                                },
                                child: const Text(
                                  "FOOD",
                                  style: TextStyle(
                                      fontFamily: 'Nunito',
                                      color: AppColors.background,
                                      fontWeight: FontWeight.bold),
                                )),
                            const SizedBox(
                              width: 8,
                            ),
                            //clothes category
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      clothes ? AppColors.icons : Colors.grey,
                                ),
                                onPressed: () {
                                  setState(() {
                                    clothes = true;
                                    category = 'Clothes';
                                    money = false;
                                    food = false;
                                  });
                                },
                                child: const Text(
                                  "CLOTHES",
                                  style: TextStyle(
                                      fontFamily: 'Nunito',
                                      color: AppColors.background,
                                      fontWeight: FontWeight.bold),
                                )),
                            const SizedBox(
                              width: 10,
                            ),
                            //money category
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      money ? AppColors.clear : Colors.grey,
                                ),
                                onPressed: () {
                                  setState(() {
                                    money = true;
                                    category = 'money';
                                    food = false;
                                    clothes = false;
                                  });
                                },
                                child: Text(
                                  "MONEY",
                                  style: TextStyle(
                                      fontFamily: 'Nunito',
                                      color: money
                                          ? AppColors.icons
                                          : Colors.white,
                                      fontWeight: FontWeight.bold),
                                ))
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Mytextfield(
                          height: 60,
                          text: 'Title:',
                          controller: titlecontroller,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Mytextfield(
                          height: 282,
                          text: 'Description:',
                          controller: descriptioncontroller,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: 200,
                          child: TextField(
                            controller: quantitycontroller,
                            decoration: InputDecoration(
                              isDense: true,
                              suffixIcon: Icon(
                                category == "money"
                                    ? Icons.monetization_on
                                    : Icons.person,
                                color: AppColors.clear,
                              ),
                              suffixIconConstraints: const BoxConstraints(
                                  minWidth: 0, minHeight: 0),
                              labelText: 'Quantity needed:',
                              labelStyle: const TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 14,
                                color: AppColors.icons,
                                fontWeight: FontWeight.w700,
                              ),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              enabledBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: AppColors.icons, width: 2)),
                              focusedBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: AppColors.icons, width: 2)),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const Text(
                          'upload an image:',
                          style: TextStyle(
                              fontFamily: 'Nunito',
                              fontSize: 14,
                              color: AppColors.icons,
                              fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        GestureDetector(
                          onTap: () {
                            chooseImage(ImageSource.gallery);

                            setState(() {
                              imageselected = true;
                            });
                          },
                          child: Container(
                            height: 28,
                            width: 32,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 2, color: AppColors.icons)),
                            child: const Center(
                                child: Icon(
                              Icons.add_a_photo_rounded,
                              size: 20,
                              color: AppColors.icons,
                            )),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const Text(
                          'Deadline:',
                          style: TextStyle(
                              fontFamily: 'Nunito',
                              fontSize: 14,
                              color: AppColors.icons,
                              fontWeight: FontWeight.w700),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 150,
                              child: DateFormatField(
                                  controller: deadlinecontroller,
                                  decoration: const InputDecoration(
                                      enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: AppColors.icons)),
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: AppColors.icons))),
                                  type: DateFormatType.type2,
                                  onComplete: (date) {}),
                            ),
                            GestureDetector(
                              onTap: () async {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return Center(
                                      child: LoadingAnimationWidget.waveDots(
                                          color: AppColors.icons, size: 100),
                                    );
                                  },
                                );

                                annonceservice.addAnnonce(
                                    widget.organisation.organizationName,
                                    widget.organisation.organizationLogoUrl,
                                    widget.organisation.orgId,
                                    category,
                                    titlecontroller.text,
                                    descriptioncontroller.text,
                                    quantitycontroller.text,
                                    deadlinecontroller.text,
                                    imageurl = await uploadImage(_imageFile!));

                                titlecontroller.clear();
                                descriptioncontroller.clear();
                                setState(() {
                                  food = true;
                                  money = true;
                                  clothes = true;
                                });

                                quantitycontroller.clear();
                                deadlinecontroller.clear();
                                Get.back();

                                Dialogs.showSnackBar(
                                    "Success", "informations uploaded", false);

                                // Dismiss the loading animation dialog
                                Navigator.of(context, rootNavigator: true)
                                    .pop();
                                Get.to(() => HomeScreen());
                              },
                              child: Container(
                                width: 140,
                                decoration: BoxDecoration(
                                    color: AppColors.highicons,
                                    borderRadius: BorderRadius.circular(40)),
                                child: const Padding(
                                  padding: EdgeInsets.only(
                                      left: 10, right: 10, top: 3, bottom: 3),
                                  child: Center(
                                      child: Text(
                                    'post',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Roboto',
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400),
                                  )),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ))))));
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
      Dialogs.showSnackBar("Error", "failed", true);
      return e.toString();
    }
  }
}
