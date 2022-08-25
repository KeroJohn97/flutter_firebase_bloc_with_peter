import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_firebase_bloc_with_peter/helpers/color_helper.dart';
import 'package:flutter_firebase_bloc_with_peter/helpers/text_helper.dart';
import 'package:flutter_firebase_bloc_with_peter/pages/login_page.dart';
import 'package:flutter_firebase_bloc_with_peter/pages/signup_page.dart';
import 'package:get/get.dart';

class WelcomePage extends StatelessWidget {
  static const route = '/welcome';
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ColorHelper.kPrimaryColor,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light
            .copyWith(statusBarColor: ColorHelper.statusBarColor),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/main_img.png"),
              RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(children: <TextSpan>[
                    TextSpan(
                        text: TextHelper.textIntro.tr,
                        style: const TextStyle(
                          color: ColorHelper.kBlackColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 30.0,
                        )),
                    TextSpan(
                        text: TextHelper.textIntroDesc1.tr,
                        style: const TextStyle(
                            color: ColorHelper.kDarkBlueColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 30.0)),
                    TextSpan(
                        text: TextHelper.textIntroDesc2.tr,
                        style: const TextStyle(
                            color: ColorHelper.kBlackColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 30.0)),
                  ])),
              SizedBox(height: size.height * 0.01),
              Text(
                TextHelper.textSmallSignUp.tr,
                style: const TextStyle(color: ColorHelper.kDarkGreyColor),
              ),
              SizedBox(height: size.height * 0.1),
              SizedBox(
                width: size.width * 0.8,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, LoginPage.route);
                  },
                  style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all<Color>(
                          ColorHelper.kPrimaryColor),
                      backgroundColor: MaterialStateProperty.all<Color>(
                          ColorHelper.kBlackColor),
                      side: MaterialStateProperty.all<BorderSide>(
                          BorderSide.none)),
                  child: Text(TextHelper.textStart.tr),
                ),
              ),
              SizedBox(
                width: size.width * 0.8,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, SignupPage.route);
                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          ColorHelper.kGreyColor),
                      side: MaterialStateProperty.all<BorderSide>(
                          BorderSide.none)),
                  child: Text(
                    TextHelper.textSignUpBtn.tr,
                    style: const TextStyle(color: ColorHelper.kBlackColor),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
