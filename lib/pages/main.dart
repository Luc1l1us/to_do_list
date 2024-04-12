// ignore_for_file: prefer_const_constructors
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'loginscreen.dart';
import 'registerscreen.dart';
import '../model/usermodel.dart';
import '../userservice.dart';

String globaltoken = '';
void main() async {
  await dotenv.load(fileName: '.env');
  await SharedPreferences.getInstance();
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
      home: registerscreen(title: 'Login')//const MyHomePage(title: 'To-Do'),
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
  List<User> _users = [];

  static const List<Widget> _listoptions = <Widget>[Text('Trash')];

  void _itemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
    @override
  void initState() {
    super.initState();
    fetchtasks();
  }

  void _addToList(String value) {
    setState(() {
      _input.add(value);
      updateData(value, globaltoken);
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
    // Use this to fetch data from DB
    /*ListView.builder(
        itemCount: _books.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(_books[index].title),
            subtitle: Text(_books[index].author),
          );
        },
      ),
    ); */
    Container(
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
          heroTag: 'reset_button',
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
          heroTag: 'add_button',
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
            title: Text('Register'), //replacement for now
            selected: _selectedIndex == 1,
            onTap: () {
              _itemTapped(0);
                Navigator.push(context, MaterialPageRoute(builder: (context) => registerscreen(title: 'Register Screen')));
            },
          ),
          ListTile(
            title: Text('Login'), //replacement for now
            selected: _selectedIndex == 1,
            onTap: () {
              _itemTapped(0);
                Navigator.push(context, MaterialPageRoute(builder: (context) => loginscreen(title: 'Login Screen')));
            },
          ),
        ],
      ),
    ),
  );
}
}
