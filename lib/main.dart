import 'package:flutter/material.dart';
import 'package:meals_app/models/dummy_data.dart';
import 'package:meals_app/screens/categories_meals_screen.dart';
import 'package:meals_app/screens/categories_screens.dart';
import 'package:meals_app/screens/meal_screen_detail.dart';
import 'package:meals_app/screens/settings_screen.dart';
import 'package:meals_app/screens/tab_screen.dart';

import 'models/meal.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _settings = {
    "glutten": false,
    "lactose": false,
    "vegan": false,
    "vegetarian": false,
  };

  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favouriteMeals = [];

  void _setSettings(Map<String, bool> settingsData) {
    setState(() {
      _settings = settingsData;

      _availableMeals = DUMMY_MEALS.where((meal) {
        if (_settings["gluten"]! && !meal.isGlutenFree) {
          return false;
        }
        if (_settings["lactose"]! && !meal.isLactoseFree) {
          return false;
        }
        if (_settings["vegan"]! && !meal.isVegan) {
          return false;
        }
        if (_settings["vegetarian"]! && !meal.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  void _toggleFavourite(String mealId) {
    final existingIndex =
        _favouriteMeals.indexWhere((meal) => meal.id == mealId);
    if (existingIndex >= 0) {
      setState(() {
        _favouriteMeals.removeAt(existingIndex);
      });
    } else {
      setState(() {
        _favouriteMeals.add(
          DUMMY_MEALS.firstWhere((meal) => meal.id == mealId),
        );
      });
    }
  }

  bool _isMealFavourite(String id) {
    return _favouriteMeals.any((meal) => meal.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primaryColor: Colors.pink,
          primarySwatch: Colors.pink,
          canvasColor: const Color.fromARGB(255, 254, 229, 1),
          fontFamily: "Raleway",
          useMaterial3: true,
          textTheme: ThemeData.light().textTheme.copyWith(
              bodyLarge: const TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              bodyMedium: const TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
              titleLarge: const TextStyle(
                  fontSize: 20,
                  fontFamily: "RobotoCondensed",
                  fontWeight: FontWeight.bold))),
      //home: const TabsScreen(),
      routes: {
        "/": (ctx) => TabsScreen(_favouriteMeals),
        "/categories-meals": (ctx) => CategoriesMeal(_availableMeals),
        // ignore: prefer_const_constructors
        MealDetailScreen.routeName: (ctx) => MealDetailScreen(_toggleFavourite, _isMealFavourite),
        SettingsScreen.routeName: (ctx) =>
            SettingsScreen(_setSettings, _settings),
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (ctx) => CategoriesScreen());
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
