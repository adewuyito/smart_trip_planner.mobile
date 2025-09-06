import 'config/env_config.dart';

/// Use EnvConfig.geminiApiKey instead of this constant
/// This is kept for backward compatibility but should be removed
@Deprecated('Use EnvConfig.geminiApiKey instead')
const String GEMINI_API_SECRET = EnvConfig.geminiApiKey;
