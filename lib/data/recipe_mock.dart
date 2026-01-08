import 'package:partner_in_cook/common/config/constants/state_enum.dart';
import 'package:partner_in_cook/model/api/light_user.dart';
import 'package:partner_in_cook/model/api/recipe.dart';
import 'package:partner_in_cook/model/api/tag.dart';
import 'package:partner_in_cook/model/api/step.dart';
import 'package:partner_in_cook/model/api/recipe_ingredient.dart';
import 'package:partner_in_cook/model/api/utensil.dart';

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

final recipe1 = Recipe(
  id: '1',
  name: 'Pancakes moelleux',
  description: 'Délicieux pancakes fluffy parfaits pour le petit-déjeuner',
  state: State.publicState,
  preparationTime: 10,
  restTime: 5,
  cookTime: 15,
  isFavorite: false,
  portions: 4,
  pictureUrl: 'https://picsum.photos/seed/pancakes/300/200',
  author: author1,
  tags: [
    Tag(id: '1', name: 'Rapide'),
    Tag(id: '2', name: 'Facile'),
  ],
  steps: [
    Step(
      id: '1',
      description: 'Mélanger les ingrédients secs',
      order: 1,
      recipeId: '1',
    ),
    Step(
      id: '2',
      description: 'Ajouter les œufs et le lait',
      order: 2,
      recipeId: '1',
    ),
    Step(id: '3', description: 'Cuire à la poêle', order: 3, recipeId: '1'),
  ],
  utensils: [
    Utensil(id: '1', name: 'Poêle', iconPictureUrl: null),
    Utensil(id: '2', name: 'Spatule', iconPictureUrl: null),
  ],
  recipeIngredients: [
    RecipeIngredient(id: '1', quantity: 2, recipeId: '1', ingredientId: '1'),
    RecipeIngredient(id: '2', quantity: 250, recipeId: '1', ingredientId: '2'),
  ],
  notationsCount: 100,
  averageNotation: 4.5,
);

final recipe2 = Recipe(
  id: '2',
  name: 'Salade César',
  description: 'Salade frais et croquante avec vinaigrette maison',
  state: State.publicState,
  preparationTime: 15,
  restTime: 0,
  cookTime: 0,
  isFavorite: false,
  portions: 2,
  pictureUrl: 'https://picsum.photos/seed/salad/300/200',
  author: author2,
  tags: [
    Tag(id: '2', name: 'Facile'),
    Tag(id: '3', name: 'Santé'),
  ],
  steps: [
    Step(
      id: '1',
      description: 'Laver et découper la salade',
      order: 1,
      recipeId: '2',
    ),
    Step(
      id: '2',
      description: 'Préparer la vinaigrette',
      order: 2,
      recipeId: '2',
    ),
    Step(id: '3', description: 'Mélanger et servir', order: 3, recipeId: '2'),
  ],
  utensils: [
    Utensil(id: '3', name: 'Couteau', iconPictureUrl: null),
    Utensil(id: '4', name: 'Saladier', iconPictureUrl: null),
  ],
  recipeIngredients: [
    RecipeIngredient(id: '3', quantity: 200, recipeId: '2', ingredientId: '3'),
    RecipeIngredient(id: '4', quantity: 100, recipeId: '2', ingredientId: '4'),
  ],
  notationsCount: 80,
  averageNotation: 4.3,
);

final recipe3 = Recipe(
  id: '3',
  name: 'Pizza Margherita',
  description: 'Pizza classique avec tomate, mozzarella et basilic',
  state: State.publicState,
  preparationTime: 20,
  restTime: 30,
  cookTime: 15,
  isFavorite: true,
  portions: 2,
  pictureUrl: 'https://picsum.photos/seed/pizza/300/200',
  author: author3,
  tags: [Tag(id: '1', name: 'Rapide')],
  steps: [
    Step(id: '1', description: 'Préparer la pâte', order: 1, recipeId: '3'),
    Step(id: '2', description: 'Laisser reposer', order: 2, recipeId: '3'),
    Step(
      id: '3',
      description: 'Ajouter les garnitures',
      order: 3,
      recipeId: '3',
    ),
    Step(id: '4', description: 'Cuire au four', order: 4, recipeId: '3'),
  ],
  utensils: [
    Utensil(id: '5', name: 'Four', iconPictureUrl: null),
    Utensil(id: '6', name: 'Planche à pizza', iconPictureUrl: null),
  ],
  recipeIngredients: [
    RecipeIngredient(id: '5', quantity: 500, recipeId: '3', ingredientId: '5'),
    RecipeIngredient(id: '6', quantity: 250, recipeId: '3', ingredientId: '6'),
  ],
  notationsCount: 1200,
  averageNotation: 4.8,
);

final Recipe recipe4 = Recipe(
  id: '4',
  name: 'Spaghetti Bolognese',
  description: 'Classic Italian pasta dish with rich meat sauce',
  state: State.publicState,
  preparationTime: 15,
  restTime: 0,
  cookTime: 45,
  isFavorite: false,
  portions: 4,
  pictureUrl: 'https://picsum.photos/seed/pizza/300/200',
  author: author3,
  tags: [Tag(id: '1', name: 'Rapide')],
  steps: [
    Step(id: '1', description: 'Préparer la pâte', order: 1, recipeId: '3'),
    Step(id: '2', description: 'Laisser reposer', order: 2, recipeId: '3'),
    Step(
      id: '3',
      description: 'Ajouter les garnitures',
      order: 3,
      recipeId: '3',
    ),
    Step(id: '4', description: 'Cuire au four', order: 4, recipeId: '3'),
  ],
  utensils: [
    Utensil(id: '5', name: 'Four', iconPictureUrl: null),
    Utensil(id: '6', name: 'Planche à pizza', iconPictureUrl: null),
  ],
  recipeIngredients: [
    RecipeIngredient(id: '5', quantity: 500, recipeId: '3', ingredientId: '5'),
    RecipeIngredient(id: '6', quantity: 250, recipeId: '3', ingredientId: '6'),
  ],
  notationsCount: 1200,
  averageNotation: 4.8,
);

final List<Recipe> recipes = [recipe1, recipe2, recipe3, recipe4];

final List<Recipe> latestRecipes = recipes;
