import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'model/usermodel.dart';

List<User> _users = [];
//register
Future<void> registeruser(String username, password, email, value) async {
  final Map<String, dynamic> postData = {
    'username': username,
    'password': password,
    'email': email,
    'value': value,
  };
  final response = await http.post(Uri.http(dotenv.env['DB_URL']!, '/api/registeruser'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(postData),
  );

  if (response.statusCode == 201) {
    print('Data posted successfully');
  } else {
    throw Exception('Failed to post values');
  }
}

//fetch users from server
Future<void> _fetchUsers() async {
    final response = await http.get(Uri.http(dotenv.env['DB_URL']!, '/api/fetchusers'));
    if (response.statusCode == 200) {
      final List<dynamic> json = jsonDecode(response.body);
      _users = json.map((item) => User.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load books');
    }
}

//update document with valueway
Future<void> updateData(String value) async {
  final Map<String, dynamic> postData = {
    'value': value
  };
  final response = await http.post(Uri.http(dotenv.env['DB_URL']!, '/api/update'),
  headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(postData),
  );

  if (response.statusCode == 201) {
    print('Data posted successfully');
  } else {
    throw Exception('Failed to post values');
  }
}