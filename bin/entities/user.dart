class User {
  User({required this.name});

  final String name;

  Map<String, dynamic> toMap() {
    return {
      'name': name,
    };
  }
}
