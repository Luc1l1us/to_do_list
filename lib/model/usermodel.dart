class User {
  final String username;
  final String password;
  final String email;
  final List<String>? tasks;
  
    User({
      required this.username, 
      required this.password, 
      required this.email, 
      this.tasks 
      });
  
    factory User.fromJson(Map<String, dynamic> json) {
      List<String>? tasks;
      if (json['tasks'] != null) {
    tasks = List<String>.from(json['tasks']);
    }
      return User(
        username: json['username'],
        password: json['password'],
        email: json['email'],
        tasks: tasks,
      );
    }
}