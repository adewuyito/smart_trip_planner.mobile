/// Environment configuration manager for API keys and secrets
class EnvConfig {
  /// Gemini AI API Key
  static const String geminiApiKey = String.fromEnvironment(
    'GEMINI_API_KEY',
    defaultValue: '',
  );

  /// SerpAPI Key for web search functionality
  static const String serpApiKey = String.fromEnvironment(
    'SERP_API_KEY', 
    defaultValue: '',
  );

  /// Validate that all required environment variables are set
  static void validate() {
    if (geminiApiKey.isEmpty) {
      throw Exception('GEMINI_API_KEY environment variable is required');
    }
    if (serpApiKey.isEmpty) {
      throw Exception('SERP_API_KEY environment variable is required');
    }
  }

  /// Check if environment is properly configured
  static bool get isConfigured => 
      geminiApiKey.isNotEmpty && serpApiKey.isNotEmpty;
}
