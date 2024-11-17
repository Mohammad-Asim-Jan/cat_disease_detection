class Disease {
  final String name;
  final String imagePath;
  final List<String> symptoms;
  final String causes;
  final String treatment;
  final List<String> relatedDiseases;

  Disease({
    required this.name,
    required this.imagePath,
    required this.symptoms,
    required this.causes,
    required this.treatment,
    required this.relatedDiseases,
  });
}
