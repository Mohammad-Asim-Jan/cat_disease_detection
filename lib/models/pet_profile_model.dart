class PetProfile {
  String name;
  String age;
  String? photo;

  PetProfile({
    required this.name,
    required this.age,
    this.photo,
  });
}