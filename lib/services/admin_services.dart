import 'package:uuid/uuid.dart';
import '../models/candidate.dart';
import 'storage_service.dart';

class AdminService {
  final StorageService _storageService;
  final _uuid = Uuid();

  AdminService(this._storageService);

  Future<void> addCandidate(String name) async {
    final candidates = await getCandidates();
    final newCandidate = Candidate(id: _uuid.v4(), name: name);
    candidates.add(newCandidate);
    await _storageService.saveCandidates(candidates);
  }

  Future<List<Candidate>> getCandidates() async {
    return await _storageService.getCandidates();
  }
}