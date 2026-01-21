import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:partner_in_cook/core/network/api_client.dart';
import 'package:partner_in_cook/exceptions/api_exception.dart';
import 'package:partner_in_cook/exceptions/exception_handler.dart';
import 'package:partner_in_cook/model/api/recipe.dart';

class RecipeService {
  final ApiClient _api = Get.find<ApiClient>();

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
      final response = await _api.get('/Recipe/public');
      final data = response.data['data'] as List;
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
  Future<List<Recipe>> getOwned() async {
    try {
      final response = await _api.get('/Recipe/owned');
      final data = response.data['data'] as List;
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

  /// Créer une nouvelle recette
  Future<Recipe> create(Map<String, dynamic> body) async {
    try {
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
}
