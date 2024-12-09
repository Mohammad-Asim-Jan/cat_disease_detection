class PetProfile {
  String userId;
  int catId;
  String catName;
  int catAge;
  String? catImage;

  PetProfile({
    required this.userId,
    required this.catId,
    required this.catName,
    required this.catAge,
    this.catImage,
  });

  factory PetProfile.fromJson(Map<String, dynamic> json) {
    return PetProfile(
        userId: json['userId'],
        catId: json['catId'],
        catName: json['catName'],
        catAge: json['catAge'],
        catImage: json['catImage']);
  }
}
