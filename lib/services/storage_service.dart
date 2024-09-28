import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/candidate.dart';
import '../models/user.dart';

class StorageService {
  late SharedPreferences _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<List<Candidate>> getCandidates() async {
    final candidatesJson = _prefs.getStringList('candidates') ?? [];
    return candidatesJson
        .map((json) => Candidate.fromJson(jsonDecode(json)))
        .toList();
  }

  Future<void> saveCandidates(List<Candidate> candidates) async {
    final candidatesJson =
        candidates.map((c) => jsonEncode(c.toJson())).toList();
    await _prefs.setStringList('candidates', candidatesJson);
  }

  Future<User?> getUser(String userId) async {
    final userJson = _prefs.getString('user_$userId');
    if (userJson != null) {
      return User.fromJson(jsonDecode(userJson));
    }
    return null;
  }

  Future<void> saveUser(User user) async {
    await _prefs.setString('user_${user.id}', jsonEncode(user.toJson()));
  }
}