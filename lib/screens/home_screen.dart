import 'package:flutter/material.dart';

import '../models/news_category.dart';
import 'news_list_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    const categories = NewsCategory.values;
    final current = categories[_currentIndex];
    final scheme = ColorScheme.fromSeed(
      seedColor: current.color,
      brightness: Theme.of(context).brightness,
    );

    return Theme(
      data: ThemeData(useMaterial3: true, colorScheme: scheme),
      child: Scaffold(
        appBar: AppBar(
          title: Text(current.label),
          backgroundColor: scheme.primary,
          foregroundColor: scheme.onPrimary,
        ),
        body: IndexedStack(
          index: _currentIndex,
          children: [
            for (final c in categories) NewsListScreen(category: c),
          ],
        ),
        bottomNavigationBar: NavigationBar(
          selectedIndex: _currentIndex,
          onDestinationSelected: (i) => setState(() => _currentIndex = i),
          destinations: [
            for (final c in categories)
              NavigationDestination(icon: Icon(c.icon), label: c.label),
          ],
        ),
      ),
    );
  }
}