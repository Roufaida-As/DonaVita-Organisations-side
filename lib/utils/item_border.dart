import 'package:flutter/material.dart';

// ignore: camel_case_types
class Border_ extends StatelessWidget {
  final String imagePath;
  const Border_({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6),
      /*decoration: BoxDecoration(
          //border: Border.all(color: AppColors.smalltext),
          // borderRadius: BorderRadius.circular(10),
          ),*/
      child: Image.asset(
        imagePath,
        height: 53,
        // width: 91,
      ),
    );
  }

  static all({required Color color}) {}
}