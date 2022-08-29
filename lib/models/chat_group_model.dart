import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_firebase_bloc_with_peter/models/user_model.dart';

import 'chat_model.dart';

class ChatGroupModel {
  final String? uid;
  final String? name;
  final List<ChatModel>? listOfChat;
  final List<UserModel>? listOfUser;
  final String? groupIconUrl;

  ChatGroupModel({
    this.uid,
    this.name,
    this.listOfChat,
    this.listOfUser,
    this.groupIconUrl,
  });

  ChatGroupModel copyWith({
    String? uid,
    String? name,
    List<ChatModel>? listOfChat,
    List<UserModel>? listOfUser,
    String? groupIconUrl,
  }) {
    return ChatGroupModel(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      listOfChat: listOfChat ?? this.listOfChat,
      listOfUser: listOfUser ?? this.listOfUser,
      groupIconUrl: groupIconUrl ?? this.groupIconUrl,
    );
  }

  ChatGroupModel.fromDocumentSnapshot(
      DocumentSnapshot<Map<String, dynamic>> doc)
      : uid = doc.id,
        name = doc.data()!["name"],
        listOfChat = doc.data()!["chat"],
        listOfUser = doc.data()!["user"],
        groupIconUrl = doc.data()!['group_icon_url'];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'name': name,
      'listOfChat': listOfChat?.map((x) => x.toMap()).toList(),
      'listOfUser': listOfUser?.map((e) => e.toMap()).toList(),
      'group_icon_url': groupIconUrl,
    };
  }

  factory ChatGroupModel.fromMap(Map<String, dynamic> map) {
    return ChatGroupModel(
      uid: map['uid'] != null ? map['uid'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      listOfChat: map['listOfChat'] != null
          ? List<ChatModel>.from(
              (map['listOfChat'] as List<int>).map<ChatModel?>(
                (x) => ChatModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      listOfUser: map['listOfUser'] != null
          ? List<UserModel>.from(
              (map['listOfUser'] as List<int>).map<UserModel?>(
                (x) => UserModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      groupIconUrl: map['group_icon_url'] != null
          ? map['group_icon_url'] as String
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatGroupModel.fromJson(String source) =>
      ChatGroupModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'ChatGroupModel(uid: $uid, name: $name, listOfChat: $listOfChat, listOfUser: $listOfUser, groupIconUrl: $groupIconUrl)';

  @override
  bool operator ==(covariant ChatGroupModel other) {
    if (identical(this, other)) return true;

    return other.uid == uid &&
        other.name == name &&
        listEquals(other.listOfChat, listOfChat) &&
        listEquals(other.listOfUser, listOfUser) &&
        other.groupIconUrl == groupIconUrl;
  }

  @override
  int get hashCode =>
      uid.hashCode ^
      name.hashCode ^
      listOfChat.hashCode ^
      listOfUser.hashCode ^
      groupIconUrl.hashCode;
}
