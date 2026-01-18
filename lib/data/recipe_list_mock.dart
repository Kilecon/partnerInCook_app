import 'package:partner_in_cook/common/config/constants/visibility_state_enum.dart';
import 'package:partner_in_cook/model/api/light_recipe_list.dart';
import 'package:partner_in_cook/model/api/light_user.dart';
import 'package:partner_in_cook/model/api/recipe_list.dart';

final List<RecipeList> mockRecipeLists = [
  RecipeList(
    isFavorite: false,
    pictureUrl:
        'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Ftse1.mm.bing.net%2Fth%2Fid%2FOIP.S83BviAlhkAMjT0W6BLdogHaE8%3Fpid%3DApi&f=1&ipt=64aa6ffea2f555fee2b9aae3336fe177a8dff739ee6d8c794d34bd76af59aab4&ipo=images',
    id: '1',
    name: 'Recettes Italiennes',
    description: 'Mes meilleures recettes italiennes à partager en famille',
    visibilityState: VisibilityStateEnum.publicState,
    author: LightUser(
      id: 'user1',
      username: 'ChefMario',
      profilePictureUrl: 'https://s3.mizury.fr/partnerincook/chef.png',
    ),
    recipes: [
       LightRecipe(
        id: 'recipe1',
        name: 'Pasta Carbonara',
        globalTime: 30,
        isFavorite: true,
        pictureUrl:
            'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Ftse1.mm.bing.net%2Fth%2Fid%2FOIP.S83BviAlhkAMjT0W6BLdogHaE8%3Fpid%3DApi&f=1&ipt=64aa6ffea2f555fee2b9aae3336fe177a8dff739ee6d8c794d34bd76af59aab4&ipo=images',
        author: LightUser(
          id: 'user1',
          username: 'ChefMario',
          profilePictureUrl: 'https://s3.mizury.fr/partnerincook/chef.png',
        ),
        notationsCount: 125,
        averageNotation: 4.8,
      ),
       LightRecipe(
        id: 'recipe1',
        name: 'Pasta Carbonara',
        globalTime: 30,
        isFavorite: true,
        pictureUrl:
            'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Ftse1.mm.bing.net%2Fth%2Fid%2FOIP.S83BviAlhkAMjT0W6BLdogHaE8%3Fpid%3DApi&f=1&ipt=64aa6ffea2f555fee2b9aae3336fe177a8dff739ee6d8c794d34bd76af59aab4&ipo=images',
        author: LightUser(
          id: 'user1',
          username: 'ChefMario',
          profilePictureUrl: 'https://s3.mizury.fr/partnerincook/chef.png',
        ),
        notationsCount: 125,
        averageNotation: 4.8,
      ),
       LightRecipe(
        id: 'recipe1',
        name: 'Pasta Carbonara',
        globalTime: 30,
        isFavorite: true,
        pictureUrl:
            'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Ftse1.mm.bing.net%2Fth%2Fid%2FOIP.S83BviAlhkAMjT0W6BLdogHaE8%3Fpid%3DApi&f=1&ipt=64aa6ffea2f555fee2b9aae3336fe177a8dff739ee6d8c794d34bd76af59aab4&ipo=images',
        author: LightUser(
          id: 'user1',
          username: 'ChefMario',
          profilePictureUrl: 'https://s3.mizury.fr/partnerincook/chef.png',
        ),
        notationsCount: 125,
        averageNotation: 4.8,
      ),
      LightRecipe(
        id: 'recipe1',
        name: 'Pasta Carbonara',
        globalTime: 30,
        isFavorite: true,
        pictureUrl:
            'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Ftse1.mm.bing.net%2Fth%2Fid%2FOIP.S83BviAlhkAMjT0W6BLdogHaE8%3Fpid%3DApi&f=1&ipt=64aa6ffea2f555fee2b9aae3336fe177a8dff739ee6d8c794d34bd76af59aab4&ipo=images',
        author: LightUser(
          id: 'user1',
          username: 'ChefMario',
          profilePictureUrl: 'https://s3.mizury.fr/partnerincook/chef.png',
        ),
        notationsCount: 125,
        averageNotation: 4.8,
      ),
       LightRecipe(
        id: 'recipe1',
        name: 'Pasta Carbonara',
        globalTime: 30,
        isFavorite: true,
        pictureUrl:
            'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Ftse1.mm.bing.net%2Fth%2Fid%2FOIP.S83BviAlhkAMjT0W6BLdogHaE8%3Fpid%3DApi&f=1&ipt=64aa6ffea2f555fee2b9aae3336fe177a8dff739ee6d8c794d34bd76af59aab4&ipo=images',
        author: LightUser(
          id: 'user1',
          username: 'ChefMario',
          profilePictureUrl: 'https://s3.mizury.fr/partnerincook/chef.png',
        ),
        notationsCount: 125,
        averageNotation: 4.8,
      ),
       LightRecipe(
        id: 'recipe1',
        name: 'Pasta Carbonara',
        globalTime: 30,
        isFavorite: true,
        pictureUrl:
            'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Ftse1.mm.bing.net%2Fth%2Fid%2FOIP.S83BviAlhkAMjT0W6BLdogHaE8%3Fpid%3DApi&f=1&ipt=64aa6ffea2f555fee2b9aae3336fe177a8dff739ee6d8c794d34bd76af59aab4&ipo=images',
        author: LightUser(
          id: 'user1',
          username: 'ChefMario',
          profilePictureUrl: 'https://s3.mizury.fr/partnerincook/chef.png',
        ),
        notationsCount: 125,
        averageNotation: 4.8,
      ),
       LightRecipe(
        id: 'recipe1',
        name: 'Pasta Carbonara',
        globalTime: 30,
        isFavorite: true,
        pictureUrl:
            'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Ftse1.mm.bing.net%2Fth%2Fid%2FOIP.S83BviAlhkAMjT0W6BLdogHaE8%3Fpid%3DApi&f=1&ipt=64aa6ffea2f555fee2b9aae3336fe177a8dff739ee6d8c794d34bd76af59aab4&ipo=images',
        author: LightUser(
          id: 'user1',
          username: 'ChefMario',
          profilePictureUrl: 'https://s3.mizury.fr/partnerincook/chef.png',
        ),
        notationsCount: 125,
        averageNotation: 4.8,
      ),
       LightRecipe(
        id: 'recipe1',
        name: 'Pasta Carbonara',
        globalTime: 30,
        isFavorite: true,
        pictureUrl:
            'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Ftse1.mm.bing.net%2Fth%2Fid%2FOIP.S83BviAlhkAMjT0W6BLdogHaE8%3Fpid%3DApi&f=1&ipt=64aa6ffea2f555fee2b9aae3336fe177a8dff739ee6d8c794d34bd76af59aab4&ipo=images',
        author: LightUser(
          id: 'user1',
          username: 'ChefMario',
          profilePictureUrl: 'https://s3.mizury.fr/partnerincook/chef.png',
        ),
        notationsCount: 125,
        averageNotation: 4.8,
      ),
       LightRecipe(
        id: 'recipe1',
        name: 'Pasta Carbonara',
        globalTime: 30,
        isFavorite: true,
        pictureUrl:
            'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Ftse1.mm.bing.net%2Fth%2Fid%2FOIP.S83BviAlhkAMjT0W6BLdogHaE8%3Fpid%3DApi&f=1&ipt=64aa6ffea2f555fee2b9aae3336fe177a8dff739ee6d8c794d34bd76af59aab4&ipo=images',
        author: LightUser(
          id: 'user1',
          username: 'ChefMario',
          profilePictureUrl: 'https://s3.mizury.fr/partnerincook/chef.png',
        ),
        notationsCount: 125,
        averageNotation: 4.8,
      ),
       LightRecipe(
        id: 'recipe1',
        name: 'Pasta Carbonara',
        globalTime: 30,
        isFavorite: true,
        pictureUrl:
            'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Ftse1.mm.bing.net%2Fth%2Fid%2FOIP.S83BviAlhkAMjT0W6BLdogHaE8%3Fpid%3DApi&f=1&ipt=64aa6ffea2f555fee2b9aae3336fe177a8dff739ee6d8c794d34bd76af59aab4&ipo=images',
        author: LightUser(
          id: 'user1',
          username: 'ChefMario',
          profilePictureUrl: 'https://s3.mizury.fr/partnerincook/chef.png',
        ),
        notationsCount: 125,
        averageNotation: 4.8,
      ),
      LightRecipe(
        id: 'recipe1',
        name: 'Pasta Carbonara',
        globalTime: 30,
        isFavorite: true,
        pictureUrl:
            'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Ftse1.mm.bing.net%2Fth%2Fid%2FOIP.S83BviAlhkAMjT0W6BLdogHaE8%3Fpid%3DApi&f=1&ipt=64aa6ffea2f555fee2b9aae3336fe177a8dff739ee6d8c794d34bd76af59aab4&ipo=images',
        author: LightUser(
          id: 'user1',
          username: 'ChefMario',
          profilePictureUrl: 'https://s3.mizury.fr/partnerincook/chef.png',
        ),
        notationsCount: 125,
        averageNotation: 4.8,
      ),
      LightRecipe(
        id: 'recipe1',
        name: 'Pasta Carbonara',
        globalTime: 30,
        isFavorite: true,
        pictureUrl:
            'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Ftse1.mm.bing.net%2Fth%2Fid%2FOIP.S83BviAlhkAMjT0W6BLdogHaE8%3Fpid%3DApi&f=1&ipt=64aa6ffea2f555fee2b9aae3336fe177a8dff739ee6d8c794d34bd76af59aab4&ipo=images',
        author: LightUser(
          id: 'user1',
          username: 'ChefMario',
          profilePictureUrl: 'https://s3.mizury.fr/partnerincook/chef.png',
        ),
        notationsCount: 125,
        averageNotation: 4.8,
      ),
      LightRecipe(
        id: 'recipe2',
        name: 'Tiramisu',
        globalTime: 45,
        isFavorite: true,
        pictureUrl:
            'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Ftse1.mm.bing.net%2Fth%2Fid%2FOIP.S83BviAlhkAMjT0W6BLdogHaE8%3Fpid%3DApi&f=1&ipt=64aa6ffea2f555fee2b9aae3336fe177a8dff739ee6d8c794d34bd76af59aab4&ipo=images',
        author: LightUser(
          id: 'user1',
          username: 'ChefMario',
          profilePictureUrl: 'https://s3.mizury.fr/partnerincook/chef.png',
        ),
        notationsCount: 98,
        averageNotation: 4.9,
      ),
      LightRecipe(
        id: 'recipe3',
        name: 'Pizza Margherita',
        globalTime: 60,
        isFavorite: false,
        pictureUrl:
            'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Ftse1.mm.bing.net%2Fth%2Fid%2FOIP.S83BviAlhkAMjT0W6BLdogHaE8%3Fpid%3DApi&f=1&ipt=64aa6ffea2f555fee2b9aae3336fe177a8dff739ee6d8c794d34bd76af59aab4&ipo=images',
        author: LightUser(
          id: 'user2',
          username: 'NonnaMaria',
          profilePictureUrl: 'https://example.com/profiles/maria.jpg',
        ),
        notationsCount: 210,
        averageNotation: 4.7,
      ),
    ],
    members: [
      LightUser(
        id: 'user1',
        username: 'ChefMario',
        profilePictureUrl: 'https://s3.mizury.fr/partnerincook/chef.png',
      ),
      LightUser(
        id: 'user3',
        username: 'Sophie',
        profilePictureUrl: 'https://s3.mizury.fr/partnerincook/chef.png',
      ),
      LightUser(id: 'user4', username: 'Pierre'),
    ],
  ),
  RecipeList(
    isFavorite: false,
    pictureUrl:
        "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Ftse1.mm.bing.net%2Fth%2Fid%2FOIP.S83BviAlhkAMjT0W6BLdogHaE8%3Fpid%3DApi&f=1&ipt=64aa6ffea2f555fee2b9aae3336fe177a8dff739ee6d8c794d34bd76af59aab4&ipo=images",
    id: '2',
    name: 'Desserts Gourmands',
    description: 'Une collection de desserts pour les grandes occasions',
    visibilityState: VisibilityStateEnum.privateState,
    author: LightUser(
      id: 'user5',
      username: 'PatissierLucas',
      profilePictureUrl: 'https://s3.mizury.fr/partnerincook/chef.png',
    ),
    recipes: [
      LightRecipe(
        id: 'recipe4',
        name: 'Tarte au Citron',
        globalTime: 90,
        isFavorite: true,
        pictureUrl: 'https://example.com/recipes/lemon-tart.jpg',
        author: LightUser(
          id: 'user5',
          username: 'PatissierLucas',
          profilePictureUrl: 'https://s3.mizury.fr/partnerincook/chef.png',
        ),
        notationsCount: 67,
        averageNotation: 4.6,
      ),
      LightRecipe(
        id: 'recipe5',
        name: 'Fondant au Chocolat',
        globalTime: 40,
        isFavorite: true,
        pictureUrl:
            'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Ftse1.mm.bing.net%2Fth%2Fid%2FOIP.S83BviAlhkAMjT0W6BLdogHaE8%3Fpid%3DApi&f=1&ipt=64aa6ffea2f555fee2b9aae3336fe177a8dff739ee6d8c794d34bd76af59aab4&ipo=images',
        author: LightUser(
          id: 'user5',
          username: 'PatissierLucas',
          profilePictureUrl: 'https://s3.mizury.fr/partnerincook/chef.png',
        ),
        notationsCount: 143,
        averageNotation: 4.9,
      ),
    ],
    members: [
      LightUser(
        id: 'user5',
        username: 'PatissierLucas',
        profilePictureUrl: 'https://s3.mizury.fr/partnerincook/chef.png',
      ),
      LightUser(
        id: 'user6',
        username: 'Emma',
        profilePictureUrl: 'https://s3.mizury.fr/partnerincook/chef.png',
      ),
    ],
  ),
  RecipeList(
    isFavorite: false,
    id: '3',
    name: 'Cuisine Rapide',
    visibilityState: VisibilityStateEnum.publicState,
    author: LightUser(id: 'user7', username: 'QuickCook'),
    recipes: [
      LightRecipe(
        id: 'recipe6',
        name: 'Salade César',
        globalTime: 15,
        isFavorite: false,
        pictureUrl:
            'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Ftse1.mm.bing.net%2Fth%2Fid%2FOIP.S83BviAlhkAMjT0W6BLdogHaE8%3Fpid%3DApi&f=1&ipt=64aa6ffea2f555fee2b9aae3336fe177a8dff739ee6d8c794d34bd76af59aab4&ipo=images',
        author: LightUser(id: 'user7', username: 'QuickCook'),
        notationsCount: 45,
        averageNotation: 4.2,
      ),
      LightRecipe(
        id: 'recipe7',
        name: 'Omelette aux Champignons',
        globalTime: 20,
        isFavorite: true,
        author: LightUser(id: 'user7', username: 'QuickCook'),
        notationsCount: 32,
        averageNotation: 4.4,
      ),
    ],
    members: [LightUser(id: 'user7', username: 'QuickCook')],
  ),
  RecipeList(
    isFavorite: true,
    id: '4',
    name: 'Cuisine du Monde',
    description: 'Un voyage culinaire à travers les continents',
    visibilityState: VisibilityStateEnum.publicState,
    author: LightUser(
      id: 'user8',
      username: 'GlobalChef',
      profilePictureUrl: 'https://picsum.photos/seed/marie/100',
    ),
    recipes: [],
    members: [
      LightUser(
        id: 'user8',
        username: 'GlobalChef',
        profilePictureUrl: 'https://picsum.photos/seed/marie/100',
      ),
      LightUser(
        id: 'user9',
        username: 'TravelFoodie',
        profilePictureUrl: 'https://picsum.photos/seed/marie/100',
      ),
      LightUser(id: 'user10', username: 'CuriousEater'),
    ],
    pictureUrl: 'https://loremflickr.com/1280/720',
  ),
];
