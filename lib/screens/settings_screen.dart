import 'package:flutter/material.dart';
import 'package:meals_app/widgets/main_darwer.dart';

class SettingsScreen extends StatefulWidget {
  static const routeName = "/settings";
  final saveFilters;
  final Map<String, bool> currentFilters;

  const SettingsScreen(this.saveFilters, this.currentFilters, {super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _glutenFree = false;
  bool _vegetarian = false;
  bool _vegan = false;
  bool _lactoseFree = false;

  @override
  void initState() {
    print(widget.currentFilters);
    _glutenFree = widget.currentFilters["gluten"]?? false;
    _lactoseFree = widget.currentFilters["lactose"]?? false;
    _vegetarian = widget.currentFilters["vegetarian"]?? false;
    _vegan = widget.currentFilters["vegan"]?? false;
    super.initState();

  }

  Widget _buildSwitchListTile(String title, String description,
      bool currentValue, Function updateValue) {
    return SwitchListTile(
      title: Text(title),
      subtitle: Text(description),
      value: currentValue,
      onChanged: updateValue()
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.pink,
          title: Text("Settings"),
          actions: [
            IconButton(
                onPressed: () {
                  final selectedFilters = {
                    "gluten": false,
                    "lactose": false,
                    "vegan": false,
                    "vegetarian": false,
                  };
                  widget.saveFilters();
                },
                icon: Icon(Icons.save))
          ],
          centerTitle: true,
        ),
        drawer: MealDrawer(),
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              child: Text(
                "Adjust your meal section",
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            Expanded(
                child: ListView(
              children: [
                _buildSwitchListTile(
                    "Gluten-free",
                    "Only include gluten-free meals",
                    _glutenFree,
                    (newValue) {
                      setState(() {
                        _glutenFree = newValue;
                      });
                    } ),
                _buildSwitchListTile(
                    "Vegetarian",
                    "Only include vegetarian meals",
                    _vegetarian,
                    (newValue) {
                      setState(() {
                        _vegetarian = newValue;
                      });
                    } ),
                _buildSwitchListTile(
                    "Vegan",
                    "Only include vegan meals",
                    _vegan,
                    (newValue) {
                      setState(() {
                        _vegan = newValue;
                      });
                    } ),
                _buildSwitchListTile(
                    "Lactose Free",
                    "Only include lactose-free meals",
                    _lactoseFree,
                    (newValue) {
                      setState(() {
                        _lactoseFree = newValue;
                      });
                    } )
              ],
            ))
          ],
        ));
  }
}
