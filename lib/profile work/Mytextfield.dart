import 'package:flutter/material.dart';
import 'package:secondapp/Theme/colors.dart';

class Mytextfield extends StatelessWidget {
  final double height;

  final String text;
  const Mytextfield({super.key, required this.height,required this.text});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height:height,
      width: double.infinity,
      child: TextField(
        maxLines: null,
    expands: true,
        decoration: InputDecoration(
          labelText: text,
           floatingLabelBehavior: FloatingLabelBehavior.always,
            labelStyle: const TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 14,
                  color: AppColors.icons,
                  fontWeight: FontWeight.w700,
                ),
                
                enabledBorder:  OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: AppColors.icons,width: 2)),
                    focusedBorder:  OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: AppColors.icons,width: 2)),
               
          
        ),
      ),

    );
  }
}