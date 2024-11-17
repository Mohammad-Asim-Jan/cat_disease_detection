// import 'package:flutter/material.dart';
// import '../models/user_profile_model.dart';
//
//
// class UserProfileEdit extends StatefulWidget {
//   final UserProfile userProfile;
//
//   const UserProfileEdit({required this.userProfile, super.key});
//
//   @override
//   _UserProfileEditState createState() => _UserProfileEditState();
// }
//
// class _UserProfileEditState extends State<UserProfileEdit> {
//   late TextEditingController _nameController;
//   late TextEditingController _emailController;
//
//   @override
//   void initState() {
//     super.initState();
//     _nameController = TextEditingController(text: widget.userProfile.name);
//     _emailController = TextEditingController(text: widget.userProfile.email);
//   }
//
//   @override
//   void dispose() {
//     _nameController.dispose();
//     _emailController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Edit User Profile'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: _nameController,
//               decoration: const InputDecoration(labelText: 'Name'),
//             ),
//             TextField(
//               controller: _emailController,
//               decoration: const InputDecoration(labelText: 'Email'),
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 // Pass updated user profile back
//                 Navigator.pop(
//                   context,
//                   UserProfile(
//                     name: _nameController.text,
//                     email: _emailController.text,
//                     profilePicture: widget.userProfile.profilePicture, // Keep the picture same
//                   ),
//                 );
//               },
//               child: const Text('Save'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
