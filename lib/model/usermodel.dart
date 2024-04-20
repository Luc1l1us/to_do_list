class User {
  final String username;
  final String password;
  final String email;
  final String? tasks;
  
    User({
      required this.username, 
      required this.password, 
      required this.email, 
      this.tasks 
      });
  
    factory User.fromJson(Map<String, dynamic> json) {
      return User(
        username: json['username'],
        password: json['password'],
        email: json['email'],
        tasks: json['tasks'] != null ? (json['tasks'] as List<dynamic>).join(', ') : null,
      );
    }
}