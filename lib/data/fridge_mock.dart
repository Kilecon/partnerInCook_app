import 'package:partner_in_cook/model/ingredient.dart';
import 'package:partner_in_cook/model/fridge.dart';
import 'package:partner_in_cook/model/fridge_ingredient.dart';
import 'package:partner_in_cook/model/light_user.dart';

/// Utilisateurs mock
final LightUser userAlice = LightUser(
  id: 'u_alice',
  username: 'Alice',
  profilePictureUrl: 'https://i.pravatar.cc/150?img=1',
);

final LightUser userBob = LightUser(
  id: 'u_bob',
  username: 'Bob',
  profilePictureUrl: 'https://i.pravatar.cc/150?img=2',
);

final LightUser userClara = LightUser(
  id: 'u_clara',
  username: 'Clara',
  profilePictureUrl: null,
);

/// Ingrédients mock (id corrélé aux FridgeIngredient.ingredientId)
final Ingredient ingFlour = Ingredient(
  id: 'ing_flour',
  name: 'Farine',
  unit: 'g',
  quantity: 1000,
  density: null,
  userId: null,
  iconPictureUrl: null,
);

final Ingredient ingSugar = Ingredient(
  id: 'ing_sugar',
  name: 'Sucre',
  unit: 'g',
  quantity: 500,
  density: null,
  userId: null,
  iconPictureUrl: null,
);

final Ingredient ingMilk = Ingredient(
  id: 'ing_milk',
  name: 'Lait',
  unit: 'ml',
  quantity: 200,
  density: null,
  userId: null,
  iconPictureUrl: null,
);

final Ingredient ingEgg = Ingredient(
  id: 'ing_egg',
  name: 'Œuf',
  unit: 'pcs',
  quantity: 12,
  density: null,
  userId: null,
  iconPictureUrl: null,
);

final Ingredient ingButter = Ingredient(
  id: 'ing_butter',
  name: 'Beurre',
  unit: 'g',
  quantity: 250,
  density: null,
  userId: null,
  iconPictureUrl: null,
);

final Ingredient ingTomato = Ingredient(
  id: 'ing_tomato',
  name: 'Tomate',
  unit: 'pcs',
  quantity: 5,
  density: null,
  userId: null,
  iconPictureUrl: null,
);

final Ingredient ingOnion = Ingredient(
  id: 'ing_onion',
  name: 'Oignon',
  unit: 'pcs',
  quantity: 4,
  density: null,
  userId: null,
  iconPictureUrl: null,
);

final Ingredient ingGarlic = Ingredient(
  id: 'ing_garlic',
  name: 'Ail',
  unit: 'g',
  quantity: 50,
  density: null,
  userId: null,
  iconPictureUrl: null,
);

final Ingredient ingCheese = Ingredient(
  id: 'ing_cheese',
  name: 'Fromage',
  unit: 'g',
  quantity: 200,
  density: null,
  userId: null,
  iconPictureUrl: null,
);

final List<Ingredient> ingredientsMock = [
  ingFlour,
  ingSugar,
  ingMilk,
  ingEgg,
  ingButter,
  ingTomato,
  ingOnion,
  ingGarlic,
  ingCheese,
];

/// FridgeIngredient mock (référence ingredientId)
final FridgeIngredient f1i1 = FridgeIngredient(
  id: 'f1i1',
  quantity: 1000,
  fridgeId: 'fridge_1',
  ingredientId: ingFlour.id,
);

final FridgeIngredient f1i2 = FridgeIngredient(
  id: 'f1i2',
  quantity: 500,
  fridgeId: 'fridge_1',
  ingredientId: ingSugar.id,
);

final FridgeIngredient f1i3 = FridgeIngredient(
  id: 'f1i3',
  quantity: 1000,
  fridgeId: 'fridge_1',
  ingredientId: ingMilk.id,
);

final FridgeIngredient f2i1 = FridgeIngredient(
  id: 'f2i1',
  quantity: 6,
  fridgeId: 'fridge_2',
  ingredientId: ingEgg.id,
);

final FridgeIngredient f2i2 = FridgeIngredient(
  id: 'f2i2',
  quantity: 250,
  fridgeId: 'fridge_2',
  ingredientId: ingButter.id,
);

final FridgeIngredient f3i1 = FridgeIngredient(
  id: 'f3i1',
  quantity: 3,
  fridgeId: 'fridge_3',
  ingredientId: ingTomato.id,
);

final FridgeIngredient f3i2 = FridgeIngredient(
  id: 'f3i2',
  quantity: 2,
  fridgeId: 'fridge_3',
  ingredientId: ingOnion.id,
);

final FridgeIngredient f3i3 = FridgeIngredient(
  id: 'f3i3',
  quantity: 30,
  fridgeId: 'fridge_3',
  ingredientId: ingCheese.id,
);

final FridgeIngredient f3i4 = FridgeIngredient(
  id: 'f3i4',
  quantity: 10,
  fridgeId: 'fridge_3',
  ingredientId: ingGarlic.id,
);

/// Fridges mock
final Fridge fridge1 = Fridge(
  id: 'fridge_1',
  owner: userAlice,
  ingredients: [f1i1, f1i2, f1i3],
);

final Fridge fridge2 = Fridge(
  id: 'fridge_2',
  owner: userBob,
  ingredients: [f2i1, f2i2],
);

final Fridge fridge3 = Fridge(
  id: 'fridge_3',
  owner: userClara,
  ingredients: [f3i1, f3i2, f3i3, f3i4],
);

final List<Fridge> fridgesMock = [fridge1, fridge2, fridge3];

final Fridge fridgeMock = fridge1;