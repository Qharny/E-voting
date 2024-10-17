# E-Voting Platform

A console-based e-voting platform implemented in Dart. This application provides a simple and secure way to conduct elections with separate interfaces for administrators and users.

## Features

- **Admin Functions**:
  - Add candidates
  - View list of candidates
  - Print election results

- **User Functions**:
  - Register as a voter
  - View list of candidates
  - Cast a vote (one-time only)
  - Print election results

- **General Features**:
  - Secure voting process
  - Unique ID generation for users
  - Persistent storage of candidates and users
  - Real-time result calculation and display

## Prerequisites

- Dart SDK (version 2.12.0 or higher)

## Setup

1. Clone the repository:
   ```
   git clone https://github.com/Qharny/E-voting
   cd e-voting
   ```

2. Install dependencies:
   ```
   dart pub get
   ```

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

## Running the Application

To start the e-voting platform, run the following command in the project root:

```
dart run bin/main.dart
```

## Usage

1. **Main Menu**:
   - Choose between Admin mode, User mode, printing results, or exiting the application.

2. **Admin Mode**:
   - Add new candidates
   - View the list of candidates
   - Print current election results

3. **User Mode**:
   - Register as a new voter (you'll receive a unique ID)
   - View the list of candidates
   - Cast your vote
   - Print current election results

## Data Persistence

The application uses JSON files to store data:
- `candidates.json`: Stores information about candidates and their vote counts
- `users.json`: Stores registered user information

These files are created in the project root directory when the application is first run.

## Contributing

Contributions to improve the e-voting platform are welcome. Please feel free to submit a Pull Request.

## License

This project is open source and available under the [MIT License](https://github.com/Qharny/MicroLang/blob/main/licence).