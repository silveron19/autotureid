import 'package:autotureid/app/domain/entities/user_data.dart';

class UserDataModel {
  final String id;
  final String username;
  final String email;
  final String? phoneNumber;
  final String? profilePicture;

  UserDataModel({
    required this.id,
    required this.username,
    required this.email,
    this.phoneNumber,
    this.profilePicture,
  });

  factory UserDataModel.fromJson(Map<String, dynamic> json) {
    return UserDataModel(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      phoneNumber: json['phone_number'],
      profilePicture: json['profile_picture'],
    );
  }

  factory UserDataModel.fromEntity(UserData userData) {
    return UserDataModel(
      id: userData.id,
      username: userData.username,
      email: userData.email,
      phoneNumber: userData.phoneNumber,
      profilePicture: userData.profilePicture,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'phone_number': phoneNumber,
      'profile_picture': profilePicture,
    };
  }

  UserData toEntity() {
    return UserData(
      id: id,
      username: username,
      email: email,
      phoneNumber: phoneNumber,
      profilePicture: profilePicture,
    );
  }

  UserDataModel copyWith({
    String? id,
    String? username,
    String? email,
    String? phoneNumber,
    String? profilePicture,
  }) {
    return UserDataModel(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      profilePicture: profilePicture ?? this.profilePicture,
    );
  }
}
