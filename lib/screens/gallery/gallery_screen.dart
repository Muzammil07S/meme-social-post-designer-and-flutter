// PERSON 2: Template Gallery (GridView with Icons & Custom Colors)
import 'package:flutter/material.dart';
import '../../models/design.dart';
import '../../routes/app_routes.dart';
import '../designs/my_designs_screen.dart';

class GalleryScreen extends StatelessWidget {
  const GalleryScreen({super.key});

  static const List<Map<String, Object>> _templates = [
    {'name': 'Classic Meme', 'color': Colors.orange, 'icon': Icons.emoji_emotions},
    {'name': 'Quote Post', 'color': Colors.teal, 'icon': Icons.format_quote},
    {'name': 'Birthday', 'color': Colors.pink, 'icon': Icons.cake},
    {'name': 'Motivation', 'color': Colors.indigo, 'icon': Icons.bolt},
    {'name': 'Sale Banner', 'color': Colors.redAccent, 'icon': Icons.local_offer},
    {'name': 'Plain Post', 'color': Colors.blueGrey, 'icon': Icons.article},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Template Gallery'),
        actions: [
          IconButton(
            icon: const Icon(Icons.folder),
            onPressed: () => Navigator.pushNamed(context, AppRoutes.myDesigns),
          ),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => Navigator.pushNamed(context, AppRoutes.search),
          ),
        ],
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, crossAxisSpacing: 12, mainAxisSpacing: 12, childAspectRatio: 1.1),
        itemCount: _templates.length,
        itemBuilder: (context, i) {
          final t = _templates[i];
          final color = t['color'] as Color;
          final name = t['name'] as String;
          return InkWell(
            onTap: () {
              final newDesign = Design(
                id: DateTime.now().millisecondsSinceEpoch,
                title: name,
                text: 'Sample text for $name',
                backgroundColorValue: color.value,
                textColorValue: Colors.white.value,
              );
              MyDesignsScreen.designs.add(newDesign);
              Navigator.pushNamed(context, AppRoutes.designDetail, arguments: newDesign);
            },
            child: Card(
              color: color,
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(t['icon'] as IconData, size: 42, color: Colors.white),
                    const SizedBox(height: 12),
                    Text(
                      name,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
