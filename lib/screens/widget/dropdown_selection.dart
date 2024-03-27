import 'package:flutter/material.dart';

class DropdownSelection extends StatefulWidget {
  @override
  _DropdownSelectionState createState() => _DropdownSelectionState();
}

class _DropdownSelectionState extends State<DropdownSelection> {
  String selectedValue = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      height: 42,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        children: [
          Expanded(
            child: DropdownButton<String>(
              value: selectedValue,
              onChanged: (String? newValue) {
                setState(
                  () {
                    selectedValue = newValue!;
                  },
                );
              },
              icon: Icon(
                Icons.arrow_drop_down,
                size: 1,
              ), // Remove the default dropdown icon
              items: <String>[
                '',
                'Option 1',
                'Option 2',
                'Option 3',
                'Option 4'
              ].map<DropdownMenuItem<String>>(
                (String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                },
              ).toList(),
            ),
          ),
          Icon(
            Icons.arrow_drop_down,
          ), // Icon aligned to the right corner
        ],
      ),
    );
  }
}
