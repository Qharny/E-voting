import '../models/user.dart';
import '../models/candidate.dart';
import 'storage_service.dart';
import '../utils/id_generator.dart';

class UserService {
  final StorageService _storage;

  UserService(this._storage);

  Future<User> registerUser(String name) async {
    final users = await _storage.getUsers();
    final newUser = User(
      id: generateUniqueId(),
      name: name,
    );
    users.add(newUser);
    await _storage.saveUsers(users);
    return newUser;
  }

  Future<bool> vote(String userId, String candidateId) async {
    final users = await _storage.getUsers();
    final candidates = await _storage.getCandidates();

    final userIndex = users.indexWhere((u) => u.id == userId);
    if (userIndex == -1) {
      print('User not found.');
      return false;
    }

    if (users[userIndex].hasVoted) {
      print('You have already voted.');
      return false;
    }

    final candidateIndex = candidates.indexWhere((c) => c.id == candidateId);
    if (candidateIndex == -1) {
      print('Candidate not found.');
      return false;
    }

    users[userIndex].hasVoted = true;
    candidates[candidateIndex].votes++;

    await _storage.saveUsers(users);
    await _storage.saveCandidates(candidates);

    print('Vote cast successfully.');
    return true;
  }

  Future<List<Candidate>> getCandidates() async {
    return await _storage.getCandidates();
  }
  Future<String> getResults() async {
    final candidates = await _storage.getCandidates();
    candidates.sort((a, b) => b.votes.compareTo(a.votes)); // Sort by votes in descending order
    
    StringBuffer result = StringBuffer('Election Results:\n');
    for (var candidate in candidates) {
      result.writeln('${candidate.name}: ${candidate.votes} votes');
    }
    
    return result.toString();
  }
}
