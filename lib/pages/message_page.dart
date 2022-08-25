import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class MessagePage extends StatelessWidget {
  static const route = '/message';
  const MessagePage({Key? key, required this.firestore}) : super(key: key);

  final FirebaseFirestore firestore;

  CollectionReference get messages => firestore.collection('Messages');

  Future<void> _addMessage() async {
    await messages.add(<String, dynamic>{
      'message': 'Hello world!',
      'createdAt': Timestamp.fromDate(DateTime.now()),
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Firestore Message Chat'),
      ),
      body: MessageList(firestore: firestore),
      floatingActionButton: FloatingActionButton(
        onPressed: _addMessage,
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
            final DateTime currentTime = (document!['createdAt'] as Timestamp)
                .toDate()
                .subtract(
                    Duration(hours: DateTime.now().timeZoneOffset.inHours));
            return ListTile(
              title: Text(
                message != null ? message.toString() : '<No message retrieved>',
              ),
              subtitle: Text('Message ${index + 1} of $messageCount'),
              trailing: Text(
                DateFormat('yyyy-MM-dd HH:mm aa').format(currentTime),
                style: TextStyle(
                  fontSize: 12.sp,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
