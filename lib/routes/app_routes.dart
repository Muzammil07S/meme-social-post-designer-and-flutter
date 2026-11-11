import 'package:flutter/material.dart';
import '../screens/about/about_screen.dart';
import '../screens/favorites/favorites_screen.dart';
import '../screens/preview/preview_screen.dart';
import '../screens/profile/profile_screen.dart';
import '../screens/settings/settings_screen.dart';

class AppRoutes {
  static const profile = '/';
  static const about = '/about';
  static const favorites = '/favorites';
  static const preview = '/preview';
  static const settings = '/settings';
  static const home = '/';
  static const designDetail = '/preview';

  static final Map<String, WidgetBuilder> routes = {
    profile: (_) => const ProfileScreen(),
    about: (_) => const AboutScreen(),
    favorites: (_) => const FavoritesScreen(),
    preview: (_) => const PreviewScreen(),
    settings: (_) => const SettingsScreen(),
  };
}
