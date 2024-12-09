import 'dart:io';

import 'package:cat_disease_detection/models/user_profile_model.dart';
import 'package:cat_disease_detection/utils/show_snack_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/pet_profile_model.dart';

class ProfileViewModel {
  late UserProfile userProfile;
  late List<PetProfile> petProfiles = [];

  TextEditingController nameC = TextEditingController();

  // late File newImage;

  Future<void> addUserProfile(BuildContext context, String userId,
      String userName, String userEmail, String? userPicture) async {
    final response = await Supabase.instance.client.from('userProfile').insert({
      'userId': userId,
      'userName': userName,
      'userEmail': userEmail,
      'userPicture': userPicture,
    });

    if (response == null) {
      ShowSnackBar.getSnackBar(context, 'Profile added successfully!');
    } else {
      ShowSnackBar.getSnackBar(context, 'Error: ${response.error!.message}');
    }
  }

  Future<UserProfile> getUserProfile() async {
    String userId = Supabase.instance.client.auth.currentUser!.id;
    final response = await Supabase.instance.client
        .from('userProfile')
        .select()
        .eq('userId', userId)
        .limit(1)
        .maybeSingle();
    if (response != null) {
      return UserProfile.fromJson(response);
    } else {
      return UserProfile(
          userId: 'userId',
          userName: 'userName',
          userEmail: 'userEmail',
          userPicture: null);
    }
  }

  Future<void> updateUser(BuildContext context) async {
    String userId = Supabase.instance.client.auth.currentUser!.id;
    final response = await Supabase.instance.client.from('userProfile').update({
      'userName': nameC.text.trim(),
    }).eq('userId', userId);

    if (response == null) {
      ShowSnackBar.getSnackBar(context, 'Profile updated successfully!');
      userProfile = UserProfile(
        userId: userProfile.userId,
        userName: nameC.text.trim(),
        userEmail: userProfile.userEmail,
        userPicture: userProfile.userPicture,
      );
    } else {
      ShowSnackBar.getSnackBar(context, '${response.error!.message}');
    }
  }

  // Pick an image from the gallery or camera
  Future<XFile?> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);
    return pickedFile;
  }

  Future<void> uploadUserImageToSupabase(BuildContext context) async {
    final pickedFile = await pickImage();
    if (pickedFile != null) {
      String userId = Supabase.instance.client.auth.currentUser!.id;

      final file = File(pickedFile.path);
      final fileName = userId;

      try {
        // if the image exists, then delete that before uploading another
        if (userProfile.userPicture != null) {
          // final List<FileObject> response;
          userProfile.userPicture = null;
          // Delete the image in supabase
          await Supabase.instance.client.storage
              .from('profiles')
              .remove([fileName]).then(
            (value) {
              debugPrint('Profile picture removed!');
            },
          ).onError(
            (error, stackTrace) {
              debugPrint('Failed to remove profile picture!');
            },
          );
          // debugPrint('Response: $response');
          // if (response.isEmpty) {
          //   ShowSnackBar.getSnackBar(
          //       context, 'Profile picture error deleting!');
          // } else {
          //   ShowSnackBar.getSnackBar(context, 'Profile picture deleted!');
          // }
        }
        // else {
        // String response =
        await Supabase.instance.client.storage
            .from('profiles') // Use the name of your bucket
            .upload(fileName, file)
            .then(
          (value) async {
            if (value.isNotEmpty) {
              debugPrint('Value: $value');
              debugPrint('ALL right!');
              ShowSnackBar.getSnackBar(context, 'Image uploaded successfully!');
              final publicUrl = Supabase.instance.client.storage
                  .from('profiles') // Replace with your bucket name
                  .getPublicUrl(fileName);
              debugPrint('File Name: $fileName');
              userProfile.userPicture = publicUrl;
              final response = await Supabase.instance.client
                  .from('userProfile')
                  .update({
                    'userPicture': publicUrl,
                  })
                  .eq('userId', userId)
                  .then(
                    (value) {
                      debugPrint('Url updated!');
                      ShowSnackBar.getSnackBar(context, 'Url updated!');
                    },
                  )
                  .onError(
                    (error, stackTrace) {
                      debugPrint('Url failed to upload!');
                      ShowSnackBar.getSnackBar(
                          context, 'Url failed to upload!');
                    },
                  );
            } else {
              debugPrint('Upload failed: $value');
              ShowSnackBar.getSnackBar(context, 'Upload failed: $value');
            }
          },
        ).onError(
          (error, stackTrace) {
            debugPrint('Found an error: $error');
          },
        );
        // }
      } catch (e) {
        print('Error: $e');
        ShowSnackBar.getSnackBar(context, 'Error during upload: $e');
      }
    } else {
      ShowSnackBar.getSnackBar(context, 'No image selected.');
    }
  }

  Future<void> uploadCatImageToSupabase(BuildContext context, int index) async {
    final pickedFile = await pickImage();
    if (pickedFile != null) {
      final file = File(pickedFile.path);
      final fileName = petProfiles[index].catId;

      try {
        // if the image exists, then delete that before uploading another
        if (petProfiles[index].catImage != null) {
          // final List<FileObject> response;
          petProfiles[index].catImage = null;
          // Delete the image in supabase
          await Supabase.instance.client.storage
              .from('catProfile')
              .remove([fileName.toString()]).then(
            (value) {
              debugPrint('Cat picture removed!');
            },
          ).onError(
            (error, stackTrace) {
              debugPrint('Failed to remove cat picture!');
            },
          );
        }
        await Supabase.instance.client.storage
            .from('catProfile') // Use the name of your bucket
            .upload(fileName.toString(), file)
            .then(
          (value) async {
            if (value.isNotEmpty) {
              debugPrint('Value: $value');
              debugPrint('ALL right!');
              ShowSnackBar.getSnackBar(context, 'Image uploaded successfully!');
              final publicUrl = Supabase.instance.client.storage
                  .from('catProfile') // Replace with your bucket name
                  .getPublicUrl(fileName.toString());
              debugPrint('File Name: $fileName');
              petProfiles[index].catImage = publicUrl;
              await Supabase.instance.client
                  .from('catProfile')
                  .update({
                    'catImage': publicUrl,
                  })
                  .eq('catId', fileName)
                  .then(
                    (value) {
                      debugPrint('Url updated!');
                      ShowSnackBar.getSnackBar(context, 'Url updated!');
                    },
                  )
                  .onError(
                    (error, stackTrace) {
                      debugPrint('Url failed to upload!');
                      ShowSnackBar.getSnackBar(
                          context, 'Url failed to upload!');
                    },
                  );
            } else {
              debugPrint('Upload failed: $value');
              ShowSnackBar.getSnackBar(context, 'Upload failed: $value');
            }
          },
        ).onError(
          (error, stackTrace) {
            debugPrint('Found an error: $error');
          },
        );
        // }
      } catch (e) {
        print('Error: $e');
        ShowSnackBar.getSnackBar(context, 'Error during upload: $e');
      }
    } else {
      ShowSnackBar.getSnackBar(context, 'No image selected.');
    }
  }

  getImage(String fileName) {
    final publicUrl = Supabase.instance.client.storage
        .from('user_images')
        .getPublicUrl(fileName);
    print('Public URL: $publicUrl');
  }

  getCatProfiles() async {
    petProfiles = [];
    String userId = Supabase.instance.client.auth.currentUser!.id;
    final response = await Supabase.instance.client
        .from('catProfile')
        .select()
        .eq('userId', userId);

    if (response.isNotEmpty) {
      for (var element in response) {
        petProfiles.add(PetProfile.fromJson(element));
      }
    }
  }

  // Delete a cat profile
  Future<void> deletePetProfile(int index) async {
    await Supabase.instance.client
        .from('catProfile')
        .delete()
        .eq('catId', petProfiles[index].catId)
        .then(
      (value) async {
        if (petProfiles[index].catImage != null) {
          await Supabase.instance.client.storage
              .from('catProfile')
              .remove([petProfiles[index].catId.toString()]).then(
            (value) {
              petProfiles.removeAt(index);
              debugPrint('Pet deleted successfully!');
              debugPrint('Cat picture removed!');
            },
          ).onError(
            (error, stackTrace) {
              debugPrint('Error!');
            },
          );
        } else {
          petProfiles.removeAt(index);
          debugPrint('Pet deleted successfully!');
          debugPrint('Cat picture removed!');
        }
      },
    ).onError(
      (error, stackTrace) {
        debugPrint('Error: $error');
      },
    );
  }
}
