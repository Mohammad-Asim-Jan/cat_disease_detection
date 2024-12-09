import 'package:cat_disease_detection/services/roboflow_service.dart';

import '../utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ScanDiseaseView extends StatefulWidget {
  const ScanDiseaseView({super.key});

  @override
  _ScanDiseaseViewState createState() => _ScanDiseaseViewState();
}

class _ScanDiseaseViewState extends State<ScanDiseaseView> {
  File? _image; // To store the captured or uploaded image
  final ImagePicker _picker = ImagePicker();

  // Function to take a picture using the camera
  Future<void> _takePicture() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  // Function to upload an image from the gallery
  Future<void> _uploadImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  // Function to simulate the analysis process
  void _analyzeImage() async {
    if (_image != null) {
      // Logic to submit the image for analysis
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Analyzing image...')),
      );
      final RoboflowService _roboflowService = RoboflowService();
      final response = await _roboflowService.detectDisease(_image!);

      debugPrint(response.toString());

      /// todo:

      // You can call a function here to pass the image to your ML model.
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Please upload or capture an image first!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Scan Diseases"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Display the selected image or placeholder
            Container(
              height: 300.0,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: _image != null
                  ? Image.file(
                      _image!,
                      fit: BoxFit.cover,
                    )
                  : const Center(child: Text('No image selected')),
            ),
            const SizedBox(height: 16.0),

            // Instructions on how to capture a good image
            const Text(
              'Please take a clear picture of your pet’s affected area for accurate analysis.',
              style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.red),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16.0),

            // Buttons to take a picture or upload an image
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: _takePicture,
                  icon: const Icon(
                    Icons.camera_alt,
                    color: Colors.orange,
                  ),
                  label: const Text(
                    'Take Picture',
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: _uploadImage,
                  icon: const Icon(
                    Icons.upload,
                    color: Colors.orange,
                  ),
                  label: const Text('Upload Image'),
                ),
              ],
            ),
            const SizedBox(height: 16.0),

            // Analyze button to submit the image
            ElevatedButton(
              onPressed: _analyzeImage,
              style: ElevatedButton.styleFrom(
                backgroundColor: Constants.mainColor,
                padding: const EdgeInsets.symmetric(
                    vertical: 16.0, horizontal: 32.0),
              ),
              child: const Text(
                'Analyze Image',
                style: TextStyle(fontSize: 18.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
