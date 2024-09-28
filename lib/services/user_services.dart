import 'package:dart_e_voting/models/candidate.dart';

import '../models/user.dart';
import '../utils/id_generator.dart';
import 'storage_service.dart';

class UserService {
  final StorageService _storageService;

  UserService(this._storageService);

  Future<User> getOrCreateUser(String? userId) async {
    if (userId == null || userId.isEmpty) {
      final newUser = User(id: generateUniqueId());
      await _storageService.saveUser(newUser);
      return newUser;
    }

    final existingUser = await _storageService.getUser(userId);
    if (existingUser != null) {
      return existingUser;
    } else {
      final newUser = User(id: userId);
      await _storageService.saveUser(newUser);
      return newUser;
    }
  }

  Future<List<Candidate>> getCandidates() async {
    return await _storageService.getCandidates();
  }

  Future<bool> vote(String userId, String candidateId) async {
    final user = await _storageService.getUser(userId);
    if (user == null || user.hasVoted) {
      return false;
    }

    final candidates = await getCandidates();
    final candidateIndex = candidates.indexWhere((c) => c.id == candidateId);
    if (candidateIndex == -1) {
      return false;
    }

    candidates[candidateIndex].votes++;
    user.hasVoted = true;

    await _storageService.saveCandidates(candidates);
    await _storageService.saveUser(user);

    return true;
  }
}
