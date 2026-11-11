// PERSON 3: Search Saved Designs (100% Frontend)
import 'package:flutter/material.dart';
import '../../models/design.dart';
import '../../routes/app_routes.dart';
import '../designs/my_designs_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Design> _results = [];
  bool _isLoading = false;

  void _search(String query) {
    setState(() {
      _isLoading = true;
    });
    final q = query.toLowerCase();
    final res = MyDesignsScreen.designs.where((d) =>
      d.title.toLowerCase().contains(q) || d.text.toLowerCase().contains(q) || (d.bottomText?.toLowerCase().contains(q) ?? false)
    ).toList();
    setState(() {
      _results = res;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _search('');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Search Designs')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                  hintText: 'Search saved designs'),
              onChanged: _search,
            ),
          ),
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _results.isEmpty
                    ? const Center(child: Text('No matching designs found'))
                    : ListView.builder(
                        itemCount: _results.length,
                        itemBuilder: (context, i) => ListTile(
                          leading: const Icon(Icons.design_services, color: Colors.deepPurple),
                          title: Text(_results[i].title),
                          subtitle: Text(_results[i].text),
                          onTap: () async {
                            await Navigator.pushNamed(
                                context, AppRoutes.designDetail,
                                arguments: _results[i]);
                            _search('');
                          },
                        ),
                      ),
          ),
        ],
      ),
    );
  }
}
