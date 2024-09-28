import 'dart:io';

import 'package:dart_e_voting/services/admin_services.dart';
import 'package:dart_e_voting/services/storage_service.dart';
import 'package:dart_e_voting/services/user_services.dart';


void main() async {
  final storageService = StorageService();
  await storageService.init();

  final adminService = AdminService(storageService);
  final userService = UserService(storageService);

  while (true) {
    print('\n--- E-Voting Platform ---');
    print('1. Admin Login');
    print('2. User Login');
    print('3. Exit');
    print('Enter your choice:');

    final choice = stdin.readLineSync();

    switch (choice) {
      case '1':
        await adminMenu(adminService);
        break;
      case '2':
        await userMenu(userService);
        break;
      case '3':
        print('Goodbye!');
        exit(0);
      default:
        print('Invalid choice. Please try again.');
    }
  }
}

Future<void> adminMenu(AdminService adminService) async {
  print('\n--- Admin Menu ---');
  print('1. Add Candidate');
  print('2. View Candidates');
  print('3. Back');
  print('Enter your choice:');

  final choice = stdin.readLineSync();

  switch (choice) {
    case '1':
      print('Enter candidate name:');
      final name = stdin.readLineSync();
      if (name != null && name.isNotEmpty) {
        await adminService.addCandidate(name);
        print('Candidate added successfully.');
      } else {
        print('Invalid candidate name.');
      }
      break;
    case '2':
      final candidates = await adminService.getCandidates();
      print('\nCandidates:');
      for (final candidate in candidates) {
        print('${candidate.id}: ${candidate.name}');
      }
      break;
    case '3':
      return;
    default:
      print('Invalid choice. Please try again.');
  }
}

Future<void> userMenu(UserService userService) async {
  print('\nEnter your unique ID (or press Enter to generate a new ID):');
  final userId = stdin.readLineSync();

  final user = await userService.getOrCreateUser(userId);
  print('Welcome, User ${user.id}!');

  if (user.hasVoted) {
    print('You have already voted.');
    return;
  }

  print('\n--- User Menu ---');
  print('1. View Candidates');
  print('2. Vote');
  print('3. Back');
  print('Enter your choice:');

  final choice = stdin.readLineSync();

  switch (choice) {
    case '1':
      final candidates = await userService.getCandidates();
      print('\nCandidates:');
      for (final candidate in candidates) {
        print('${candidate.id}: ${candidate.name}');
      }
      break;
    case '2':
      final candidates = await userService.getCandidates();
      if (candidates.isEmpty) {
        print('No candidates available. Please try again later.');
        return;
      }

      print('\nCandidates:');
      for (final candidate in candidates) {
        print('${candidate.id}: ${candidate.name}');
      }

      print('\nEnter the ID of the candidate you want to vote for:');
      final candidateId = stdin.readLineSync();
      if (candidateId != null) {
        final success = await userService.vote(user.id, candidateId);
        if (success) {
          print('Vote recorded successfully.');
        } else {
          print('Failed to record vote. Please try again.');
        }
      } else {
        print('Invalid candidate ID.');
      }
      break;
    case '3':
      return;
    default:
      print('Invalid choice. Please try again.');
  }
}