class User {
  final String id;
  final String name;
  bool hasVoted;

  User({required this.id, required this.name, this.hasVoted = false});

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'hasVoted': hasVoted,
      };

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'],
        name: json['name'],
        hasVoted: json['hasVoted'],
      );
}