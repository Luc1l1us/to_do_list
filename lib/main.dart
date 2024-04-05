// ignore_for_file: prefer_const_constructors
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

//Model
class Book {
  final int id;
  final String title;
  final String author;

  Book({required this.id, required this.title, required this.author});

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'],
      title: json['title'],
      author: json['author'],
    );
  }
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
  final List<String> _input = [''];
  final TextEditingController _text = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  List<Book> _books = [];

  static const List<Widget> _listoptions = <Widget>[Text('Trash')];

  void _itemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
    @override
  void initState() {
    super.initState();
    //sendData();
    //_fetchBooks();
  }

    // fetch from server
    /*
    Future<void> _fetchBooks() async {
    final response = await http.get(Uri.http('192.168.68.106:3000', '/api/books'));
    if (response.statusCode == 200) {
      final List<dynamic> json = jsonDecode(response.body);
      setState(() {
      _books = json.map((item) => Book.fromJson(item)).toList();
      });
    } else {
      throw Exception('Failed to load books');
    }
  }*/

  Future<void> sendData(String value) async {
    final response = await http.post(Uri.http('192.168.68.106:3000', '/api/books'));
    headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
    if (response.statusCode == 200) {
      final List<dynamic> json = jsonDecode(response.body);
      setState(() {
      _books = json.map((item) => Book.fromJson(item)).toList();
      });
    } else {
      throw Exception('Failed to load books');
    }
  }

  void _addToList(String value) {
    setState(() {
      _input.add(value);
      sendData(value);
    });
  }

  void _delTask(int key) {
    setState((){
      _input.removeAt(key);
    });
  }

void _openTask(int key) {
  setState(() {
    
  });
}
  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      title: Text(widget.title),
    ),
    body: 
    ListView.builder(
        itemCount: _books.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(_books[index].title),
            subtitle: Text(_books[index].author),
          );
        },
      ),
    );
    /*Container(
      margin: EdgeInsets.all(100),
      child: Form(key: _key, child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            controller: _text,
            decoration: InputDecoration(hintText: 'Input Task'),
            onFieldSubmitted: _addToList,
          ),
          SizedBox(height: 20.0),
          Column(
            children: 
            List.generate(
              _input.length, (index) {
                final buttontext = _input[index];
                return Column(
                  children: [
                    ElevatedButton(
                      key: Key('$index'),
                      onPressed: () {
                        _openTask(index);
                      },
                      style: ButtonStyle(
                        minimumSize: MaterialStatePropertyAll(Size(0,0))
                      ),
                      child: Row( 
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:[
                          Flexible(
                            child:Text(buttontext)
                          ),
                          IconButton(
                            onPressed: () {
                              _delTask(index);
                            }, 
                            icon: Icon(Icons.delete)) // Button text style
                    ])),
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
            _addToList(_text.text);
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
  );*/
}
}
