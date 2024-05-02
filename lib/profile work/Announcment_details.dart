import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:secondapp/Theme/colors.dart';
import 'package:secondapp/profile%20work/Mytextfield.dart';
import 'package:date_format_field/date_format_field.dart';
class AnnonceDetails extends StatefulWidget {
  const AnnonceDetails({super.key});

  @override
  State<AnnonceDetails> createState() => _AnnonceDetailsState();
}

class _AnnonceDetailsState extends State<AnnonceDetails> {
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
        leading: GestureDetector(
          onTap: () {},
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
child: Padding(
              padding: const EdgeInsets.only(top: 40, left: 40,right: 40),
              child: SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     Text('Select a category:',textAlign: TextAlign.left,style: TextStyle(color: AppColors.icons,fontSize: 20,fontFamily: 'Nunito',fontWeight: FontWeight.w800),),
                     const SizedBox(height: 10,),
                      Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    //food category
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.highicons,
                        ),
                        onPressed: () => {
                           
                            },
                        child: const Text(
                          "FOOD",
                          style: TextStyle(
                              fontFamily: 'Nunito',
                              color: AppColors.background,
                              fontWeight: FontWeight.bold),
                        )),
                        SizedBox(width: 15,),
                    //clothes category
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.icons,
                        ),
                        onPressed: () => {
                             
                            },
                        child: const Text(
                          "CLOTHES",
                          style: TextStyle(
                              fontFamily: 'Nunito',
                              color: AppColors.background,
                              fontWeight: FontWeight.bold),
                        )),
  SizedBox(width: 15,),
                    //money category
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.clear,
                        ),
                        onPressed: () => {
                              
                            },
                        child: const Text(
                          "MONEY",
                          style: TextStyle(
                              fontFamily: 'Nunito',
                              color: AppColors.icons,
                              fontWeight: FontWeight.bold),
                        ))
                  ],
                ),
               const SizedBox(height: 20,),
             const   Mytextfield(height: 50, text: 'Title:'),
                const SizedBox(height: 20,),
                const Mytextfield(height: 282, text: 'Description:'),
                const SizedBox(height: 20,),
                const SizedBox(
                  width: 200,
                  child: TextField(

                    decoration: InputDecoration(
                      isDense: true,
   suffixIcon:Text("person",style: TextStyle(
                        fontFamily: 'Nunito',
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.clear
                      ),),
   suffixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
                      
                      
                      labelText: 'Quantity needed:',
                      labelStyle: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 14,
                    color: AppColors.icons,
                    fontWeight: FontWeight.w700,
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                   enabledBorder:  UnderlineInputBorder(
                    
                      borderSide: BorderSide(color: AppColors.icons,width: 2)),
                      focusedBorder:  UnderlineInputBorder(
                        
                      borderSide: BorderSide(color: AppColors.icons,width: 2)),
                    ),
                  ),
                ),
          const      SizedBox(height: 15,),
               const Text('upload an image:',style: TextStyle(fontFamily: 'Nunito',fontSize: 14,color: AppColors.icons,fontWeight: FontWeight.w700),),
                const      SizedBox(height: 15,),
                Container(
                  height: 28,
                  width: 32,
                  decoration: BoxDecoration(border: Border.all(width: 2,color: AppColors.icons)),
                  child: Center(child: Icon(Icons.add_a_photo_rounded,size: 20,color: AppColors.icons,)),
                ),
                const      SizedBox(height: 15,),
               const Text('Deadline:',style: TextStyle(fontFamily: 'Nunito',fontSize: 14,color: AppColors.icons,fontWeight: FontWeight.w700),),
                
                SizedBox(
                  width: 200,
                  child: DateFormatField(
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppColors.icons)),
                      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppColors.icons))
                    ),
                    
                      type: DateFormatType.type2,
                      onComplete: (date){
                          print(date.toString);
                      }
                  ),
                )
                  ],
                  
                )
              )))
    ));
  
  }
}