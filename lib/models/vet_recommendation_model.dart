import 'package:flutter/material.dart';

class VetRecommendation {
  final String title;
  final String description;
  final IconData icon;

  VetRecommendation({
    required this.title,
    required this.description,
    this.icon = Icons.health_and_safety, // Default icon
  });
}
