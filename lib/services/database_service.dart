import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebase_bloc_with_peter/models/chat_group_model.dart';

import '../models/user_model.dart';

enum ClassModelEnum { user, chat, chatGroup }

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  addUserData(UserModel userData) async {
    await _db.collection("Users").doc(userData.uid).set(userData.toMap());
  }

  Future<List<UserModel>> retrieveUserData() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await _db.collection("Users").get();
    return snapshot.docs
        .map((docSnapshot) => UserModel.fromDocumentSnapshot(docSnapshot))
        .toList();
  }

  Future<String> retrieveUserName(UserModel user) async {
    DocumentSnapshot<Map<String, dynamic>> snapshot =
        await _db.collection("Users").doc(user.uid).get();
    return snapshot.data()!["display_name"];
  }

  addFirestoreData({
    required String collectionPath,
    required String uid,
    required dynamic data,
  }) async {
    _db.collection(collectionPath).doc(uid).set(data);
  }

  Future<List<dynamic>> retrieveListOfData({
    required String collectionPath,
    required ClassModelEnum classModel,
  }) async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await _db.collection(collectionPath).get();
    return snapshot.docs.map((docSnapshot) {
      switch (classModel) {
        default:
          return ChatGroupModel.fromDocumentSnapshot(docSnapshot);
      }
    }).toList();
  }
}
