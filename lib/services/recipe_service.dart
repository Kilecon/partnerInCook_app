import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:partner_in_cook/common/config/constants/visibility_state_enum.dart';
import 'package:partner_in_cook/core/auth/auth_service.dart';
import 'package:partner_in_cook/core/network/api_client.dart';
import 'package:partner_in_cook/exceptions/api_exception.dart';
import 'package:partner_in_cook/exceptions/exception_handler.dart';
import 'package:partner_in_cook/model/api/light_recipe.dart';
import 'package:partner_in_cook/model/api/recipe.dart';
import 'package:partner_in_cook/model/form/create_recipe_form.dart';


class RecipeService {
  final ApiClient _api = Get.find<ApiClient>();

  Future<void> toggleFavorite(String recipeId, bool isFavorite) async {
    if (recipeId.isEmpty) {
      throw ApiException('ID de recette invalide');
    }
    if (isFavorite) {
      await like(recipeId);
    } else {
      await dislike(recipeId);
    }
  }

  /// Liker une recette
  Future<void> like(String recipeId) async {
    try {
      await _api.post('/Recipe/like/$recipeId');
    } on DioException catch (e) {
      final error = handleDioException(e);
      throw ApiException(error.message, code: error.code);
    } catch (e) {
      throw ApiException('Erreur inattendue: $e');
    }
  }

  /// Disliker une recette
  Future<void> dislike(String recipeId) async {
    try {
      await _api.post('/Recipe/dislike/$recipeId');
    } on DioException catch (e) {
      final error = handleDioException(e);
      throw ApiException(error.message, code: error.code);
    } catch (e) {
      throw ApiException('Erreur inattendue: $e');
    }
  }

  /// Récupérer toutes les recettes publiques
  Future<List<Recipe>> getAllPublic() async {
    try {
      final response = await _api.get('/Recipe/explore');
      final data = response.data as List;
      return data
          .map((json) => Recipe.fromJson(json as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      final error = handleDioException(e);
      throw ApiException(error.message, code: error.code);
    } catch (e) {
      throw ApiException('Erreur inattendue: $e');
    }
  }

  /// Récupérer les recettes possédées
  Future<List<LightRecipe>> getOwned() async {
    try {
      final response = await _api.get('/Recipe/owned');
      final data = response.data['data'] as List;
      return data
          .map((json) => LightRecipe.fromJson(json as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      final error = handleDioException(e);
      throw ApiException(error.message, code: error.code);
    } catch (e) {
      throw ApiException('Erreur inattendue: $e');
    }
  }

  /// Créer une nouvelle liste de recettes
  Future<Recipe> create(CreateRecipeForm form) async {
    try {
      final connectedUser = await AuthService.getUser();
      print("FOOOOO");
      print(form);

      final body = {
        'name': form.name,
        'description': form.description,
        'state': visibilityStateToJson(form.visibilityState),
        'author_id': connectedUser!.userId,
        "preparation_time": form.preparationTime,
        "rest_time": form.restTime,
        "cook_time": form.cookTime,
        "portions": form.portions,
        "tags_ids": form.tags.map((t) => t.id).toList(), 
        "utensils_ids": form.utensils.map((u) => u.id).toList(),
        if (form.imageUrl != null && form.imageUrl!.isNotEmpty)
          'pic_url': form.imageUrl,
      };

      final response = await _api.post('/Recipe', data: json.encode(body));
      return Recipe.fromJson(response.data['data'] as Map<String, dynamic>);
    } on DioException catch (e) {
      final error = handleDioException(e);
      throw ApiException(error.message, code: error.code);
    } catch (e) {
      throw ApiException('Erreur inattendue: $e');
    }
  }

  /// Supprimer une recette
  Future<void> delete(String recipeId) async {
    try {
      await _api.delete('/Recipe/$recipeId');
    } on DioException catch (e) {
      final error = handleDioException(e);
      throw ApiException(error.message, code: error.code);
    } catch (e) {
      throw ApiException('Erreur inattendue: $e');
    }
  }

  /// Mettre à jour une recette
  Future<void> update(String recipeId, Map<String, dynamic> body) async {
    try {
      await _api.put('/Recipe/$recipeId', data: json.encode(body));
    } on DioException catch (e) {
      final error = handleDioException(e);
      throw ApiException(error.message, code: error.code);
    } catch (e) {
      throw ApiException('Erreur inattendue: $e');
    }
  }

    /// Récupérer les recettes possédées
  Future<Recipe> getById(String recipeId) async {
    try {
      final response = await _api.get('/Recipe/$recipeId');
      final data = response.data['data'] as Map<String, dynamic>;
      return Recipe.fromJson(data);
    } on DioException catch (e) {
      final error = handleDioException(e);
      throw ApiException(error.message, code: error.code);
    } catch (e) {
      throw ApiException('Erreur inattendue: $e');
    }
  }
}
