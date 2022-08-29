// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

enum DeleteStatusEnum { private, public }

class ChatModel {
  final String? uid;
  final String? userUid;
  final String? groupUid;
  final String? message;
  final Timestamp? timestamp;
  final DeleteStatusEnum? deleteStatus;

  ChatModel(
    this.uid,
    this.userUid,
    this.groupUid,
    this.message,
    this.timestamp,
    this.deleteStatus,
  );

  ChatModel copyWith({
    String? uid,
    String? userUid,
    String? groupUid,
    String? message,
    Timestamp? timestamp,
    DeleteStatusEnum? deleteStatus,
  }) {
    return ChatModel(
      uid ?? this.uid,
      userUid ?? this.userUid,
      groupUid ?? this.groupUid,
      message ?? this.message,
      timestamp ?? this.timestamp,
      deleteStatus ?? this.deleteStatus,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'userUid': userUid,
      'groupUid': groupUid,
      'message': message,
      'timestamp': timestamp,
      'deleteStatus': deleteStatus,
    };
  }

  factory ChatModel.fromMap(Map<String, dynamic> map) {
    return ChatModel(
      map['uid'] != null ? map['uid'] as String : null,
      map['userUid'] != null ? map['userUid'] as String : null,
      map['groupUid'] != null ? map['groupUid'] as String : null,
      map['message'] != null ? map['message'] as String : null,
      map['timestamp'] != null ? map['timestamp'] as Timestamp : null,
      map['deleteStatus'] != null
          ? DeleteStatusEnum.values
              .where((element) => element.name == map['deleteStatus'])
              .first
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatModel.fromJson(String source) =>
      ChatModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ChatModel(uid: $uid, userUid: $userUid, groupUid: $groupUid, message: $message, timestamp: $timestamp, deleteStatus: $deleteStatus)';
  }

  @override
  bool operator ==(covariant ChatModel other) {
    if (identical(this, other)) return true;

    return other.uid == uid &&
        other.userUid == userUid &&
        other.groupUid == groupUid &&
        other.message == message &&
        other.timestamp == timestamp &&
        other.deleteStatus == deleteStatus;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        userUid.hashCode ^
        groupUid.hashCode ^
        message.hashCode ^
        timestamp.hashCode ^
        deleteStatus.hashCode;
  }
}
