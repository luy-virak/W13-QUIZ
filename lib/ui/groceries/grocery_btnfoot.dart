import 'package:flutter/material.dart';
import 'grocery_list.dart';
import 'package:quiz_13/ui/tabs/search.dart';

class Groceries extends StatefulWidget {
  const Groceries({super.key});


  @override
  State<Groceries> createState() => _GroceriesState();
}
enum Tabs{ groceries, search }

class _GroceriesState extends State<Groceries> {
  Tabs groceries = Tabs.groceries;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: groceries.index,
        children: const [
          GroceryList(),
          Search(),
        ],
      ),
       bottomNavigationBar: BottomNavigationBar(
        currentIndex: groceries.index,
        selectedItemColor: Colors.red,
        onTap: (index) {
          setState(() {
            groceries = Tabs.values[index];
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dynamic_feed),
            label: 'Groceries',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people), 
            label: 'Search',),
        ],
      ),
    );
  }
}