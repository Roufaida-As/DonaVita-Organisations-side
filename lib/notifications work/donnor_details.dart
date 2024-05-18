import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:secondapp/Theme/colors.dart';
import 'package:secondapp/notifications%20work/Donnation_model.dart';
import 'package:secondapp/notifications%20work/fetch_profilepic.dart';
import 'package:secondapp/notifications%20work/notifications_page.dart';
import 'package:secondapp/profile%20work/Annonceservice.dart';
import 'package:secondapp/profile%20work/information.dart';

class Donnordetails extends StatefulWidget {
  Donnation donnation;
   Donnordetails({super.key,required this.donnation});

  @override
  State<Donnordetails> createState() => _DonnordetailsState();
}

class _DonnordetailsState extends State<Donnordetails> {
  String quantitydonated = '';
  String category = '';
  String title = '';

  late AnnouncementService announcementService;
late Fetchpic fetchpic ;
 String picpath='';

  @override
  void initState() {
    super.initState();
  fetchpic = Fetchpic(widget.donnation.personId);
    announcementService = AnnouncementService(widget.donnation.orgId, widget.donnation.annonceId);
    fetchData();
  }

  void fetchData() async {
    picpath = await fetchpic.getPic();  
    announcementService.getAnnonce().then((result) {
      setState(() {
        quantitydonated = result['quantityDonated'];
        category = result['category'];
        title = result['title'];
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.clear,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Donor Details",
          textAlign: TextAlign.left,
          style: TextStyle(
            fontSize: 32,
            color: AppColors.highicons,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: GestureDetector(
          onTap: () {
                      Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (BuildContext context) =>
                   NotificationPage() ),
            );
                    },
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Image.asset(
              'assets/eva_arrow-back-outline.png',
              width: 32,
              height: 32,
            ),
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
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 30,),
                Text(
                  title,
                  style: const TextStyle(fontSize: 24,fontWeight: FontWeight.w900,color: AppColors.icons,fontFamily: 'Roboto'),
                ),
                const SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.only(left: 30.0,right: 30.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(height: 147,width: 147,decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.clear, 
                      
                      ),
                       child: ClipRRect( // Add ClipRRect for better control
    borderRadius: BorderRadius.circular(147), // Match container size
    child: picpath.isEmpty
        ? const Center(child: Text(textAlign: TextAlign.center ,'No profile picture available',style: TextStyle(fontWeight: FontWeight.w700),))
        : Image.network(
            picpath,
            fit: BoxFit.cover, // Adjust as needed
          ),
  ),
                      ),
                      const SizedBox(height: 20,),
                      Information(indicator: 'Full name', insideinfo: widget.donnation.fullname, suffixexist: false,category: category,),
                      const SizedBox(height: 20,),
                      Information(indicator: 'Phone number', insideinfo: widget.donnation.phonenumber,suffixexist: false,category: category),
                      const SizedBox(height: 20,),
                      Information(indicator: 'Adress', insideinfo: widget.donnation.adress,suffixexist: false,category: category),
                      const SizedBox(height: 20,),
                      Padding(
                        padding: const EdgeInsets.only(right: 200),
                        child: Information(indicator: 'Quantity donated:', insideinfo: widget.donnation.quantitydonated,suffixexist: true,category: category),
                      ),
                      const SizedBox(height: 40,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 100,
                            height: 32,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: AppColors.icons
                            ),

                            child: const Center(child: Text('Chat',style: TextStyle(color: Colors.white,fontFamily: 'Nunito',fontWeight: FontWeight.w900,fontSize: 14),)),
                          ),
                          Container(
                            width: 100,
                            height: 32,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: AppColors.highicons
                            ),

                            child:  GestureDetector(
                                onTap: () {
                              
                               

                                  final snackBar1 = SnackBar(
                                    behavior: SnackBarBehavior.floating,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10), // Adjust the border radius here
                                    ),
                                    content: const Text("Progress bar has been updated succefully",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600),),
                                    backgroundColor: AppColors.clear, // Specify the color here
                                  );
                                  final snackBar2 = SnackBar(
                                    behavior: SnackBarBehavior.floating,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10), // Adjust the border radius here
                                    ),
                                    content: const Text("Error updating the progress bar",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600)),
                                    backgroundColor: Colors.red[400], // Specify the color here
                                  );


                                  FirebaseFirestore.instance
                                      .collection("organisationsAsUsers")
                                      .doc(widget.donnation.orgId)
                                      .collection("annonces")
                                      .doc(widget.donnation.annonceId)
                                      .update({
                                    "quantityDonated": (int.parse(quantitydonated) + int.parse(widget.donnation.quantitydonated)).toString()
                                  }).then(
                                          (value) =>    ScaffoldMessenger.of(context).showSnackBar(snackBar1),
                                          onError: (e) =>    ScaffoldMessenger.of(context).showSnackBar(snackBar2));
                                },
                                child: const Center(child: Text('Confirm',style: TextStyle(color: Colors.white,fontFamily: 'Nunito',fontWeight: FontWeight.w900,fontSize: 14),))),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
