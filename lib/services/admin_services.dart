import '../models/candidate.dart';
import 'storage_service.dart';

class AdminService {
  final StorageService _storage;

  AdminService(this._storage);

  Future<void> addCandidate(String name) async {
    final candidates = await _storage.getCandidates();
    final newCandidate = Candidate(
      id: (candidates.length + 1).toString(),
      name: name,
    );
    candidates.add(newCandidate);
    await _storage.saveCandidates(candidates);
  }

  Future<List<Candidate>> getCandidates() async {
    return await _storage.getCandidates();
  }

  Future<void> displayResults() async {
    final candidates = await _storage.getCandidates();
    print('\nElection Results:');
    for (var candidate in candidates) {
      print('${candidate.name}: ${candidate.votes} votes');
    }
  }
}