class ApiConfig {
  static const String host = 'newsapi.org';
  static const String topHeadlinesPath = '/v2/top-headlines';
  static const String country = 'us';
  static const String apiKey = String.fromEnvironment(
    'NEWS_API_KEY',
    defaultValue: 'TU_API_KEY_AQUI',
  );
}