# API Keys Setup Guide

This guide explains how to securely configure API keys for the Smart Trip Planner app.

## 🔐 Security Overview

API keys are now securely managed using environment variables instead of hardcoding them in the source code. This prevents accidental exposure in version control.

## 📋 Required API Keys

1. **Gemini AI API Key** - For AI-powered itinerary generation
   - Get your key from: https://makersuite.google.com/app/apikey
   
2. **SerpAPI Key** - For web search functionality  
   - Get your key from: https://serpapi.com/

## ⚙️ Setup Instructions

### 1. Create Environment File
```bash
# Copy the example environment file
cp .env.example .env
```

### 2. Add Your API Keys
Edit the `.env` file with your actual API keys:
```bash
# Smart Trip Planner API Keys
GEMINI_API_KEY=your_actual_gemini_api_key_here
SERP_API_KEY=your_actual_serp_api_key_here
```

### 3. Run the App
Use the provided script to run with environment variables:
```bash
# Make sure the script is executable (already done)
chmod +x run_with_env.sh

# Run the app
./run_with_env.sh
```

Or run manually with dart-define:
```bash
flutter run \
  --dart-define=GEMINI_API_KEY="your_gemini_key" \
  --dart-define=SERP_API_KEY="your_serp_key"
```

## 🏗️ Build for Production

For production builds, pass the environment variables:
```bash
# Android APK
flutter build apk \
  --dart-define=GEMINI_API_KEY="$GEMINI_API_KEY" \
  --dart-define=SERP_API_KEY="$SERP_API_KEY"

# iOS
flutter build ios \
  --dart-define=GEMINI_API_KEY="$GEMINI_API_KEY" \
  --dart-define=SERP_API_KEY="$SERP_API_KEY"
```

## 🧪 Testing

For tests, you can use mock values:
```bash
flutter test \
  --dart-define=GEMINI_API_KEY="test_key" \
  --dart-define=SERP_API_KEY="test_key"
```

## 🔧 Code Usage

Access API keys in your Dart code:
```dart
import 'package:smart_trip_planner/config/env_config.dart';

// Get API keys
final geminiKey = EnvConfig.geminiApiKey;
final serpKey = EnvConfig.serpApiKey;

// Validate configuration
EnvConfig.validate(); // Throws exception if keys are missing
```

## ⚠️ Important Notes

- **Never commit** `.env` files to version control
- The `.env` file is already added to `.gitignore`
- Use `.env.example` to share the required variables with team members
- In production, use your deployment platform's environment variable system
- Keys are loaded at compile time using `--dart-define`

## 🐛 Troubleshooting

### "Environment variable is required" error
- Ensure your `.env` file exists and contains the required keys
- Check that you're running with `./run_with_env.sh` or passing `--dart-define` flags

### Keys not working
- Verify your API keys are valid and active
- Check API quotas and billing (if applicable)
- Ensure no extra spaces in the `.env` file

### File not found errors  
- Make sure you're in the project root directory
- Verify the `.env` file exists: `ls -la .env`
