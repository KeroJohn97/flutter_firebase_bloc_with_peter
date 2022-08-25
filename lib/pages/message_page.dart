import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_bloc_with_peter/blocs/authentication/authentication_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class MessagePage extends StatelessWidget {
  static const route = '/message';
  const MessagePage({Key? key, required this.firestore}) : super(key: key);

  final FirebaseFirestore firestore;

  CollectionReference get messages => firestore.collection('Messages');

  Future<void> _addMessage(BuildContext context) async {
    final authenticationState = context.read<AuthenticationBloc>().state;
    if (authenticationState is AuthenticationSuccess) {
      await messages.add(<String, dynamic>{
        'message': 'Hello world!',
        'createdAt': FieldValue.serverTimestamp(),
        'createdBy': authenticationState.displayName,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Firestore Message Chat'),
      ),
      body: MessageList(firestore: firestore),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addMessage(context),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class MessageList extends StatelessWidget {
  const MessageList({Key? key, required this.firestore}) : super(key: key);

  final FirebaseFirestore firestore;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: firestore.collection('Messages').orderBy('createdAt').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) return const Text('Loading...');
        final int messageCount = snapshot.data!.docs.length;
        return ListView.builder(
          itemCount: messageCount,
          itemBuilder: (_, int index) {
            final DocumentSnapshot? document = snapshot.data?.docs[index];
            final dynamic message = document?['message'] ?? '';
            final DateTime? createdAt = (document?['createdAt'] as Timestamp?)
                ?.toDate()
                .subtract(
                    Duration(hours: DateTime.now().timeZoneOffset.inHours));
            final String createdBy = document?['createdBy'] ?? 'anonymous';
            return ListTile(
              title: Text(
                message != null ? message.toString() : '<No message retrieved>',
              ),
              subtitle: Text('Message ${index + 1} of $messageCount'),
              trailing: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (createdAt != null)
                    Text(
                      DateFormat('yyyy-MM-dd HH:mm aa').format(createdAt),
                      style: TextStyle(
                        fontSize: 12.sp,
                      ),
                    ),
                  Text(
                    'by $createdBy',
                    style: TextStyle(
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
