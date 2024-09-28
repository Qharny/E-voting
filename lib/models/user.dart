class User {
  final String id;
  bool hasVoted;

  User({required this.id, this.hasVoted = false});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'hasVoted': hasVoted,
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      hasVoted: json['hasVoted'],
    );
  }
}