import 'package:flutter/material.dart';
import 'package:meals_app/screens/categories_screens.dart';
import 'package:meals_app/screens/favourites_screen.dart';
import 'package:meals_app/widgets/main_darwer.dart';

import '../models/meal.dart';

class TabsScreen extends StatefulWidget {
  final List<Meal> favouriteMeals;
  const TabsScreen(this.favouriteMeals, {super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  List<Map<String, Object>> _pages = [];

  int _selectedPageIndex = 0;
  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  void initState() {
    _pages = [
      {"page": CategoriesScreen(), "title": "Categories"},
      {
        "page": FavouriteScreen(widget.favouriteMeals),
        "title": "Your Favourite"
      }
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(_pages[_selectedPageIndex]["title"] as String),
      ),
      drawer: MealDrawer(),
      body: _pages[_selectedPageIndex]["page"] as Widget,
      bottomNavigationBar: BottomNavigationBar(
          unselectedItemColor: Colors.white,
          selectedItemColor: Theme.of(context).canvasColor,
          currentIndex: _selectedPageIndex,
          type: BottomNavigationBarType.shifting,
          onTap: _selectPage,
          items: [
            BottomNavigationBarItem(
              backgroundColor: Colors.pink,
              icon: Icon(
                Icons.category,
              ),
              label: "Categories",
            ),
            BottomNavigationBarItem(
              backgroundColor: Colors.pink,
              icon: Icon(
                Icons.star,
              ),
              label: "Favourites",
            ),
          ]),
    );
  }
}
