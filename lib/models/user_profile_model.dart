import 'dart:io';

class UserProfile {
  String userId;
  String userName;
  String userEmail;
  File? userPicture;

  UserProfile({
    required this.userId,
    required this.userName,
    required this.userEmail,
    this.userPicture,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      userId: json['userId'],
      userName: json['userName'],
      userPicture: json['userPicture'],
      userEmail: json['userEmail'],
    );
  }
}
