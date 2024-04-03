// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'To-Do'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
  String toAdd = '';
  int _selectedIndex = 0;
  List<String> _input = [''];
  bool showTextField = false;
  String textFieldValue = '';
  GlobalKey<FormState> _key = GlobalKey<FormState>();

  static const List<Widget> _listoptions = <Widget>[Text('Trash')];

  void _itemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _addToList(String value) {
    setState(() {
      showTextField = true;
      _input.add(value);
    });
  }

  void _openTask(int key) {
    setState((){
      _input.removeAt(key);
    });
  }


  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      title: Text(widget.title),
    ),
    body: Container(
      margin: EdgeInsets.all(50),
      child: Form(key: _key, child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(hintText: 'Input Task'),
            onFieldSubmitted: _addToList,
          ),
          SizedBox(height: 20.0),
          Column(
            children: List.generate(
              _input.length, (index) {
                final buttontext = _input[index];
                return Column(
                  children: [
                    ElevatedButton(
                      key: Key('$index'),
                      onPressed: () {
                        _openTask(index);
                      },
                      child: Text(
                        buttontext, 
                        style: TextStyle(fontSize: 16), // Button text style
                      ),
                    ),
                    SizedBox(height: 20.0),
                  ],
                );
              }
            )
          ),
        ],
      ),
      ),
    ),
    floatingActionButton: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        FloatingActionButton.extended(
          label: Text('Clear'),
          onPressed: () {
            setState(() {
              _input.clear();
              _key.currentState?.reset();
            });
          },
          icon: Icon(Icons.clear),
        ),
        SizedBox(width: 20.0),
        FloatingActionButton.extended(
          label: Text('Add'),
          onPressed: () {
            _addToList(_input[0]);
          },
          icon: Icon(Icons.add),
        ),
      ],
    ),
    drawer: Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration:
                BoxDecoration(color: Color.fromARGB(255, 255, 255, 255)),
            child: Text('Menu'),
          ),
          ListTile(
            title: Text('Trash'),
            selected: _selectedIndex == 1,
            onTap: () {
              _itemTapped(0);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    ),
  );
}
}
