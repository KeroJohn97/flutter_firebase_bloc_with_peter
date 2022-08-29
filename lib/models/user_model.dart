import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? uid;
  bool? isVerified;
  final String? email;
  String? password;
  final String? displayName;
  final int? age;
  List<String>? chatGroupUid;
  UserModel({
    this.uid,
    this.email,
    this.password,
    this.displayName,
    this.age,
    this.isVerified,
    this.chatGroupUid,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'],
      isVerified: map['is_verified'],
      email: map['email'],
      password: map['password'],
      displayName: map['display_name'],
      age: map['age'],
      chatGroupUid: map['chat_group_uid'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'display_name': displayName,
      'age': age,
      'chat_group_uid': chatGroupUid,
    };
  }

  UserModel.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : uid = doc.id,
        email = doc.data()!["email"],
        age = doc.data()!["age"],
        displayName = doc.data()!["display_name"];

  UserModel copyWith({
    bool? isVerified,
    String? uid,
    String? email,
    String? password,
    String? displayName,
    int? age,
    List<String>? chatGroupUid,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      password: password ?? this.password,
      displayName: displayName ?? this.displayName,
      age: age ?? this.age,
      isVerified: isVerified ?? this.isVerified,
      chatGroupUid: chatGroupUid ?? this.chatGroupUid,
    );
  }
}
