import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:secondapp/Theme/colors.dart';
import 'package:secondapp/profile%20work/edit_profile_service.dart';
import 'package:secondapp/profile%20work/organisation_model.dart';
import 'package:secondapp/profile%20work/organisation_service.dart';
import 'package:secondapp/profile%20work/profile_page.dart';
import 'package:secondapp/utils/dialogs.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool hidePassword = true;
  bool hideConfirmPassword = true;
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController pwcontroller = TextEditingController();
  final TextEditingController fullnamecontroller = TextEditingController();
  final TextEditingController phonenumbercontroller = TextEditingController();
  final TextEditingController confirmpwcontroller = TextEditingController();

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
            emailcontroller.text = this.organisation?.organizationEmail ?? "";
            fullnamecontroller.text = this.organisation?.organizationName ?? "";
            phonenumbercontroller.text = this.organisation?.phoneNumber ?? "";
          });
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('debug: $Error fetching announcements');
      }
    }
  }

  @override
  void initState() {
    super.initState();
    fetchOrganisationInfos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: const Padding(
            padding: EdgeInsets.only(left: 10.0),
            child: BackButton(
              color: AppColors.highicons,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                  // your logo
                  Container(
                    margin: const EdgeInsets.only(left: 10),
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                          55), // Half of width/height to make it a circle
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
                  ),
                  const SizedBox(
                    height: 55,
                  ),
                  Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              child: Text('Email',
                                  style: TextStyle(
                                      color: AppColors.icons,
                                      fontSize: 16,
                                      fontFamily: 'Nunito',
                                      fontWeight: FontWeight.w500)),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: SizedBox(
                                height: 45,
                                width: 350,
                                child: TextFormField(
                                  controller: emailcontroller,
                                  validator: (value) {
                                    if (!RegExp(
                                            r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
                                        .hasMatch(value!)) {
                                      return 'wrong email format';
                                    }
                                    if (value.isEmpty) {
                                      return "Email is required";
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.emailAddress,
                                  style: const TextStyle(
                                      fontFamily: 'Nunito',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.clear),
                                  decoration: const InputDecoration(
                                    contentPadding: EdgeInsets.all(12),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: AppColors.icons),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: AppColors.icons),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              child: Text('Full name',
                                  style: TextStyle(
                                      color: AppColors.icons,
                                      fontSize: 16,
                                      fontFamily: 'Nunito',
                                      fontWeight: FontWeight.w500)),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: SizedBox(
                                height: 45,
                                width: 350,
                                child: TextFormField(
                                  controller: fullnamecontroller,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Field is required";
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.text,
                                  style: const TextStyle(
                                      fontFamily: 'Nunito',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.clear),
                                  decoration: const InputDecoration(
                                    contentPadding: EdgeInsets.all(12),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: AppColors.icons),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: AppColors.icons),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              child: Text('Phone number',
                                  style: TextStyle(
                                      color: AppColors.icons,
                                      fontSize: 16,
                                      fontFamily: 'Nunito',
                                      fontWeight: FontWeight.w500)),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: SizedBox(
                                height: 45,
                                width: 350,
                                child: TextFormField(
                                  controller: phonenumbercontroller,
                                  style: const TextStyle(
                                      fontFamily: 'Nunito',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.clear),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Field is required";
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                    contentPadding: EdgeInsets.all(12),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: AppColors.icons),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: AppColors.icons),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                    onTap: () => editInofs(),
                    child: Container(
                      width: 200,
                      height: 40,
                      decoration: BoxDecoration(
                          color: AppColors.icons,
                          borderRadius: BorderRadius.circular(20)),
                      child: const Center(
                        child: Text(
                          'Save changes',
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'Nunito',
                            color: AppColors.background,
                          ),
                        ),
                      ),
                    ),
                  )
                ])),
          ),
        ));
  }

  void editInofs() async {
    EditOrganisationInfos editInofs = EditOrganisationInfos();

    // Get current user ID
    String? userId = await editInofs.getCurrentUserId();
    if (userId != null) {
      // Add or update logo URL for the user
      await editInofs.editOrgInfos(userId, emailcontroller.text,
          fullnamecontroller.text, phonenumbercontroller.text);
      Get.back();
      Get.to(() => const ProfilePage());
    } else {
      Dialogs.showSnackBar('Error', 'No user signed in !', true);
    }
  }
}
