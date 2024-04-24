import 'package:flutter/material.dart';

class MultiSelectDropdownDemo extends StatefulWidget {
  @override
  _MultiSelectDropdownDemoState createState() => _MultiSelectDropdownDemoState();
}

class _MultiSelectDropdownDemoState extends State<MultiSelectDropdownDemo> {
  List<String> _selectedItems = [];
  List<String> _dropdownItems = ['Option 1', 'Option 2', 'Option 3'];

  void _showMultiSelect(BuildContext context) async {
    final List<String> result = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Items'),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              itemCount: _dropdownItems.length,
              itemBuilder: (BuildContext context, int index) {
                final String item = _dropdownItems[index];
                return CheckboxListTile(
                  title: Text(item),
                  value: _selectedItems.contains(item),
                  selected: _selectedItems.contains(item),
                  onChanged: (value) {
                    setState(() {
                      if (value!) {
                        _selectedItems.add(item);
                      } else {
                        _selectedItems.remove(item);
                      }
                    });
                  },
                );
              },
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(_selectedItems.toList());
              },
              child: Text('Done'),
            ),
          ],
        );
      },
    );
    if (result != null) {
      setState(() {
        _selectedItems = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Flutter Multiple Selection Dropdown'),
      // ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Selected Items:',
            ),
            SizedBox(height: 10),
            Wrap(
              children: _selectedItems
                  .map((item) => Chip(
                label: Text(item),
                onDeleted: () {
                  setState(() {
                    _selectedItems.remove(item);
                  });
                },
              ))
                  .toList(),
            ),
            ElevatedButton(
              onPressed: () {
                _showMultiSelect(context);
              },
              child: Text('Select Items'),
            ),
          ],
        ),
      ),
    );
  }
}
