# E-Voting Platform

A command-line e-voting platform implemented in Dart. This application provides a simple interface for administrators to manage candidates and for users to cast their votes.

## Features

- Admin functionality:
  - Add new candidates
  - View list of candidates
- User functionality:
  - Generate or use a unique ID
  - View list of candidates
  - Cast a vote (once per user)
- Data persistence using shared_preferences
- Error handling and input validation

## Prerequisites

- Dart SDK (version 2.12.0 or higher)

## Installation

1. Clone the repository:
   ```
   git clone https://github.com/yourusername/e_voting_platform.git
   cd e_voting_platform
   ```

2. Install dependencies:
   ```
   dart pub get
   ```

## Usage

Run the application using the following command:

```
dart run bin/main.dart
```

### Admin Menu

1. Select option 1 from the main menu to access the Admin Menu.
2. In the Admin Menu, you can:
   - Add a new candidate (option 1)
   - View the list of candidates (option 2)

### User Menu

1. Select option 2 from the main menu to access the User Menu.
2. Enter your unique ID or press Enter to generate a new one.
3. In the User Menu, you can:
   - View the list of candidates (option 1)
   - Cast your vote (option 2)

Note: Each user can only vote once.

## Project Structure

```
e_voting_platform/
├── bin/
│   └── main.dart
├── lib/
│   ├── models/
│   │   ├── candidate.dart
│   │   └── user.dart
│   ├── services/
│   │   ├── admin_service.dart
│   │   ├── user_service.dart
│   │   └── storage_service.dart
│   └── utils/
│       └── id_generator.dart
├── pubspec.yaml
└── README.md
```

## Dependencies

- shared_preferences: ^2.0.15
- uuid: ^3.0.6

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is open source and available under the [MIT License](https://github.com/Qharny/MicroLang/blob/main/licence).

## Disclaimer

This e-voting platform is a basic implementation for educational purposes. It is not suitable for use in real-world elections without significant security enhancements and thorough testing.