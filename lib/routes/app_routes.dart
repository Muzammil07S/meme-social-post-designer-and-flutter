import 'package:flutter/material.dart';
import '../screens/editor/editor_screen.dart';
import '../screens/home/home_screen.dart';
import '../screens/splash/splash_screen.dart';
import '../screens/welcome/welcome_screen.dart';

class AppRoutes {
  static const splash = '/';
  static const welcome = '/welcome';
  static const home = '/home';
  static const editor = '/editor';

  static final Map<String, WidgetBuilder> routes = {
    splash: (_) => const SplashScreen(),
    welcome: (_) => const WelcomeScreen(),
    home: (_) => const HomeScreen(),
    editor: (_) => const EditorScreen(),
  };
}
