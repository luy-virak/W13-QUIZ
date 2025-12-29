import 'package:flutter/material.dart';
import '../../data/mock_grocery_repository.dart';
import '../../models/grocery.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final TextEditingController _searchController = TextEditingController();
  List<Grocery> _filteredGroceries = [];

  @override
  void initState() {
    super.initState();
    _filteredGroceries = dummyGroceryItems;
  }

  void _filterGroceries(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredGroceries = dummyGroceryItems;
      } else {
        _filteredGroceries = dummyGroceryItems
            .where((grocery) =>
                grocery.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Groceries'),
      ),
      body: Padding( 
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              onChanged: _filterGroceries,
              decoration: InputDecoration(
                labelText: 'Search for groceries',
                prefixIcon: const Icon(Icons.search),
                border: const OutlineInputBorder(),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          _filterGroceries('');
                        },
                      )
                    : null,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: _filteredGroceries.isEmpty
                  ? const Center(
                      child: Text('No groceries found'),
                    )
                  : ListView.builder(
                      itemCount: _filteredGroceries.length,
                      itemBuilder: (context, index) {
                        final grocery = _filteredGroceries[index];
                        return ListTile(
                          leading: Container(
                            width: 15,
                            height: 15,
                            color: grocery.category.color,
                          ),
                          title: Text(grocery.name),
                          subtitle: Text(grocery.category.label),
                          trailing: Text(grocery.quantity.toString()),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
} 