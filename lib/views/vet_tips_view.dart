import 'package:flutter/material.dart';

import '../models/vet_recommendation_model.dart';

class VetTipsView extends StatefulWidget {
  const VetTipsView({super.key});

  @override
  State<VetTipsView> createState() => _VetTipsViewState();
}

class _VetTipsViewState extends State<VetTipsView> {
  // Sample list of recommendations
  final List<VetRecommendation> _recommendations = [
    VetRecommendation(
      title: 'Regular Vaccinations',
      description:
      'Ensure your pet is up-to-date with vaccinations to prevent common diseases.',
      icon: Icons.vaccines,
    ),
    VetRecommendation(
      title: 'Balanced Diet',
      description:
      'Provide a balanced diet to keep your pet healthy and energetic.',
      icon: Icons.food_bank,
    ),
    VetRecommendation(
      title: 'Exercise Routine',
      description:
      'Create an exercise routine to keep your pet fit and active.',
      icon: Icons.directions_run,
    ),
    VetRecommendation(
      title: 'Flea and Tick Prevention',
      description:
      'Regularly check and treat your pet to prevent flea and tick infestations.',
      icon: Icons.pest_control,
    ),
    VetRecommendation(
      title: 'Routine Check-ups',
      description:
      'Take your pet for routine check-ups to detect any early health issues.',
      icon: Icons.check_circle,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vet Tips'),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: _recommendations.length,
        itemBuilder: (context, index) {
          final recommendation = _recommendations[index];
          return Card(
            elevation: 4.0,
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            child: ListTile(
              leading: Icon(
                recommendation.icon,
                size: 40.0,
                color: Colors.amber,
              ),
              title: Text(
                recommendation.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
              subtitle: Text(recommendation.description),
            ),
          );
        },
      ),
    );
  }
}
