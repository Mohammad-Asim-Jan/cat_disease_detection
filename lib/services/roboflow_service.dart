import 'dart:convert';
import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RoboflowService {
  Future<File> resizeImage(File imageFile) async {
    final bytes = await imageFile.readAsBytes();
    final codec = await ui.instantiateImageCodec(bytes,
        targetWidth: 512); // Resize to 512px width
    final frame = await codec.getNextFrame();
    final resizedImage =
        await frame.image.toByteData(format: ui.ImageByteFormat.png);

    final resizedFile = File(imageFile.path)
      ..writeAsBytesSync(resizedImage!.buffer.asUint8List());
    return resizedFile;
  }

  Future<Map<String, dynamic>> detectDisease(File? imageFile) async {
    const apiKey = 'co1IDRFUb07jLdsWgDfr';
    const modelEndpoint =
        "https://detect.roboflow.com/cat-disease-detection/3?api_key=$apiKey";

    if (imageFile == null) {
      return {'error': 'No image file provided'};
    }

    try {
      // Ensure file exists
      if (!await imageFile.exists()) {
        return {'error': 'Image file does not exist'};
      }

      // Resize image if needed
      imageFile = await resizeImage(imageFile);

      // Convert the image file to Base64
      final bytes = await imageFile.readAsBytes();
      final String base64Image = base64Encode(bytes);

      // Determine MIME type dynamically
      final mimeType =
          imageFile.path.endsWith('.png') ? 'image/png' : 'image/jpeg';
      final String base64ImageWithMimeType =
          "data:$mimeType;base64,$base64Image";

      // Log for debugging
      print("Full Base64 Image: $base64ImageWithMimeType");

      debugPrint("Detected MIME Type: $mimeType");

      // Prepare API request
      final response = await http.post(
        Uri.parse(modelEndpoint),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'image': base64ImageWithMimeType}),
      );

      // Handle response
      if (response.statusCode == 200) {
        debugPrint("API Response: ${response.body}");
        return jsonDecode(response.body); // Parse and return JSON response
      } else {
        debugPrint('API Error: ${response.statusCode} - ${response.body}');
        return {'error': 'Error: ${response.statusCode} - ${response.body}'};
      }
    } catch (e) {
      // Catch and return any errors
      debugPrint('Error during API request: $e');
      return {'error': e.toString()};
    }
  }
}
