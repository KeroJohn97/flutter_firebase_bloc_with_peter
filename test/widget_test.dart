import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_bloc_with_peter/pages/message_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';

const messagesCollection = 'Messages';

void main() {
  testWidgets('shows messages', (WidgetTester tester) async {
    // Populate the fake database.
    final firestore = FakeFirebaseFirestore();
    await firestore.collection(messagesCollection).add({
      'message': 'Hello world!',
      'createdAt': FieldValue.serverTimestamp(),
    });

    // Render the widget.
    await tester.pumpWidget(
      MediaQuery(
        data: MediaQueryData.fromWindow(WidgetsBinding.instance.window),
        child: ScreenUtilInit(
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) {
            ScreenUtil.init(context);
            return MaterialApp(
              title: 'Firestore Example',
              home: MessagePage(firestore: firestore),
            );
          },
        ),
      ),
    );
    // Let the snapshots stream fire a snapshot.
    await tester.idle();
    // Re-render.
    await tester.pump();
    // // Verify the output.
    expect(find.text('Hello world!'), findsOneWidget);
    expect(find.text('Message 1 of 1'), findsOneWidget);
  });

  testWidgets('adds messages', (WidgetTester tester) async {
    // Instantiate the mock database.
    final firestore = FakeFirebaseFirestore();

    // Render the widget.
    await tester.pumpWidget(MediaQuery(
      data: MediaQueryData.fromWindow(WidgetsBinding.instance.window),
      child: ScreenUtilInit(
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) {
            return MaterialApp(
                title: 'Firestore Example',
                home: MessagePage(firestore: firestore));
          }),
    ));
    // Verify that there is no data.
    expect(find.text('Hello world!'), findsNothing);

    // Tap the Add button.
    await tester.tap(find.byType(FloatingActionButton));
    // Let the snapshots stream fire a snapshot.
    await tester.idle();
    // Re-render.
    await tester.pump();

    // Verify the output.
    expect(find.text('Hello world!'), findsOneWidget);
  });
}
