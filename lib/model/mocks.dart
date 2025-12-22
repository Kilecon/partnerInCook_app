import 'package:partner_in_cook/model/Author.dart';
import 'package:partner_in_cook/model/Category.dart';
import 'package:partner_in_cook/model/Recipe.dart';

final author1 = Author(name: 'Marie Dupont', avatarUrl: '');
final author2 = Author(name: 'Jean Martin', avatarUrl: '');
final author3 = Author(name: 'Sophie Bernard', avatarUrl: '');

final recipe1 = Recipe(
  title: 'Pancakes moelleux',
  imageUrl: 'https://picsum.photos/seed/pancakes/300/200',
  rating: 4.5,
  minutes: 20,
  likes: 100,
  category: Category.tout,
  author: author1,
);
final recipe2 = Recipe(
  title: 'Salade César',
  imageUrl: 'https://picsum.photos/seed/salad/300/200',
  rating: 4.5,
  minutes: 15,
  likes: 80,
  category: Category.plats,
  author: author2,
);
final recipe3 = Recipe(
  title: 'Pizza Margherita',
  imageUrl: 'https://picsum.photos/seed/pizza/300/200',
  rating: 4.5,
  minutes: 45,
  likes: 1200,
  category: Category.plats,
  author: author3,
);
final recipe4 = Recipe(
  title: 'Pancakes moelleux',
  imageUrl: 'https://picsum.photos/seed/pancakes/300/200',
  rating: 4.5,
  minutes: 20,
  likes: 100,
  category: Category.tout,
  author: author1,
);
final recipe5 = Recipe(
  title: 'Salade César',
  imageUrl: 'https://picsum.photos/seed/salad/300/200',
  rating: 4.5,
  minutes: 15,
  likes: 80,
  category: Category.plats,
  author: author2,
);
final recipe6 = Recipe(
  title: 'Pizza Margherita',
  imageUrl: 'https://picsum.photos/seed/pizza/300/200',
  rating: 4.5,
  minutes: 45,
  likes: 1200,
  category: Category.plats,
  author: author3,
);
final List<Recipe> recipes = [
  recipe1,
  recipe2,
  recipe3,
  recipe4,
  recipe5,
  recipe6,
];
final List<Recipe> latestRecipes = recipes.take(4).toList();
