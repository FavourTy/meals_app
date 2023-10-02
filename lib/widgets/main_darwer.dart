import 'package:flutter/material.dart';
import 'package:meals_app/screens/categories_screens.dart';
import 'package:meals_app/screens/settings_screen.dart';

class MealDrawer extends StatelessWidget {
  Widget buildListTile(String title, IconData icon, VoidCallback tapHandler) {
    return ListTile(
      leading: Icon(icon, size: 26),
      title: Text(title,
          style: TextStyle(
            fontFamily: "RobotoCondensed",
            fontSize: 24,
            fontWeight: FontWeight.bold,
          )),
      onTap: tapHandler,
    );
  }

  const MealDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
              height: 120,
               color: Theme.of(context).canvasColor,
              width: double.infinity,
              padding: EdgeInsets.all(20),
              alignment: Alignment.centerLeft,
              child: Text("Cooking up",
                  style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 30,
                     ),
                      ),
                      ),
          SizedBox(height: 20),
          buildListTile("Meals", Icons.restaurant, () {
            Navigator.of(context).pushReplacementNamed("/");
          }),
          buildListTile("Settings", Icons.settings, () {
            Navigator.of(context).pushReplacementNamed(SettingsScreen.routeName);
          })
        ],
      ),
    );
  }
}
