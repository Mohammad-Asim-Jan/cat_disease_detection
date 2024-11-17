import 'package:flutter/material.dart';
import '../models/disease_model.dart';
import 'disease_Info_View.dart'; // Import the Disease model

class BrowseDiseasesView extends StatelessWidget {
  const BrowseDiseasesView({super.key});

  @override
  Widget build(BuildContext context) {
    // Example list of diseases
    final List<Disease> diseases = [
      Disease(
        name: 'Upper Respiratory Infection (URI)',
        imagePath: 'assets/images/cat&HR.png',
        symptoms: [
          'Sneezing',
          'Coughing',
          'Nasal discharge',
        ],
        causes:
            'Viral or bacterial infection affecting the upper respiratory tract.',
        treatment: 'Antibiotics, hydration, and supportive care.',
        relatedDiseases: ['Feline Calicivirus', 'Feline Herpesvirus'],
      ),
      Disease(
        name: 'Ringworm',
        imagePath: 'assets/images/cat&HR.png',
        symptoms: [
          'Circular patches of hair loss',
          'Red or scaly skin',
        ],
        causes: 'Fungal infection caused by dermatophytes.',
        treatment: 'Antifungal medications and topical ointments.',
        relatedDiseases: ['Fungal Dermatitis', 'Feline Dermatophytosis'],
      ),
      // Add more diseases here
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Browse Disease'),),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: diseases.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading:
                Image.asset(diseases[index].imagePath, height: 40, width: 40),
            title: Text(diseases[index].name),
            subtitle: const Text('Tap to view details'),
            onTap: () {
              // Navigate to DiseaseInfoPage
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DiseaseInfoView(disease: diseases[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
