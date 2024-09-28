class Candidate {
  final String id;
  final String name;
  int votes;

  Candidate({required this.id, required this.name, this.votes = 0});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'votes': votes,
    };
  }

  factory Candidate.fromJson(Map<String, dynamic> json) {
    return Candidate(
      id: json['id'],
      name: json['name'],
      votes: json['votes'],
    );
  }
}