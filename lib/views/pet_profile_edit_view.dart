import 'package:flutter/material.dart';
import '../models/pet_profile_model.dart';

class PetProfileEdit extends StatefulWidget {
  final PetProfile petProfile;

  const PetProfileEdit({required this.petProfile, super.key});

  @override
  _PetProfileEditState createState() => _PetProfileEditState();
}

class _PetProfileEditState extends State<PetProfileEdit> {
  late TextEditingController _nameController;
  late TextEditingController _ageController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.petProfile.catName);
    _ageController =
        TextEditingController(text: widget.petProfile.catAge.toString());
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Pet Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _ageController,
              decoration: const InputDecoration(labelText: 'Age'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Pass updated pet profile back
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
