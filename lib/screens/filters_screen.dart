import 'package:flutter/material.dart';
import '../widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const rountName = '/filters';

  final Map<String, bool> currentFilters;
  final Function saveFilters;

  FiltersScreen(this.currentFilters, this.saveFilters);

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  var _gultenFree = false;
  var _vegetrian = false;
  var _vegan = false;
  var _lactoseFree = false;

  @override
  void initState() {
    _gultenFree = widget.currentFilters['gulten'];
    _lactoseFree = widget.currentFilters['lactose'];
    _vegetrian = widget.currentFilters['vegatrian'];
    _vegan = widget.currentFilters['vegan'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Filters'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              final selectedFiltersData = {
                'gulten': _gultenFree,
                'lactose': _lactoseFree,
                'vegatrian': _vegetrian,
                'vegan': _vegan,
              };
              widget.saveFilters(selectedFiltersData);
            },
          )
        ],
      ),
      drawer: MainDrawer(),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              'Adjust your meals selections',
              style: Theme.of(context).textTheme.title,
            ),
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                _buildSwitchTile(
                  'Gulten Free',
                  'Only Include gulten free meals',
                  _gultenFree,
                  (value) {
                    setState(() {
                      _gultenFree = value;
                    });
                  },
                ),
                _buildSwitchTile(
                  'Lactose Free',
                  'Only Include lactose free meals',
                  _lactoseFree,
                  (value) {
                    setState(() {
                      _lactoseFree = value;
                    });
                  },
                ),
                _buildSwitchTile(
                  'Vegetrian',
                  'Only Include vegetrian free meals',
                  _vegetrian,
                  (value) {
                    setState(() {
                      _vegetrian = value;
                    });
                  },
                ),
                _buildSwitchTile(
                  'Vegan',
                  'Only Include vegan free meals',
                  _vegan,
                  (value) {
                    setState(() {
                      _vegan = value;
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSwitchTile(String title, String description, bool currentValue,
      Function onValueChanged) {
    return SwitchListTile(
      title: Text(title),
      subtitle: Text(description),
      value: currentValue,
      onChanged: onValueChanged,
    );
  }
}
