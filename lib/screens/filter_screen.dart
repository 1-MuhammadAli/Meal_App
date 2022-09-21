import 'package:flutter/material.dart';

import '../widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = '/filters';
  final Function saveFilters;
  final Map<String, bool> currentFilters;
  FiltersScreen(this.saveFilters, this.currentFilters);

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _glutenFree = false;
  bool _vegetarian = false;
  bool _vegan = false;
  bool _lactoseFree = false;

  @override
  void initState() {
    // TODO: implement initState
    _glutenFree = widget.currentFilters['gluten']!;
    _vegetarian = widget.currentFilters['vegetarian']!;
    _vegan = widget.currentFilters['vegan']!;
    _lactoseFree = widget.currentFilters['lactose']!;
    super.initState();
  }
  Widget _buildSwitchListTile(
      String title,
      String description,
      bool currentValue,
      Function(bool newValue) updateValue,
      ){
    return  SwitchListTile(
      title: Text(title),
      subtitle: Text(description),
      value: currentValue,
      onChanged: updateValue,
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Filters'),
        actions: [
          IconButton(
            onPressed: (){
              final selectedFilters = {
                'gluten':_glutenFree,
                'lactose':_lactoseFree,
                'vegan':_vegan,
                'vegetarian':_vegetarian,
              };
              widget.saveFilters(selectedFilters);
            },
            icon: Icon(Icons.save),
          ),
        ],
      ),
      drawer: MainDrawer(),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20.0),
            child: Text('Adjust your meal selection.',
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                _buildSwitchListTile(
                    'Gluten-Free',
                    'Only Add gluten-free meals.',
                    _glutenFree,
                        (newValue) {
                      setState(() {
                        _glutenFree=newValue;
                      });
                    }),
                _buildSwitchListTile(
                    'Lactose-Free',
                    'Only Add lactose-free meals.',
                    _lactoseFree,
                        (newValue) {
                      setState(() {
                        _lactoseFree=newValue;
                      });
                    }),
                _buildSwitchListTile(
                    'Vegetarian',
                    'Only Add vegetarian meals.',
                    _vegetarian,
                        (newValue) {
                      setState(() {
                        _vegetarian=newValue;
                      });
                    }),
                _buildSwitchListTile(
                    'Vegan',
                    'Only Add vegan meals.',
                    _vegan,
                        (newValue) {
                      setState(() {
                        _vegan=newValue;
                      });
                    }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}