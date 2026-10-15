import 'package:flutter/material.dart';

import '../models/article.dart';
import '../models/news_category.dart';
import '../services/news_service.dart';
import '../widgets/news_card.dart';

class NewsListScreen extends StatefulWidget {
  final NewsCategory category;

  const NewsListScreen({super.key, required this.category});

  @override
  State<NewsListScreen> createState() => _NewsListScreenState();
}

class _NewsListScreenState extends State<NewsListScreen> {
  final NewsService _service = NewsService();
  late Future<List<Article>> _future;

  @override
  void initState() {
    super.initState();
    _future = _service.fetchTopHeadlines(widget.category);
  }

  void _retry() {
    setState(() {
      _future = _service.fetchTopHeadlines(widget.category);
    });
  }

  Future<void> _refresh() async {
    final newFuture = _service.fetchTopHeadlines(widget.category);
    setState(() {
      _future = newFuture;
    });
    try {
      await newFuture;
    } catch (_) {
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Article>>(
      future: _future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          final message =
              snapshot.error.toString().replaceFirst('Exception: ', '');
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.error_outline, size: 48),
                  const SizedBox(height: 12),
                  Text(message, textAlign: TextAlign.center),
                  const SizedBox(height: 12),
                  FilledButton(
                    onPressed: _retry,
                    child: const Text('Reintentar'),
                  ),
                ],
              ),
            ),
          );
        }

        final articles = snapshot.data ?? [];
        if (articles.isEmpty) {
          return const Center(child: Text('No hay noticias disponibles'));
        }

        return RefreshIndicator(
          onRefresh: _refresh,
          child: ListView.separated(
            itemCount: articles.length,
            separatorBuilder: (context, index) => const Divider(height: 1),
            itemBuilder: (context, i) =>
                NewsCard(position: i + 1, article: articles[i]),
          ),
        );
      },
    );
  }
}