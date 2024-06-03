import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:secondapp/Theme/colors.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:secondapp/profile%20work/announcement_model.dart';

class AnnouncementCard extends StatefulWidget {
  final Announcement announcement;
  final VoidCallback? onDetailsPressed;
  const AnnouncementCard(
      {super.key, required this.announcement, required this.onDetailsPressed});

  @override
  State<AnnouncementCard> createState() => _AnnouncementCardState();
}

class _AnnouncementCardState extends State<AnnouncementCard> {
  double donationProgress = 0.0;

  @override
  void initState() {
    super.initState();
    updateDonationProgress();
  }

  void updateDonationProgress() {
    setState(() {
      donationProgress = double.parse(widget.announcement.quantityDonated) /
          double.parse(widget.announcement.quantityNeeded);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onDetailsPressed,
      child: Column(
        children: [
          Container(
            height: 77,
            width: double.infinity,
            decoration: const BoxDecoration(
                color: AppColors.containercolor,
                border: Border(
                    top: BorderSide(color: AppColors.highicons),
                    bottom: BorderSide(color: AppColors.highicons))),
            child: Stack(
              children: [
                //Announcement pic
                Positioned(
                  top: 10,
                  left: 20,
                  bottom: 5,
                  child: ClipOval(
                    child: SizedBox(
                        height: 54,
                        width: 54,
                        child: Image.network(
                          widget.announcement.imageUrl,
                          fit: BoxFit.cover,
                        )),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Positioned(
                  top: 10,
                  left: 85,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          widget.announcement.annonceTitle,
                          style: const TextStyle(
                              fontSize: 16,
                              color: AppColors.icons,
                              fontWeight: FontWeight.w800),
                        ),
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      LinearPercentIndicator(
                        width: 200,
                        lineHeight: 11.0,
                        percent: donationProgress,
                        barRadius: const Radius.circular(7),
                        center: Text(
                          '${((double.parse(widget.announcement.quantityDonated) / double.parse(widget.announcement.quantityNeeded)) * 100).toStringAsFixed(0)}%',
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 10.0),
                        ),
                        backgroundColor: AppColors.background,
                        progressColor: AppColors.highicons,
                      ),

                      const SizedBox(
                        height: 3,
                      ),
                      //Announcement creation time
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          widget.announcement.endDate,
                          style: const TextStyle(
                              color: AppColors.smalltext,
                              fontSize: 14,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
