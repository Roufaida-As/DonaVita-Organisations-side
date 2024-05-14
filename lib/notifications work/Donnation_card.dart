import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:secondapp/Theme/colors.dart';
import 'package:secondapp/notifications%20work/Donnation_model.dart';
import 'package:secondapp/notifications%20work/donnor_details.dart';
class DonnationCard extends StatelessWidget {
  final Donnation donnation;
  const DonnationCard({super.key,required this.donnation});

  @override
  Widget build(BuildContext context) {
   final db = FirebaseFirestore.instance;
    return Padding(
      padding: const EdgeInsets.only(top: 1.5,bottom: 1.5),
      child: Container(
        width: double.infinity,
        height: 65,
        decoration: BoxDecoration(
          color: donnation.seen? AppColors.smallfont : AppColors.clear,
      border: Border.all(
        color: AppColors.highicons,
        width: 1,
      ),
      
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0,right: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
               Stack(
                 children: [
                  Container(height: 50,width: 50,decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white, // Set the color of the container
                            ),),
                               Positioned(
          top: 0, // Align the top of the badge with the top of the circular container
          right: 0, // Align the right of the badge with the right of the circular container
          child: Container(
            width: 15, // Set the width of the badge
            height: 15, // Set the height of the badge
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: donnation.seen? Colors.transparent : AppColors.highicons, // Set the color of the badge
            ),)),
            ]),
                           SizedBox(width: 5 ,),
                        SizedBox(width: 100 ,child: Text(donnation.fullname,style: TextStyle(color: AppColors.details,fontFamily: 'Nunito',fontSize: 16,fontWeight: FontWeight.w900),overflow: TextOverflow.ellipsis,),),
                        SizedBox(width: 7,),
                                            Text('donated',style: TextStyle(color: AppColors.details,fontFamily: 'Nunito',fontSize: 16,fontWeight: FontWeight.w600),),
                                 SizedBox(width: 20,),  
                                            GestureDetector(onTap:  () {
db.collection('organisationsAsUsers')
        .doc("5TLrUE6UaLXUvDFsMfRbGQTfqqK2")
        .collection('annonces').doc(donnation.annonceId).collection('Donations').doc(donnation.donnationId).update({"seen": true});
                      Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (BuildContext context) =>
                    Donnordetails(donnation: donnation) ),
            );
            
                    },
                    child: Text('show more',style: TextStyle(color: AppColors.details,fontFamily: 'Nunito',fontSize: 11,fontWeight: FontWeight.w400),)),
                                     
          
            ],
          ),
        ),
      ),
    );
  }
}