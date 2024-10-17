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