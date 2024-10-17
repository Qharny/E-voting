import 'dart:io';

import 'package:dart_e_voting/services/admin_services.dart';
import 'package:dart_e_voting/services/storage_service.dart';
import 'package:dart_e_voting/services/user_services.dart';


void main() async {
  final storage = StorageService();
  final adminService = AdminService(storage);
  final userService = UserService(storage);

  while (true) {
    print('\n--- E-Voting Platform ---');
    print('1. Admin');
    print('2. User');
    print('3. Print Results');
    print('4. Exit');
    print('Enter your choice:');

    final choice = int.tryParse(stdin.readLineSync() ?? '');

    switch (choice) {
      case 1:
        await adminMenu(adminService);
        break;
      case 2:
        await userMenu(userService);
        break;
      case 3:
        print(await adminService.getResults());
        break;
      case 4:
        print('Goodbye!');
        return;
      default:
        print('Invalid choice. Please try again.');
    }
  }
}

Future<void> adminMenu(AdminService adminService) async {
  while (true) {
    print('\n--- Admin Menu ---');
    print('1. Add Candidate');
    print('2. View Candidates');
    print('3. Print Results');
    print('4. Back to Main Menu');
    print('Enter your choice:');

    final choice = int.tryParse(stdin.readLineSync() ?? '');

    switch (choice) {
      case 1:
        print('Enter candidate name:');
        final name = stdin.readLineSync();
        if (name != null && name.isNotEmpty) {
          await adminService.addCandidate(name);
          print('Candidate added successfully.');
        } else {
          print('Invalid name. Please try again.');
        }
        break;
      case 2:
        final candidates = await adminService.getCandidates();
        if (candidates.isEmpty) {
          print('No candidates found.');
        } else {
          for (var candidate in candidates) {
            print('ID: ${candidate.id}, Name: ${candidate.name}');
          }
        }
        break;
      case 3:
        print(await adminService.getResults());
        break;
      case 4:
        return;
      default:
        print('Invalid choice. Please try again.');
    }
  }
}

Future<void> userMenu(UserService userService) async {
  print('\n--- User Registration ---');
  print('Enter your name:');
  final name = stdin.readLineSync();
  if (name == null || name.isEmpty) {
    print('Invalid name. Please try again.');
    return;
  }

  final user = await userService.registerUser(name);
  print('Registration successful. Your ID is: ${user.id}');

  while (true) {
    print('\n--- User Menu ---');
    print('1. View Candidates');
    print('2. Vote');
    print('3. Print Results');
    print('4. Back to Main Menu');
    print('Enter your choice:');

    final choice = int.tryParse(stdin.readLineSync() ?? '');

    switch (choice) {
      case 1:
        final candidates = await userService.getCandidates();
        if (candidates.isEmpty) {
          print('No candidates found.');
        } else {
          for (var candidate in candidates) {
            print('ID: ${candidate.id}, Name: ${candidate.name}');
          }
        }
        break;
      case 2:
        print('Enter the ID of the candidate you want to vote for:');
        final candidateId = stdin.readLineSync();
        if (candidateId != null && candidateId.isNotEmpty) {
          await userService.vote(user.id, candidateId);
        } else {
          print('Invalid candidate ID. Please try again.');
        }
        break;
      case 3:
        print(await userService.getResults());
        break;
      case 4:
        return;
      default:
        print('Invalid choice. Please try again.');
    }
  }
}