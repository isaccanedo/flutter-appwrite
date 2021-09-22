import 'package:flutter/material.dart';
import 'package:flutter_appwrite_demo/features/auth/presentation/pages/login.dart';
import 'package:flutter_appwrite_demo/features/auth/presentation/pages/profile.dart';
import 'package:flutter_appwrite_demo/features/auth/presentation/pages/signup.dart';
import 'package:flutter_appwrite_demo/features/general/presentation/pages/home.dart';
import 'package:flutter_appwrite_demo/features/transactions/presentation/pages/add_transaction.dart';

class AppRoutes {
  static const String login = "login";
  static const String signup = "signup";
  static const String profile = "profile";
  static const String home = "home";
  static const String addTransaction = "add_transaction";


  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(builder: (context) {
      switch (settings.name) {
        case profile:
          return ProfilePage();
        case home:
          return HomePage();
        case signup:
          return SignupPage();
        case addTransaction:
          return AddTransaction();
        case login:
        default:
          return LoginPage();
      }
    });
  }
}
