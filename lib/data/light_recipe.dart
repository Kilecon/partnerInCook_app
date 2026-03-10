import 'package:partner_in_cook/model/api/light_recipe.dart';
import 'package:partner_in_cook/model/api/light_user.dart';
import 'package:partner_in_cook/model/api/tag.dart';

final author1 = LightUser(
  id: "1234",
  username: 'Marie Dupont',
  profilePictureUrl: 'https://picsum.photos/seed/marie/100',
);
final author2 = LightUser(
  id: '5678',
  username: 'Jean Martin',
  profilePictureUrl: 'https://picsum.photos/seed/jean/100',
);
final author3 = LightUser(
  id: '91011',
  username: 'Sophie Bernard',
  profilePictureUrl: 'https://picsum.photos/seed/sophie/100',
);

final LightRecipe recipe1 = LightRecipe(
  id: '1',
  name: 'Pancakes moelleux',
  isFavorite: false,
  pictureUrl: 'https://picsum.photos/seed/pancakes/300/200',
  author: author1,
  tags: [Tag(id: '1', name: 'Rapide')],

  globalTime: 30,
  notationsCount: 100,
  averageNotation: 4.5,
);

final recipe2 = LightRecipe(
  id: '2',
  name: 'Salade César',
  isFavorite: false,
  pictureUrl: 'https://picsum.photos/seed/salad/300/200',
  author: author2,
  tags: [Tag(id: '1', name: 'Rapide')],

  globalTime: 20,
  notationsCount: 80,
  averageNotation: 4.3,
);

final recipe3 = LightRecipe(
  id: '3',
  name: 'Pizza Margherita',
  isFavorite: true,
  pictureUrl: 'https://picsum.photos/seed/pizza/300/200',
  author: author3,
  tags: [Tag(id: '1', name: 'Rapide')],

  globalTime: 40,
  notationsCount: 1200,
  averageNotation: 4.8,
);

final LightRecipe recipe4 = LightRecipe(
  id: '4',
  name: 'Spaghetti Bolognese',
  isFavorite: false,
  pictureUrl: 'https://picsum.photos/seed/pizza/300/200',
  author: author3,
  tags: [Tag(id: '1', name: 'Rapide')],
  notationsCount: 1200,
  averageNotation: 4.8,
);

final List<LightRecipe> recipesLight = [recipe1, recipe2, recipe3, recipe4];

final List<LightRecipe> latestLightRecipes = recipesLight;
