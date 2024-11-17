import 'package:cat_disease_detection/models/user_profile_model.dart';
import 'package:cat_disease_detection/utils/show_snack_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileViewModel {
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

  Future<UserProfile> getUserProfile(BuildContext context) async {
    String userId = Supabase.instance.client.auth.currentUser!.id;
    final response = await Supabase.instance.client
        .from('userProfile')
        .select()
        .eq('userId', userId)
        .single();
    if (response.isNotEmpty) {
      return UserProfile.fromJson(response);
    } else {
      ShowSnackBar.getSnackBar(context, 'Error!');
      return UserProfile(
          userId: 'userId',
          userName: 'userName',
          userEmail: 'userEmail',
          userPicture: null);
    }
  }

  Future<void> updateUser(
      BuildContext context, int userId, String userName) async {
    final response = await Supabase.instance.client.from('userProfile').update({
      'userName': userName,
    }).eq('id', userId);

    if (response.error == null) {
      ShowSnackBar.getSnackBar(context, 'Profile updated successfully!');
    } else {
      ShowSnackBar.getSnackBar(context, '${response.error!.message}');
    }
  }

  // Future<void> deleteDisease(int id) async {
  //   final response = await Supabase.instance.client
  //       .from('cat_diseases')
  //       .delete()
  //       .eq('id', id)
  //       .execute();
  //
  //   if (response.error == null) {
  //     print('Disease deleted successfully!');
  //   } else {
  //     print('Error: ${response.error!.message}');
  //   }
  // }
}
