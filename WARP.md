# WARP.md

This file provides guidance to WARP (warp.dev) when working with code in this repository.

## Project Overview

This is **Smart Trip Planner** ("Itinera AI"), a Flutter mobile application for trip planning. The app uses Flutter hooks with Riverpod for state management and Google Fonts for typography.

## Key Dependencies & Architecture

- **Flutter Hooks** (`flutter_hooks`): Used for state management in widgets
- **Riverpod** (`hooks_riverpod`): State management solution (HookConsumerWidget pattern)
- **Google Fonts** (`google_fonts`): Custom typography throughout the app
- **Flutter Version Management**: Uses FVM with stable Flutter channel (see `.fvmrc`)

### Architecture Pattern
The app follows a **presentation-first architecture**:
- `lib/main.dart`: App entry point that launches `App` widget
- `lib/presentation/`: Contains all UI layer components
  - `app.dart`: Root MaterialApp configuration
  - `onboarding/`: Authentication views (login, signup)
  - `profile/`: User profile and account management

### State Management Pattern
- Uses `HookConsumerWidget` from hooks_riverpod for stateful widgets
- Text controllers managed with `useTextEditingController()` hook
- Form keys created as `GlobalKey()` instances

### UI Patterns
- Consistent color scheme: Primary green `Color(0xFF065F46)`, secondary gray `Color(0xFF8F95B2)`
- Google Fonts Inter used throughout for typography
- Reusable form input widgets (`emailFormInputField`, `passwordFormInputField`)
- Custom styled ElevatedButtons with rounded corners and specific color schemes

## Common Development Commands

### Build & Run
```bash
# Run the app in debug mode
flutter run

# Run on specific device
flutter run -d <device-id>

# Build for release (Android)
flutter build apk --release

# Build for release (iOS)
flutter build ios --release
```

### Development Tools
```bash
# Hot reload during development
# Press 'r' in terminal while app is running

# Hot restart
# Press 'R' in terminal while app is running

# Check for issues
flutter doctor

# Clean build cache
flutter clean && flutter pub get
```

### Testing & Quality
```bash
# Run all tests
flutter test

# Run specific test file
flutter test test/path/to/test_file.dart

# Analyze code for issues
flutter analyze

# Format code
dart format lib/

# Run custom lints (configured in analysis_options.yaml)
dart run custom_lint
```

### Dependencies
```bash
# Get dependencies
flutter pub get

# Add new dependency
flutter pub add package_name

# Add dev dependency  
flutter pub add package_name --dev

# Update dependencies
flutter pub upgrade
```

## Project Structure Notes

### Widget Construction Patterns
- Form widgets use `GlobalKey()` for form validation
- TextEditingController instances created with Flutter hooks: `useTextEditingController()`
- Consistent spacing using `const SizedBox(height: value)`
- Row/Column widgets often use `spacing: value` parameter for consistent gaps

### Styling Conventions
- Colors defined inline as `Color(0xFFHEXCODE)` 
- Google Fonts applied via `GoogleFonts.inter()` with theme text styles
- Consistent border radius values: 8px for inputs, 16px for buttons
- ElevatedButton styling follows pattern with shadowColor: Colors.transparent

### Navigation Setup
Currently the app starts with `ProfileView` as the home screen (likely temporary for development). Authentication views exist but aren't connected to routing yet.

### FVM Configuration
This project uses Flutter Version Manager (FVM) locked to the "stable" channel. Ensure FVM is installed and run `fvm use stable` when setting up the project locally.
