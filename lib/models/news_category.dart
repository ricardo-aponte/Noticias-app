import 'package:flutter/material.dart';

enum NewsCategory {
  sports('sports', 'Deportes', Icons.sports_soccer, Colors.green),
  health('health', 'Salud', Icons.favorite, Colors.red),
  science('science', 'Ciencia', Icons.science, Colors.indigo);

  final String apiValue; 
  final String label; 
  final IconData icon;
  final Color color;

  const NewsCategory(this.apiValue, this.label, this.icon, this.color);
}