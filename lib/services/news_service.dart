import 'dart:convert';

import 'package:http/http.dart' as http;

import '../config/api_config.dart';
import '../models/article.dart';
import '../models/news_category.dart';

class NewsService {
  Future<List<Article>> fetchTopHeadlines(NewsCategory category) async {
    final uri = Uri.https(ApiConfig.host, ApiConfig.topHeadlinesPath, {
      'country': ApiConfig.country,
      'category': category.apiValue,
      'apiKey': ApiConfig.apiKey,
    });

    final http.Response response;
    try {
      response = await http.get(uri).timeout(const Duration(seconds: 15));
    } catch (_) {
      throw Exception('No se pudo conectar.');
    }

    Map<String, dynamic> body;
    try {
      body = json.decode(response.body) as Map<String, dynamic>;
    } catch (_) {
      throw Exception('Respuesta inválida del servidor (${response.statusCode}).');
    }

    if (response.statusCode != 200 || body['status'] != 'ok') {
      throw Exception(body['message'] ?? 'Error ${response.statusCode}');
    }

    final List<dynamic> articles = body['articles'] as List<dynamic>? ?? [];
    return articles
        .map((e) => Article.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}