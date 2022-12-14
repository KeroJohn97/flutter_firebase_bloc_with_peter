import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_bloc_with_peter/helpers/color_helper.dart';
import 'package:flutter_firebase_bloc_with_peter/helpers/text_helper.dart';
import 'package:flutter_firebase_bloc_with_peter/pages/home_page.dart';
import 'package:flutter_firebase_bloc_with_peter/pages/signup_page.dart';
import 'package:get/get.dart';

import '../blocs/authentication/authentication_bloc.dart';
import '../blocs/form/form_bloc.dart';
import '../widgets/error_dialog.dart';

OutlineInputBorder border = const OutlineInputBorder(
  borderSide: BorderSide(color: ColorHelper.kBorderColor, width: 3.0),
);

class LoginPage extends StatelessWidget {
  static const route = '/login';
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MultiBlocListener(
      listeners: [
        BlocListener<FormBloc, FormsValidate>(
          listener: (context, state) {
            if (state.errorMessage.isNotEmpty) {
              showDialog(
                  context: context,
                  builder: (context) =>
                      ErrorDialog(errorMessage: state.errorMessage));
            } else if (state.isFormValid && !state.isLoading) {
              context.read<AuthenticationBloc>().add(AuthenticationStarted());
            } else if (state.isFormValidateFailed) {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(TextHelper.fixIssues.tr)));
            }
          },
        ),
        BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            if (state is AuthenticationSuccess) {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  HomePage.route, (Route<dynamic> route) => route.isFirst);
            }
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          systemOverlayStyle:
              const SystemUiOverlayStyle(statusBarColor: Colors.white),
        ),
        backgroundColor: ColorHelper.kPrimaryColor,
        body: Center(
          child: SingleChildScrollView(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Image.asset("assets/images/sign_in.png"),
              RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(children: <TextSpan>[
                    TextSpan(
                        text: TextHelper.textSignInTitle.tr,
                        style: const TextStyle(
                          color: ColorHelper.kBlackColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 30.0,
                        )),
                  ])),
              SizedBox(height: size.height * 0.01),
              const Text(
                TextHelper.textSmallSignIn,
                style: TextStyle(color: ColorHelper.kDarkGreyColor),
              ),
              Padding(padding: EdgeInsets.only(bottom: size.height * 0.02)),
              const _EmailField(),
              SizedBox(height: size.height * 0.01),
              const _PasswordField(),
              SizedBox(height: size.height * 0.01),
              const _SubmitButton(),
              const _SignInNavigate(),
            ]),
          ),
        ),
      ),
    );
  }
}

class _EmailField extends StatelessWidget {
  const _EmailField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<FormBloc, FormsValidate>(
      builder: (context, state) {
        return SizedBox(
          width: size.width * 0.8,
          child: TextFormField(
              onChanged: (value) {
                context.read<FormBloc>().add(EmailChanged(value));
              },
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Email',
                helperText: 'A complete, valid email e.g. joe@gmail.com',
                errorText: !state.isEmailValid
                    ? 'Please ensure the email entered is valid'
                    : null,
                hintText: 'Email',
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 15.0, horizontal: 10.0),
                border: border,
              )),
        );
      },
    );
  }
}

class _PasswordField extends StatelessWidget {
  const _PasswordField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<FormBloc, FormsValidate>(
      builder: (context, state) {
        return SizedBox(
          width: size.width * 0.8,
          child: TextFormField(
            obscureText: true,
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
              border: border,
              helperText:
                  '''Password should be at least 8 characters with at least one letter and number''',
              helperMaxLines: 2,
              labelText: 'Password',
              errorMaxLines: 2,
              errorText: !state.isPasswordValid
                  ? '''Password must be at least 8 characters and contain at least one letter and number'''
                  : null,
            ),
            onChanged: (value) {
              context.read<FormBloc>().add(PasswordChanged(value));
            },
          ),
        );
      },
    );
  }
}

class _SubmitButton extends StatelessWidget {
  const _SubmitButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<FormBloc, FormsValidate>(
      builder: (context, state) {
        return state.isLoading
            ? const Center(child: CircularProgressIndicator())
            : SizedBox(
                width: size.width * 0.8,
                child: OutlinedButton(
                  onPressed: !state.isFormValid
                      ? () => context
                          .read<FormBloc>()
                          .add(const FormSubmitted(value: Status.signIn))
                      : null,
                  style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all<Color>(
                          ColorHelper.kPrimaryColor),
                      backgroundColor: MaterialStateProperty.all<Color>(
                          ColorHelper.kBlackColor),
                      side: MaterialStateProperty.all<BorderSide>(
                          BorderSide.none)),
                  child: Text(TextHelper.textSignIn.tr),
                ),
              );
      },
    );
  }
}

class _SignInNavigate extends StatelessWidget {
  const _SignInNavigate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
        textAlign: TextAlign.center,
        text: TextSpan(children: <TextSpan>[
          TextSpan(
              text: TextHelper.textAcc.tr,
              style: const TextStyle(
                color: ColorHelper.kDarkGreyColor,
              )),
          TextSpan(
              recognizer: TapGestureRecognizer()
                ..onTap = () => {
                      Navigator.of(context).pop(),
                      Navigator.pushNamed(context, SignupPage.route),
                    },
              text: TextHelper.textSignUp.tr,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: ColorHelper.kDarkBlueColor,
              )),
        ]));
  }
}
