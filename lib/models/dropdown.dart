import 'package:flutter/material.dart';
//Select Vehicle
class DropdownSelection1 extends StatefulWidget {
  final Function(String) onChanged;

  const DropdownSelection1({required this.onChanged});

  @override
  _DropdownSelection1State createState() => _DropdownSelection1State();
}

class _DropdownSelection1State extends State<DropdownSelection1> {
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
                setState(() {
                  selectedValue = newValue!;
                  widget.onChanged(selectedValue); // Pass selected value to parent widget
                });
              },

              icon: Icon(
                Icons.arrow_drop_down,
                size: 1,
              ), // Remove the default dropdown icon
              items: <String>[
                '',
                'Toyota',
                'Honda',
                'B M W',
                'HYUNDAI'
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
//Select Model
class DropdownSelection2 extends StatefulWidget {
  final Function(String) onChanged;

  const DropdownSelection2({required this.onChanged});

  @override
  _DropdownSelection2State createState() => _DropdownSelection2State();
}

class _DropdownSelection2State extends State<DropdownSelection2> {
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
                setState(() {
                  selectedValue = newValue!;
                  widget.onChanged(selectedValue); // Pass selected value to parent widget
                });
              },

              icon: Icon(
                Icons.arrow_drop_down,
                size: 1,
              ), // Remove the default dropdown icon
              items: <String>[
                '',
                'Vitz',
                'Prius',
                'Corolla',
                'Aqua',
                'Civic',
                'Accord',
                'CR-V',
                'HR-V'
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
//Select Year
class DropdownSelection3 extends StatefulWidget {
  final Function(String) onChanged;

  const DropdownSelection3({required this.onChanged});

  @override
  _DropdownSelection3State createState() => _DropdownSelection3State();
}

class _DropdownSelection3State extends State<DropdownSelection3> {
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
                setState(() {
                  selectedValue = newValue!;
                  widget.onChanged(selectedValue); // Pass selected value to parent widget
                });
              },

              icon: Icon(
                Icons.arrow_drop_down,
                size: 1,
              ), // Remove the default dropdown icon
              items: <String>[
                '',
                '2009',
                '2010',
                '2011',
                '2012',
                '2013',
                '2014',
                '2015',
                '2016',
                '2017',
                '2018',
                '2019',
                '2020',
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
//Insurance Type
class DropdownSelection4 extends StatefulWidget {
  final Function(String) onChanged;

  const DropdownSelection4({required this.onChanged});

  @override
  _DropdownSelection4State createState() => _DropdownSelection4State();
}

class _DropdownSelection4State extends State<DropdownSelection4> {
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
                setState(() {
                  selectedValue = newValue!;
                  widget.onChanged(selectedValue); // Pass selected value to parent widget
                });
              },

              icon: Icon(
                Icons.arrow_drop_down,
                size: 1,
              ), // Remove the default dropdown icon
              items: <String>[
                '',
                'Full',
                'Third Party',
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
//type of Incident occured
class DropdownSelection5 extends StatefulWidget {
  final Function(String) onChanged;

  const DropdownSelection5({required this.onChanged});

  @override
  _DropdownSelection5State createState() => _DropdownSelection5State();
}

class _DropdownSelection5State extends State<DropdownSelection5> {
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
                setState(() {
                  selectedValue = newValue!;
                  widget.onChanged(selectedValue); // Pass selected value to parent widget
                });
              },

              icon: Icon(
                Icons.arrow_drop_down,
                size: 1,
              ), // Remove the default dropdown icon
              items: <String>[
                '',
                'Collision',
                'Rollover',
                'Fire',
                'Theft',
                'Vandalism',
                'Natural disaster',
                'Flat tire',
                'Fuel problems',
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
//Accident type
class DropdownSelection6 extends StatefulWidget {
  final Function(String) onChanged;

  const DropdownSelection6({required this.onChanged});

  @override
  _DropdownSelection6State createState() => _DropdownSelection6State();
}

class _DropdownSelection6State extends State<DropdownSelection6> {
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
                setState(() {
                  selectedValue = newValue!;
                  widget.onChanged(selectedValue); // Pass selected value to parent widget
                });
              },

              icon: Icon(
                Icons.arrow_drop_down,
                size: 1,
              ), // Remove the default dropdown icon
              items: <String>[
                '',
                'Rear-end collision',
                'Head-on collision',
                'T-bone collision',
                'Rollover',
                'Angle accident',
                'Low-speed accident',
                'High-speed accident',
                'Sideswipe accident',
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