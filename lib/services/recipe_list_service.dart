import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:partner_in_cook/common/config/constants/visibility_state_enum.dart';
import 'package:partner_in_cook/core/auth/auth_service.dart';
import 'package:partner_in_cook/core/network/api_client.dart';
import 'package:partner_in_cook/exceptions/api_exception.dart';
import 'package:partner_in_cook/exceptions/exception_handler.dart';
import 'package:partner_in_cook/model/api/recipe_list.dart';
import 'package:partner_in_cook/model/form/create_recipe_list_form.dart';

class RecipeListService {
  final ApiClient _api = Get.find<ApiClient>();

  /// Joindre une liste de recettes via son ID
  Future<void> joined(String recipeListId) async {
    try {
      await _api.post('/RecipeList/join/$recipeListId');
    } on DioException catch (e) {
      final error = handleDioException(e);
      throw ApiException(error.message, code: error.code);
    } catch (e) {
      throw ApiException('Erreur inattendue: $e');
    }
  }

  /// Quitter une liste de recettes via son ID
  Future<void> leave(String recipeListId) async {
    try {
      await _api.post('/RecipeList/leave/$recipeListId');
    } on DioException catch (e) {
      final error = handleDioException(e);
      throw ApiException(error.message, code: error.code);
    } catch (e) {
      throw ApiException('Erreur inattendue: $e');
    }
  }

  /// Liker une liste de recettes
  Future<void> like(String recipeListId) async {
    try {
      await _api.post('/RecipeList/like/$recipeListId');
    } on DioException catch (e) {
      final error = handleDioException(e);
      throw ApiException(error.message, code: error.code);
    } catch (e) {
      throw ApiException('Erreur inattendue: $e');
    }
  }

  /// Disliker une liste de recettes
  Future<void> dislike(String recipeListId) async {
    try {
      await _api.post('/RecipeList/dislike/$recipeListId');
    } on DioException catch (e) {
      final error = handleDioException(e);
      throw ApiException(error.message, code: error.code);
    } catch (e) {
      throw ApiException('Erreur inattendue: $e');
    }
  }

  /// Récupérer toutes les listes de recettes publiques
  Future<List<RecipeList>> getAllPublic() async {
    try {
      final response = await _api.get('/RecipeList/public');
      final data = response.data['data'] as List;
      return data
          .map((json) => RecipeList.fromJson(json as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      final error = handleDioException(e);
      throw ApiException(error.message, code: error.code);
    } catch (e) {
      throw ApiException('Erreur inattendue: $e');
    }
  }

  /// Récupérer les listes de recettes possédées
  Future<List<RecipeList>> getOwned() async {
    try {
      final response = await _api.get('/RecipeList/owned');
      final data = response.data['data'] as List;
      return data
          .map((json) => RecipeList.fromJson(json as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      final error = handleDioException(e);
      throw ApiException(error.message, code: error.code);
    } catch (e) {
      throw ApiException('Erreur inattendue: $e');
    }
  }

  /// Récupérer les listes de recettes rejointes
  Future<List<RecipeList>> getJoined() async {
    try {
      final response = await _api.get('/RecipeList/joined');
      final data = response.data['data'] as List;
      return data
          .map((json) => RecipeList.fromJson(json as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      final error = handleDioException(e);
      throw ApiException(error.message, code: error.code);
    } catch (e) {
      throw ApiException('Erreur inattendue: $e');
    }
  }

  /// Créer une nouvelle liste de recettes
  Future<RecipeList> create(CreateRecipeListForm form) async {
    try {
      final connectedUser = await AuthService.getUser();

      final body = {
        'name': form.name,
        'is_favorite': false,
        'description': form.description,
        'state': visibilityStateToJson(form.visibilityState),
        'author_id': connectedUser!.userId,
        if (form.imageUrl != null && form.imageUrl!.isNotEmpty)
          'pic_url': form.imageUrl,
      };

      final response = await _api.post('/RecipeList', data: json.encode(body));
      return RecipeList.fromJson(response.data['data'] as Map<String, dynamic>);
    } on DioException catch (e) {
      final error = handleDioException(e);
      throw ApiException(error.message, code: error.code);
    } catch (e) {
      throw ApiException('Erreur inattendue: $e');
    }
  }

  /// Supprimer une liste de recettes
  Future<void> delete(String recipeListId) async {
    try {
      await _api.delete('/RecipeList/$recipeListId');
    } on DioException catch (e) {
      final error = handleDioException(e);
      throw ApiException(error.message, code: error.code);
    } catch (e) {
      throw ApiException('Erreur inattendue: $e');
    }
  }

  /// Mettre à jour une liste de recettes
  Future<void> update(String recipeListId, Map<String, dynamic> body) async {
    try {
      await _api.put('/RecipeList/$recipeListId', data: json.encode(body));
    } on DioException catch (e) {
      final error = handleDioException(e);
      throw ApiException(error.message, code: error.code);
    } catch (e) {
      throw ApiException('Erreur inattendue: $e');
    }
  }

  Future<RecipeList> getById(String recipeListId) async {
    try {
      final response = await _api.get('/RecipeList/$recipeListId');
      return RecipeList.fromJson(response.data['data'] as Map<String, dynamic>);
    } on DioException catch (e) {
      final error = handleDioException(e);
      throw ApiException(error.message, code: error.code);
    } catch (e) {
      throw ApiException('Erreur inattendue: $e');
    }
  }
}
