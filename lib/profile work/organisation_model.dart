class Organisation {
  final String organizationName;
  final String organizationEmail;
  late final String organizationLogoUrl;

  final String phoneNumber;
  final String orgId;

  Organisation( {
    required this.organizationEmail,
    required this.organizationName,
    required this.organizationLogoUrl,
    required this.phoneNumber,
    required this.orgId,

    // this.organizationLogoUrl = '', // Initialized as empty string
    //this.imageUrl = '', // Initialized as empty string
  });

  // Add any additional methods if needed
}
