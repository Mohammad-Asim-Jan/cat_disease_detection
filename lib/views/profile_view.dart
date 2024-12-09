import 'dart:io';
import 'package:cat_disease_detection/view_models/profile_view_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../utils/show_snack_bar.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  ProfileViewModel profileViewModel = ProfileViewModel();
  bool _loading = true;

  bool _isDarkMode = false;

  @override
  void initState() {
    super.initState();
    getDataFromSupabase();

    /// getPets

    _loadTheme();
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
              TextFormField(
                controller: profileViewModel.nameC,
                decoration: const InputDecoration(labelText: "Name"),
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
              onPressed: () async {
                await profileViewModel.updateUser(context);
                setState(() {});
                Navigator.pop(context);
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }

  getDataFromSupabase() async {
    profileViewModel.userProfile = await profileViewModel.getUserProfile();
    await profileViewModel.getCatProfiles();
    debugPrint('User Name: ${profileViewModel.userProfile.userName}');
    debugPrint('User email: ${profileViewModel.userProfile.userEmail}');

    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
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

  Widget _buildUserProfileSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("User Profile",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        ListTile(
          leading: GestureDetector(
            onTap: () async {
              await profileViewModel.uploadUserImageToSupabase(context);
              setState(() {
                debugPrint('User picture url:');
                debugPrint(profileViewModel.userProfile.userPicture);
                // _image = profileViewModel.newImage;
                // _userProfile.userPicture = _image;
              });
            },
            child: CircleAvatar(
              backgroundImage: profileViewModel.userProfile.userPicture == null
                  ? null
                  : NetworkImage(
                      '${profileViewModel.userProfile.userPicture!}?timestamp=${DateTime.now().millisecondsSinceEpoch}',
                      // profileViewModel.userProfile.userPicture!
                    ),
              radius: 30,
              child: profileViewModel.userProfile.userPicture == null
                  ? const Icon(
                      Icons.person,
                      size: 35,
                    )
                  : null,
            ),
          ),
          title: Text(profileViewModel.userProfile.userName),
          subtitle: Text(profileViewModel.userProfile.userEmail),
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
          profileViewModel.petProfiles.isEmpty
              ? const Center(child: Text('No cat profile!\n'))
              : Expanded(
                  child: ListView.builder(
                    itemCount: profileViewModel.petProfiles.length,
                    itemBuilder: (context, index) {
                      final pet = profileViewModel.petProfiles[index];
                      return ListTile(
                        leading: GestureDetector(
                          onTap: () async {
                            await profileViewModel.uploadCatImageToSupabase(
                                context, index);
                            setState(() {
                              debugPrint('Cat picture url:');
                              debugPrint(
                                  profileViewModel.petProfiles[index].catImage);
                              // _image = profileViewModel.newImage;
                              // _userProfile.userPicture = _image;
                            });
                          },
                          child: CircleAvatar(
                            backgroundImage: pet.catImage == null
                                ? null
                                : NetworkImage(
                                    '${pet.catImage!}?timestamp=${DateTime.now().millisecondsSinceEpoch}'),
                            radius: 30,
                            child: pet.catImage == null
                                ? const Icon(
                                    Icons.person,
                                    size: 35,
                                  )
                                : null,
                          ),
                        ),
                        title: Text(pet.catName),
                        subtitle: Text(pet.catAge.toString()),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () {
                                  editPetProfile(context, index);
                                  setState(() {
                                    // Edit pet profile
                                  });
                                }),
                            IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () async {
                                  await profileViewModel.deletePetProfile(
                                      index); // Delete pet profile
                                  setState(() {});
                                }),
                          ],
                        ),
                      );
                    },
                  ),
                ),
          ElevatedButton.icon(
              icon: const Icon(Icons.add),
              label: const Text("Add Pet"),
              onPressed: () {
                addPetProfile(context);
              }
              // Add new pet
              ),
        ],
      ),
    );
  }

  // Function to edit an existing pet profile
  void editPetProfile(BuildContext context, int index) async {
    String petName = profileViewModel.petProfiles[index].catName;
    int? petAge = profileViewModel.petProfiles[index].catAge;

    TextEditingController nameC = TextEditingController(text: petName);
    TextEditingController ageC = TextEditingController(text: petAge.toString());

    // Display a dialog to edit pet details
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Edit Cat Profile"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(labelText: "Cat Name"),
                controller: nameC,
                onChanged: (value) {
                  petName = value;
                },
              ),
              TextField(
                decoration: const InputDecoration(labelText: "Cat Age"),
                controller: ageC,
                onChanged: (value) {
                  petAge = int.tryParse(value);
                },
              ),
              // Optionally allow changing photo
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () async {
                await Supabase.instance.client
                    .from('catProfile')
                    .update({'catName': petName, 'catAge': petAge})
                    .eq('catId', profileViewModel.petProfiles[index].catId)
                    .then(
                      (value) {
                        ShowSnackBar.getSnackBar(
                            context, 'Cat updated successfully!');
                        // Save changes to pet profile
                        setState(() {
                          profileViewModel.petProfiles[index].catName = petName;
                          profileViewModel.petProfiles[index].catAge =
                              petAge ?? 0;
                        });
                      },
                    )
                    .onError(
                      (error, stackTrace) {
                        ShowSnackBar.getSnackBar(context, '$error');
                      },
                    );
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
  void addPetProfile(BuildContext context) {
    // Show a dialog to add pet details
    showDialog(
      context: context,
      builder: (context) {
        String petName = '';
        String petAge = ''; // Default pet image

        return AlertDialog(
          title: const Text("Add New Cat"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(labelText: "Cat Name"),
                onChanged: (value) {
                  petName = value;
                },
              ),
              TextField(
                decoration: const InputDecoration(labelText: "Cat Age"),
                onChanged: (value) {
                  petAge = value;
                },
              ),
              // Add input for photo or use default
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () async {
                String userId = Supabase.instance.client.auth.currentUser!.id;
                final response =
                    await Supabase.instance.client.from('catProfile').insert({
                  'userId': userId,
                  'catName': petName,
                  'catAge': petAge,
                  'catImage': null,
                });

                if (response == null) {
                  await profileViewModel.getCatProfiles();
                  setState(() {});
                  ShowSnackBar.getSnackBar(
                      context, 'Profile added successfully!');
                } else {
                  ShowSnackBar.getSnackBar(
                      context, 'Error: ${response.error!.message}');
                }
                Navigator.pop(context);
              },
              child: const Text("Add"),
            ),
          ],
        );
      },
    );
  }
}
