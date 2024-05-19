// ignore: file_names
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:secondapp/Theme/colors.dart';
import 'package:secondapp/notifications%20work/Donnation_model.dart';
import 'package:secondapp/notifications%20work/donnor_details.dart';
import 'package:secondapp/notifications%20work/fetch_profilepic.dart';

class DonnationCard extends StatefulWidget {
  final Donnation donnation;
  const DonnationCard({super.key, required this.donnation});

  @override
  State<DonnationCard> createState() => _DonnationCardState();
}

class _DonnationCardState extends State<DonnationCard> {
  final db = FirebaseFirestore.instance;
  late Fetchpic fetchpic;
  String picpath = '';

  @override
  void initState() {
    super.initState();
    fetchpic = Fetchpic(widget.donnation.personId);
    fetchData();
  }

  void fetchData() async {
    String fetchedPicPath = await fetchpic.getPic();
    setState(() {
      picpath = fetchedPicPath;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 1.5, bottom: 1.5),
      child: Container(
        width: double.infinity,
        height: 65,
        decoration: BoxDecoration(
          color: widget.donnation.seen ? AppColors.smallfont : AppColors.clear,
          border: Border.all(
            color: AppColors.highicons,
            width: 1,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.network(
                        picpath,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      width: 15,
                      height: 15,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: widget.donnation.seen
                            ? Colors.transparent
                            : AppColors.highicons,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 5),
              SizedBox(
                width: 100,
                child: Text(
                  widget.donnation.fullname,
                  style: const TextStyle(
                    color: AppColors.details,
                    fontFamily: 'Nunito',
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 7),
              const Text(
                'donated',
                style: TextStyle(
                  color: AppColors.details,
                  fontFamily: 'Nunito',
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 20),
              GestureDetector(
                onTap: () {
                  db
                      .collection('organisationsAsUsers')
                      .doc(widget.donnation.orgId)
                      .collection('annonces')
                      .doc(widget.donnation.annonceId)
                      .collection('Donations')
                      .doc(widget.donnation.donnationId)
                      .update({"seen": true});
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) =>
                          Donnordetails(donnation: widget.donnation),
                    ),
                  );
                },
                child: const Text(
                  'show more',
                  style: TextStyle(
                    color: AppColors.details,
                    fontFamily: 'Nunito',
                    fontSize: 11,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
