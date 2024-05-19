import 'package:flutter/material.dart';
import 'package:secondapp/Theme/colors.dart';

class Information extends StatelessWidget {
  final String insideinfo;
  final String indicator;
  final bool suffixexist;
  final String category;
  const Information(
      {super.key,
      required this.indicator,
      required this.insideinfo,
      required this.suffixexist,
      required this.category});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          indicator,
          style: const TextStyle(
              fontFamily: 'Nunito',
              fontSize: 14,
              color: AppColors.icons,
              fontWeight: FontWeight.w700),
        ),
        const SizedBox(
          height: 5,
        ),
        Container(
          width: double.infinity,
          decoration: const BoxDecoration(
              border: Border(
                  bottom: BorderSide(color: AppColors.icons, width: 1.02))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                insideinfo,
                style: const TextStyle(
                    color: Colors.black,
                    fontFamily: 'Nunito',
                    fontSize: 17.8,
                    fontWeight: FontWeight.w400),
              ),
              Text(
                suffixexist
                    ? category == 'money'
                        ? 'DA'
                        : 'person'
                    : '',
                style: const TextStyle(
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.w400,
                    fontSize: 17.8,
                    color: AppColors.clear),
              ),
            ],
          ),
        )
      ],
    );
  }
}
