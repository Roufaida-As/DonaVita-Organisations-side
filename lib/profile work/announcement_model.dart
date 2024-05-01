class Announcement {
  final String organizationName;
  late final String organizationLogoUrl;
  final String category;
  final String annonceTitle;
  final String description;
  final String quantityNeeded;
  final String quantityDonated;
  final String endDate;
  final String orgId;
  final String annonceId;
  late final String imageUrl;
  final String time;

  //final String organizationLogoPath;
  //final String announcementImagePath;

  Announcement({
    required this.time,
    required this.organizationName,
    required this.organizationLogoUrl,
    required this.category,
    required this.annonceTitle,
    required this.description,
    required this.quantityNeeded,
    required this.quantityDonated,
    required this.endDate,
    required this.imageUrl,
    required this.annonceId,
    required this.orgId,

    // this.organizationLogoUrl = '', // Initialized as empty string
    //this.imageUrl = '', // Initialized as empty string
  });

  // Add any additional methods if needed
}
