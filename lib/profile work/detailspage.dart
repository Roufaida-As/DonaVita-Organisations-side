import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:secondapp/Theme/colors.dart';
import 'package:secondapp/profile%20work/announcement_model.dart';

class DetailsPage extends StatefulWidget {
  final Announcement annonce;
  const DetailsPage({super.key, required this.annonce});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  double donationProgress = 0.0;

  @override
  void initState() {
    super.initState();
    // updateDonationProgress();
  }

  void updateDonationProgress() {
    setState(() {
      donationProgress = double.parse(widget.annonce.quantityDonated) /
          double.parse(widget.annonce.quantityNeeded);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Details",
          textAlign: TextAlign.left,
          style: TextStyle(
            fontSize: 32,
            fontFamily: 'Nunito',
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
        padding: const EdgeInsets.all(25),
        child: Container(
          height: double.infinity,
          decoration: BoxDecoration(
              color: AppColors.containercolor,
              borderRadius: BorderRadius.circular(10)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 196,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              width:
                                  378, // Adjust width to match the image width
                              height: 196,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFFA1A1A1)
                                        .withOpacity(0.2),
                                    spreadRadius: 0, // spread radius
                                    blurRadius: 12,
                                  )
                                ],
                                borderRadius: BorderRadius.circular(10),
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.transparent,
                                    AppColors.containercolor.withOpacity(0.6),
                                  ],
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(widget.annonce.imageUrl,
                                    fit: BoxFit.cover),
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ClipOval(
                                  child: Image.network(
                                      widget.annonce.organizationLogoUrl,
                                      height: 70,
                                      fit: BoxFit.cover,
                                      width: 70),
                                ),
                                Text(widget.annonce.organizationName,
                                    style: const TextStyle(
                                      fontFamily: 'Roboto',
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.icons,
                                    )),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 2),
                      Padding(
                        padding: const EdgeInsets.only(left: 32, right: 10),
                        child: Column(
                          children: [
                            SizedBox(
                              width: double.infinity,
                              child: Text(
                                widget.annonce.annonceTitle,
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                  fontFamily: 'Roboto',
                                  color: AppColors.icons,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 32,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: Text(
                                widget.annonce.description,
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                  fontFamily: 'Roboto',
                                  color: AppColors.font,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 32, right: 32),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            const Text(
                              "Quantity needed",
                              style: TextStyle(
                                  color: AppColors.icons,
                                  fontFamily: 'Roboto',
                                  fontSize: 15),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Text(
                                  widget.annonce.quantityNeeded,
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                      fontFamily: 'Roboto',
                                      fontSize: 15,
                                      color: AppColors.details),
                                ),
                                const SizedBox(
                                  width: 2,
                                ),
                                Text(
                                  widget.annonce.category == 'money'
                                      ? ' DA'
                                      : ' persons',
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                      fontFamily: 'Roboto',
                                      fontSize: 15,
                                      color: AppColors.details),
                                ),
                              ],
                            )
                          ],
                        ),
                        Column(
                          children: [
                            const Text(
                              "Deadline",
                              style: TextStyle(
                                  color: AppColors.icons,
                                  fontFamily: 'Roboto',
                                  fontSize: 15),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              widget.annonce.endDate,
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 15,
                                  color: AppColors.details),
                            ),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        LinearPercentIndicator(
                          width: 200.0,
                          lineHeight: 11.0,
                          percent: donationProgress,
                          center: Text(
                            '${((double.parse(widget.annonce.quantityDonated) / double.parse(widget.annonce.quantityNeeded)) * 100).toStringAsFixed(0)}%',
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 10.0),
                          ),
                          barRadius: const Radius.circular(7),
                          backgroundColor: AppColors.background,
                          progressColor: AppColors.highicons,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
