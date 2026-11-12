import 'package:flutter/material.dart';
import '../screens/designs/my_designs_screen.dart';
import '../screens/designs/design_detail_screen.dart';
import '../screens/favorites/favorites_screen.dart';
import '../screens/search/search_screen.dart';
import '../screens/about/about_screen.dart';

// PERSON 3: App Routes for Zeeshan Branch
class AppRoutes {
  static const myDesigns = '/';
  static const designDetail = '/design-detail';
  static const favorites = '/favorites';
  static const search = '/search';
  static const about = '/about';

  static final Map<String, WidgetBuilder> routes = {
    myDesigns: (_) => const MyDesignsScreen(),
    designDetail: (_) => const DesignDetailScreen(),
    favorites: (_) => const FavoritesScreen(),
    search: (_) => const SearchScreen(),
    about: (_) => const AboutScreen(),
  };
}
