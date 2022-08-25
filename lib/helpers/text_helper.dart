import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class TextHelper {
  TextHelper._();
  static const noData = 'No data';
  static const fixIssues = 'Fix issues';
  static const register = 'Register';
  static const submit = 'Submit';
  static const signupPage = 'Signup Page';
  static const intro = 'Intro';
  static const introDesc1 = 'Intro Desc 1';
  static const introDesc2 = 'Intro Desc 2';
  static const smallSignup = 'Small Signup';
  static const start = 'Start';
  static const signup = 'Signup';
  static const title = "Google Sign In";
  static const textIntro = "Growing your \n business is ";
  static const textIntroDesc1 = "easier \n ";
  static const textIntroDesc2 = "then you think!";
  static const textSmallSignUp = "Sign up takes only 2 minutes!";
  static const textSignIn = "Sign In";
  static const textSignUpBtn = "Sign Up";
  static const textStart = "Get Started";
  static const textSignInTitle = "Welcome back!";
  static const textRegister = "Register Below!";
  static const textSmallSignIn = "You've been missed!";
  static const textSignInGoogle = "Sign In With Google";
  static const textAcc = "Don't have an account? ";
  static const textSignUp = "Sign Up here";
  static const textHome = "Home";
  static const textNoData = "No Data Available!";
  static const textFixIssues = "Please fill the data correctly!";
}

class LanguageDatum extends GetxController {
  LanguageDatum({
    this.id,
    this.name,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  int? id;
  String? name;
  int? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;

  factory LanguageDatum.fromJson(Map<String, dynamic> json) => LanguageDatum(
        id: json["id"] ?? 0,
        name: json["name"] ?? "",
        status: json["status"] ?? "",
        createdAt: json["created_at"] != null
            ? DateTime.parse(json["created_at"])
            : null,
        updatedAt: json["updated_at"] != null
            ? DateTime.parse(json["updated_at"])
            : null,
        deletedAt: json["deleted_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "deleted_at": deletedAt,
      };

  @override
  String toString() {
    return 'LanguageDatum(id: $id, name: $name, status: $status, createdAt: $createdAt, updateAt: $updatedAt, deletedAt: $deletedAt)';
  }
}
