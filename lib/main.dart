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
  bool _isVisible = false;
  int numberofTextFields = 1;
  
  static const List<Widget> _listoptions = <Widget>[
    Text('Trash')
  ];

  void _itemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _addToList() {
    
  }

  void _openTask() {

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            TextFormField(
            decoration: InputDecoration(hintText: 'Input Task'),
            onChanged: (value) {
              toAdd = value;
            },
          ),
          SizedBox(height: 20.0,),
          OutlinedButton(onPressed: () {
            _isVisible = true;
            setState(() {
              numberofTextFields++;
            });
          },
          style: ButtonStyle(foregroundColor: MaterialStatePropertyAll<Color>(Colors.black),
          backgroundColor: MaterialStatePropertyAll<Color>(Colors.orange)),
          child: const Icon(Icons.add),
          ),
          SizedBox(height: 20.0),
          for (int i = 0; i < numberofTextFields; i++)
          OutlinedButton(onPressed: () {  }, 
          child: Text(toAdd)),
          ],
        ),
      ),
      drawer: Drawer (child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 255, 255, 255)
            ), child: Text('Menu'),
          ),
          ListTile(
            title: Text('Trash'),
            selected: _selectedIndex == 0,
            onTap: () { 
              _itemTapped(0);
              Navigator.pop(context);
            }
          ),
        ],
      ),),
      floatingActionButton: FloatingActionButton(
        onPressed: _addToList,
        tooltip: 'Add to-do',
        child: const Icon(Icons.add),
      ), 
    );
  }
}
