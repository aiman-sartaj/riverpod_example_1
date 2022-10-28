import 'package:chat_app/views/chat/chat.dart';
import 'package:chat_app/views/home/home.dart';
import 'package:flutter/material.dart';

import '../views/auth/auth.dart';
import '../views/sign_in/sign_in.dart';
import '../views/sign_up/sign_up.dart';

class AppRoutes {
  AppRoutes._();

  static const String home = '/home';
  static const String signIn = '/sign-in';
  static const String signUp = '/sign-up';
  static const String chat = '/chat';
  static const String auth = '/auth';

  static final routes = <String, WidgetBuilder>{
    home: (context) => HomeView(),
    signIn: (context) => SignIn(),
    signUp: (context) => SignUp(),
    chat: (context) => Chat(),
    auth: (context) => AuthenticationView(),
  };
}
