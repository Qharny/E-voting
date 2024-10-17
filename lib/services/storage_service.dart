import 'dart:io';
import 'dart:convert';
import '../models/candidate.dart';
import '../models/user.dart';

class StorageService {
  static const String _candidatesFile = 'candidates.json';
  static const String _usersFile = 'users.json';

  Future<List<Candidate>> getCandidates() async {
    final file = File(_candidatesFile);
    if (!await file.exists()) return [];
    final content = await file.readAsString();
    final candidatesList = jsonDecode(content) as List;
    return candidatesList.map((c) => Candidate.fromJson(c)).toList();
  }

  Future<void> saveCandidates(List<Candidate> candidates) async {
    final file = File(_candidatesFile);
    final content = jsonEncode(candidates.map((c) => c.toJson()).toList());
    await file.writeAsString(content);
  }

  Future<List<User>> getUsers() async {
    final file = File(_usersFile);
    if (!await file.exists()) return [];
    final content = await file.readAsString();
    final usersList = jsonDecode(content) as List;
    return usersList.map((u) => User.fromJson(u)).toList();
  }

  Future<void> saveUsers(List<User> users) async {
    final file = File(_usersFile);
    final content = jsonEncode(users.map((u) => u.toJson()).toList());
    await file.writeAsString(content);
  }
}