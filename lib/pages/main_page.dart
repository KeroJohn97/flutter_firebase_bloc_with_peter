import 'package:flutter/material.dart';
import 'package:flutter_firebase_bloc_with_peter/pages/login_page.dart';
import 'package:flutter_firebase_bloc_with_peter/widgets/custom_app_bar.dart';

class MainPage extends StatelessWidget {
  static const route = '/';
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, LoginPage.route),
        child: const Icon(Icons.person),
      ),
      appBar: const CustomAppBar(title: 'Main Page'),
    );
  }
}
