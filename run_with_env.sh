#!/bin/bash

# Load environment variables from .env file
if [ -f .env ]; then
  export $(cat .env | grep -v '^#' | xargs)
else
  echo "❌ .env file not found. Please create it from .env.example"
  exit 1
fi

# Check if required environment variables are set
if [ -z "$GEMINI_API_KEY" ]; then
  echo "❌ GEMINI_API_KEY is not set in .env file"
  exit 1
fi

if [ -z "$SERP_API_KEY" ]; then
  echo "❌ SERP_API_KEY is not set in .env file"  
  exit 1
fi

echo "🚀 Running Flutter app with environment variables..."
echo "📱 Gemini API Key: ${GEMINI_API_KEY:0:10}..."
echo "🔍 Serp API Key: ${SERP_API_KEY:0:10}..."

# Run Flutter with dart-define for each environment variable
flutter run \
  --dart-define=GEMINI_API_KEY="$GEMINI_API_KEY" \
  --dart-define=SERP_API_KEY="$SERP_API_KEY" \
  "$@"
