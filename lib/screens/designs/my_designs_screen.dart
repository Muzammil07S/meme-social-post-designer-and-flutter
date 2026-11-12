// PERSON 3: My Designs (100% Frontend In-Memory CRUD)
import 'package:flutter/material.dart';
import '../../models/design.dart';
import '../../routes/app_routes.dart';

class MyDesignsScreen extends StatefulWidget {
  const MyDesignsScreen({super.key});

  static final List<Design> designs = [
    const Design(
      id: 1,
      title: 'Classic Meme',
      text: 'When code compiles on the first try',
      bottomText: 'Impossible!',
      backgroundColorValue: 0xFF673AB7,
      textColorValue: 0xFFFFFFFF,
    ),
    const Design(
      id: 2,
      title: 'Coding Quote',
      text: 'Talk is cheap. Show me the code.',
      backgroundColorValue: 0xFF1E1E1E,
      textColorValue: 0xFF00FF00,
    ),
  ];

  @override
  State<MyDesignsScreen> createState() => _MyDesignsScreenState();
}

class _MyDesignsScreenState extends State<MyDesignsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Person 3: Saved Designs'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            tooltip: 'Search Designs',
            onPressed: () => Navigator.pushNamed(context, AppRoutes.search),
          ),
          IconButton(
            icon: const Icon(Icons.favorite),
            tooltip: 'Favorites',
            onPressed: () => Navigator.pushNamed(context, AppRoutes.favorites),
          ),
          IconButton(
            icon: const Icon(Icons.info_outline),
            tooltip: 'About',
            onPressed: () => Navigator.pushNamed(context, AppRoutes.about),
          ),
        ],
      ),
      body: MyDesignsScreen.designs.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.folder_open, size: 64, color: Colors.grey),
                  SizedBox(height: 12),
                  Text('No saved designs yet', style: TextStyle(fontSize: 18, color: Colors.grey)),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: MyDesignsScreen.designs.length,
              itemBuilder: (context, i) {
                final d = MyDesignsScreen.designs[i];
                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () async {
                          await Navigator.pushNamed(context, AppRoutes.designDetail,
                              arguments: d);
                          setState(() {});
                        },
                        child: SizedBox(
                          height: 130,
                          child: Stack(
                            children: [
                              Positioned.fill(
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                                  child: _buildMiniPreview(d),
                                ),
                              ),
                              Positioned(
                                top: 8,
                                left: 8,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: Colors.black54,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    d.title,
                                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 11),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton.icon(
                              icon: const Icon(Icons.visibility, size: 18),
                              label: const Text('View Detail'),
                              onPressed: () async {
                                await Navigator.pushNamed(context, AppRoutes.designDetail, arguments: d);
                                setState(() {});
                              },
                            ),
                            const SizedBox(width: 8),
                            TextButton.icon(
                              icon: const Icon(Icons.delete, size: 18, color: Colors.red),
                              label: const Text('Delete', style: TextStyle(color: Colors.red)),
                              onPressed: () {
                                setState(() {
                                  MyDesignsScreen.designs.removeWhere((item) => item.id == d.id);
                                });
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Design deleted successfully')),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }

  Widget _buildMiniPreview(Design d) {
    final template = d.title.toLowerCase();
    final isMeme = template.contains('meme');
    final bg = Color(d.backgroundColorValue);
    final textColor = Color(d.textColorValue);

    return Container(
      decoration: BoxDecoration(
        color: bg,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      ),
      alignment: Alignment.center,
      padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            d.text,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: textColor,
              fontWeight: FontWeight.bold,
              shadows: isMeme ? const [Shadow(blurRadius: 3, color: Colors.black, offset: Offset(1, 1))] : null,
            ),
          ),
          if (isMeme && d.bottomText != null && d.bottomText!.isNotEmpty) ...[
            const SizedBox(height: 4),
            Text(
              d.bottomText!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: textColor,
                fontWeight: FontWeight.bold,
                shadows: const [Shadow(blurRadius: 3, color: Colors.black, offset: Offset(1, 1))],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
