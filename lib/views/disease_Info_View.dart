import 'package:flutter/material.dart';
import '../models/disease_model.dart'; // Import the model

class DiseaseInfoView extends StatelessWidget {
  final Disease disease;

  const DiseaseInfoView({super.key, required this.disease});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(disease.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with Disease Name and Image
              Center(
                child: Column(
                  children: [
                    Image.asset(
                      disease.imagePath,
                      height: 150,
                      width: 150,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      disease.name,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Symptoms Section
              const Text(
                'Symptoms',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              ...disease.symptoms.map((symptom) => ListTile(
                    leading: const Icon(Icons.check_circle_outline),
                    title: Text(symptom),
                  )),

              const SizedBox(height: 16),

              // Causes Section
              const Text(
                'Causes',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(disease.causes),

              const SizedBox(height: 16),

              // Treatment Section
              const Text(
                'Treatment',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(disease.treatment),

              const SizedBox(height: 24),

              // Buttons Section
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     ElevatedButton(
              //       onPressed: () {
              //         // Add logic to learn more about the disease
              //       },
              //       child: const Text('Learn More'),
              //     ),
              //     ElevatedButton(
              //       onPressed: () {
              //         // Add logic to contact a vet
              //       },
              //       child: const Text('Contact Vet'),
              //     ),
              //     ElevatedButton(
              //       onPressed: () {
              //         // Add logic for related diseases
              //         Navigator.pushNamed(
              //           context, '/');
              //       },
              //       child: const Text('Related Diseases'),
              //     ),
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
