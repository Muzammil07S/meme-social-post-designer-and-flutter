import 'package:flutter/material.dart';
import '../screens/gallery/gallery_screen.dart';
import '../screens/categories/categories_screen.dart';
import '../screens/stickers/sticker_picker_screen.dart';
import '../screens/designs/my_designs_screen.dart';
import '../screens/designs/design_detail_screen.dart';
import '../screens/search/search_screen.dart';

class AppRoutes {
  static const categories = '/';
  static const gallery = '/gallery';
  static const stickers = '/stickers';
  static const myDesigns = '/my-designs';
  static const designDetail = '/design-detail';
  static const search = '/search';

  static final Map<String, WidgetBuilder> routes = {
    categories: (_) => const CategoriesScreen(),
    gallery: (_) => const GalleryScreen(),
    stickers: (_) => const StickerPickerScreen(),
    myDesigns: (_) => const MyDesignsScreen(),
    designDetail: (_) => const DesignDetailScreen(),
    search: (_) => const SearchScreen(),
  };
}
