import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/pet_profile_model.dart';
import '../models/user_profile_model.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  late UserProfile _userProfile;
  late UserProfile _userProfile;

  late List<PetProfile> _petProfiles;
  bool _isDarkMode = false;
  File? _image;

  @override
  void initState() {
    super.initState();


    String? email = Supabase.instance.client.auth.currentUser?.email;

    /// todo: check if the user name is already there, then don't get name from email
    String name = email == null ? 'example' : extractUsername(email);

    getUserProfileImageFromDirectory();

    // Initialize user profile
    _userProfile = UserProfile(
      userId: '1',
      userName: name.toUpperCase(),
      userEmail: email ?? 'example@gmail.com',
      userPicture: _image, // Placeholder image
    );

    // Initialize list of pet profiles
    _petProfiles = [
      PetProfile(name: "Max", age: "2 years", photo: null),
      PetProfile(name: "Bella", age: "3 years", photo: null),
    ];

    // Load theme mode from shared preferences
    _loadTheme();
  }

  getUserProfileImageFromDirectory() async {
    // Get the path to save the image
    final String imagePath = await _getImageStoragePath();

    // Delete the previous image if it exists
    _image = File(imagePath);
    // setState(() {
    //   _userProfile.profilePicture = _image;
    // });
  }

  // Get the name from the email address
  String extractUsername(String email) {
    // Find the index of the '@' character
    int atIndex = email.indexOf('@');

    // If the '@' character is found, return the substring before it
    if (atIndex != -1) {
      return email.substring(0, atIndex);
    }

    // Return an empty string if the email format is invalid
    return '';
  }

  // Toggle between dark and light mode
  void _toggleTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isDarkMode = !_isDarkMode;
      prefs.setBool('isDarkMode', _isDarkMode);
    });
  }

  // Load the theme mode from shared preferences
  Future<void> _loadTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isDarkMode = prefs.getBool('isDarkMode') ?? false;
    });
  }

  // Function to edit user profile
  void _editUserProfile() {
    // Display a dialog or a new screen to allow user to edit profile
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Edit Profile"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(labelText: "Name"),
                onChanged: (value) {
                  _userProfile.userName = value;
                },
              ),
              // TextField(
              //   decoration: const InputDecoration(labelText: "Email"),
              //   onChanged: (value) {
              //     _userProfile.email = value;
              //   },
              // ),
              // Add more fields if needed, like updating the profile picture
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                // Save changes
                setState(() {
                  // Persist changes or save to a database
                });
                Navigator.pop(context);
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }

  // Function to add a new pet profile
  void _addPetProfile() {
    // Show a dialog to add pet details
    showDialog(
      context: context,
      builder: (context) {
        String petName = '';
        String petAge = '';
        String petPhoto = 'assets/images/default_pet.png'; // Default pet image

        return AlertDialog(
          title: const Text("Add New Pet"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(labelText: "Pet Name"),
                onChanged: (value) {
                  petName = value;
                },
              ),
              TextField(
                decoration: const InputDecoration(labelText: "Pet Age"),
                onChanged: (value) {
                  petAge = value;
                },
              ),
              // Add input for photo or use default
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                // Add new pet to the list
                setState(() {
                  _petProfiles.add(PetProfile(
                    name: petName,
                    age: petAge,
                    photo: petPhoto,
                  ));
                });
                Navigator.pop(context);
              },
              child: const Text("Add"),
            ),
          ],
        );
      },
    );
  }

  // Function to edit an existing pet profile
  void _editPetProfile(PetProfile pet) {
    // Display a dialog to edit pet details
    showDialog(
      context: context,
      builder: (context) {
        String petName = pet.name;
        String petAge = pet.age;
        String? petPhoto = pet.photo;

        return AlertDialog(
          title: const Text("Edit Pet Profile"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(labelText: "Pet Name"),
                controller: TextEditingController(text: petName),
                onChanged: (value) {
                  petName = value;
                },
              ),
              TextField(
                decoration: const InputDecoration(labelText: "Pet Age"),
                controller: TextEditingController(text: petAge),
                onChanged: (value) {
                  petAge = value;
                },
              ),
              // Optionally allow changing photo
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                // Save changes to pet profile
                setState(() {
                  pet.name = petName;
                  pet.age = petAge;
                  pet.photo = petPhoto; // Update the photo if allowed
                });
                Navigator.pop(context);
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }

  // Function to delete a pet profile
  void _deletePetProfile(PetProfile pet) {
    setState(() {
      _petProfiles.remove(pet);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User Profile Section
            _buildUserProfileSection(),

            const SizedBox(height: 6.0),
            const Divider(
              thickness: 2.3,
              color: Colors.grey,
            ),
            const SizedBox(height: 16.0),

            // Pet Profiles Section
            _buildPetProfilesSection(),

            const SizedBox(height: 16.0),

            // Dark Mode Toggle
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Dark Mode"),
                Switch(
                  value: _isDarkMode,
                  onChanged: (value) {
                    _toggleTheme();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Pick an image from the gallery or camera
  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      // Get the path to save the image
      final String imagePath = await _getImageStoragePath();

      // Delete the previous image if it exists
      final File previousImage = File(imagePath);
      if (previousImage.existsSync()) {
        await previousImage.delete();
        print("Previous image deleted.");
      }

      // Save the new image to the same path
      final File newImage = File(imagePath);
      await pickedFile.saveTo(newImage.path);

      setState(() {
        _image = newImage;
        _userProfile.userPicture = _image;
      });

      print("Image saved to: ${newImage.path}");
    }
  }

  // Get the path where you want to store the image
  Future<String> _getImageStoragePath() async {
    final directory = await getApplicationDocumentsDirectory();
    return '${directory.path}/profile_image.jpg'; // You can choose your own file name
  }

  // // Pick an image from the gallery or camera
  // Future<void> _pickImage() async {
  //   final ImagePicker _picker = ImagePicker();
  //   final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
  //   if (pickedFile != null) {
  //     setState(() {
  //       _image = File(pickedFile.path);
  //       _userProfile.profilePicture = _image;
  //     });
  //
  //     // Save the image to local storage
  //     await _saveImage(pickedFile);
  //   }
  // }
  //
  // // Save the image to the app's document directory
  // Future<void> _saveImage(XFile pickedFile) async {
  //   try {
  //     // Get the application's documents directory
  //     final directory = await getApplicationDocumentsDirectory();
  //
  //     // Create a file path to save the image
  //     final filePath = '${directory.path}/${pickedFile.name}';
  //     final File localFile = File(filePath);
  //
  //     // Copy the picked image to the local file
  //     await pickedFile.saveTo(localFile.path);
  //
  //     print("Image saved to: ${localFile.path}");
  //   } catch (e) {
  //     print("Error saving image: $e");
  //   }
  // }

  // Build the user profile section
  Widget _buildUserProfileSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("User Profile",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        ListTile(
          leading: GestureDetector(
            onTap: _pickImage,
            child: CircleAvatar(
              backgroundImage: _userProfile.userPicture == null
                  ? null
                  : FileImage(_userProfile.userPicture!),
              radius: 30,
              child: _userProfile.userPicture == null
                  ? const Icon(
                      Icons.person,
                      size: 35,
                    )
                  : null,
            ),
          ),
          title: Text(_userProfile.userName),
          subtitle: Text(_userProfile.userEmail),
          trailing: IconButton(
            icon: const Icon(Icons.edit),
            onPressed: _editUserProfile, // Edit user profile
          ),
        ),
      ],
    );
  }

  // Build the pet profiles section
  Widget _buildPetProfilesSection() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Pet Profiles",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: _petProfiles.length,
              itemBuilder: (context, index) {
                final pet = _petProfiles[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage:
                        pet.photo == null ? null : AssetImage(pet.photo!),
                    radius: 30,
                    child: pet.photo == null
                        ? const Icon(
                            Icons.person,
                            size: 35,
                          )
                        : null,
                  ),
                  title: Text(pet.name),
                  subtitle: Text(pet.age),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () =>
                            _editPetProfile(pet), // Edit pet profile
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () =>
                            _deletePetProfile(pet), // Delete pet profile
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          ElevatedButton.icon(
            icon: const Icon(Icons.add),
            label: const Text("Add Pet"),
            onPressed: _addPetProfile, // Add new pet
          ),
        ],
      ),
    );
  }
}
