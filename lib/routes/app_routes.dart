import 'package:example_one/views/chat/chat.dart';
import 'package:flutter/material.dart';

import '../views/cart/cart.dart';
import '../views/signin/signin.dart';
import '../views/home/home.dart';

class AppRoutes {
  AppRoutes._();

  static const String home = '/home';
  static const String signIn = '/sign-in';
  static const String signUp = '/sign-up';
  static const String cart = '/cart';
  static const String chat = '/chat';

  static final routes = <String, WidgetBuilder>{
    home: (context) => const HomeView(),
    signIn: (context) => const SignInView(),
    cart: (context) => const CartView(),
    chat: (context) => ChatView(),
  };
}
