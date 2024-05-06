import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:secondapp/Theme/colors.dart';
import 'package:secondapp/profile%20work/Annonceservice.dart';
import 'package:secondapp/profile%20work/Mytextfield.dart';
import 'package:date_format_field/date_format_field.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:secondapp/profile%20work/add_org_logo.dart';
import 'package:secondapp/profile%20work/organisation_model.dart';

class AnnonceDetails extends StatefulWidget {
  final Organisation organisation;
  const AnnonceDetails({super.key, required this.organisation});

  @override
  State<AnnonceDetails> createState() => _AnnonceDetailsState();
}

class _AnnonceDetailsState extends State<AnnonceDetails> {
  late AnnouncementService annonceservice =
      AnnouncementService(widget.organisation.orgId);
  TextEditingController titlecontroller = TextEditingController();
  TextEditingController descriptioncontroller = TextEditingController();
  TextEditingController quantitycontroller = TextEditingController();
  TextEditingController deadlinecontroller = TextEditingController();
  XFile? _imageFile;
  final ImagePicker _picker = ImagePicker();
  late AddLogo addLogo;
  late String annonceId;
  bool image_selected = false;
  late String category;
  bool food = true;
  bool clothes = true;
  bool money = true;

  bool pic_added = false;
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
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
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
                              width: 15,
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
                              width: 15,
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
                                    category = 'Money';
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
                          height: 50,
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
                            decoration: const InputDecoration(
                              isDense: true,
                              suffixIcon: Text(
                                "person",
                                style: TextStyle(
                                    fontFamily: 'Nunito',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.clear),
                              ),
                              suffixIconConstraints:
                                  BoxConstraints(minWidth: 0, minHeight: 0),
                              labelText: 'Quantity needed:',
                              labelStyle: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 14,
                                color: AppColors.icons,
                                fontWeight: FontWeight.w700,
                              ),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: AppColors.icons, width: 2)),
                              focusedBorder: UnderlineInputBorder(
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
                            // chooseImage(ImageSource.gallery);
                            //  uploadImage(_imageFile!);

                            setState(() {
                              image_selected = true;
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
                                  onComplete: (date) {
                                    print(date.toString);
                                  }),
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
                                    '');

                                titlecontroller.clear();
                                descriptioncontroller.clear();
                                setState(() {
                                  food = true;
                                  money = true;
                                  clothes = true;
                                });

                                quantitycontroller.clear();
                                deadlinecontroller.clear();
                                //addImageUrl(annonceId);
                                print('informations uploaded');

                                Navigator.of(context, rootNavigator: true)
                                    .pop();
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
}
