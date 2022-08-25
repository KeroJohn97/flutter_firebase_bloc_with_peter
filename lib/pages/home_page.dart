import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_bloc_with_peter/pages/message_page.dart';
import 'package:flutter_firebase_bloc_with_peter/pages/welcome_page.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';

import '../blocs/authentication/authentication_bloc.dart';
import '../blocs/database/database_bloc.dart';
import '../helpers/text_helper.dart';

class HomePage extends StatelessWidget {
  static const route = '/home';
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
      if (state is AuthenticationFailure) {
        Navigator.of(context).pushNamedAndRemoveUntil(
            WelcomePage.route, (Route<dynamic> route) => false);
      }
    }, buildWhen: ((previous, current) {
      if (current is AuthenticationFailure) {
        return false;
      }
      return true;
    }), builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: <Widget>[
            IconButton(
                icon: const Icon(
                  Icons.logout,
                  color: Colors.white,
                ),
                onPressed: () async {
                  context
                      .read<AuthenticationBloc>()
                      .add(AuthenticationSignedOut());
                })
          ],
          systemOverlayStyle:
              const SystemUiOverlayStyle(statusBarColor: Colors.blue),
          title:
              Text((state is AuthenticationSuccess) ? state.displayName! : ''),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.pushNamed(context, MessagePage.route,
              arguments: FirebaseFirestore.instance),
          child: const Icon(Icons.chat),
        ),
        body: BlocBuilder<DatabaseBloc, DatabaseState>(
          builder: (context, state) {
            final authenticationState =
                context.read<AuthenticationBloc>().state;
            String? displayName = (authenticationState is AuthenticationSuccess)
                ? authenticationState.displayName
                : null;
            if (state is DatabaseSuccess &&
                displayName !=
                    (context.read<DatabaseBloc>().state as DatabaseSuccess)
                        .displayName) {
              context.read<DatabaseBloc>().add(DatabaseFetched(displayName));
            }
            if (state is DatabaseInitial) {
              context.read<DatabaseBloc>().add(DatabaseFetched(displayName));
              return const Center(child: CircularProgressIndicator());
            } else if (state is DatabaseSuccess) {
              if (state.listOfUserData.isEmpty) {
                return Center(
                  child: Text(TextHelper.noData.tr),
                );
              } else {
                return Center(
                  child: ListView.builder(
                    itemCount: state.listOfUserData.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        child: ListTile(
                          title: Text(state.listOfUserData[index].displayName!),
                          subtitle: Text(state.listOfUserData[index].email!),
                          trailing:
                              Text(state.listOfUserData[index].age!.toString()),
                        ),
                      );
                    },
                  ),
                );
              }
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      );
    });
  }
}
