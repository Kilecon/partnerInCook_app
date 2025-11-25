import 'Author.dart';
import 'Category.dart';

class Recipe {
  final String title;
  final String imageUrl;
  final double rating;
  final int minutes;
  final int likes;
  final Category category;
  final Author author;
  const Recipe({
    required this.title,
    required this.imageUrl,
    required this.rating,
    required this.minutes,
    required this.likes,
    required this.category,
    required this.author,
  });
}