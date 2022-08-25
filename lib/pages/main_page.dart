import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_bloc_with_peter/pages/home_page.dart';
import 'package:flutter_firebase_bloc_with_peter/pages/welcome_page.dart';

import '../blocs/authentication/authentication_bloc.dart';

class MainPage extends StatelessWidget {
  static const route = '/';
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        if (state is AuthenticationSuccess) {
          return const HomePage();
        } else {
          return const WelcomePage();
        }
      },
    );
  }
}
