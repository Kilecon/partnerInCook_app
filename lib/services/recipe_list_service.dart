import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:partner_in_cook/core/network/api_client.dart';
import 'package:partner_in_cook/exceptions/api_exception.dart';
import 'package:partner_in_cook/exceptions/exception_handler.dart';

class RecipeListService {
  final ApiClient _apiClient = ApiClient();

  /// Joindre une liste de recettes via son ID
  Future<void> joined(String recipeListId) async {
    try {
      await _apiClient.post('/api/recipe-list/join/$recipeListId');
    } on DioException catch (e) {
      final error = handleDioException(e);
      throw ApiException(error.message, code: error.code);
    } catch (e) {
      throw ApiException('Erreur inattendue: $e');
    }
  }

  /// Récupérer toutes les listes de recettes
  Future<List<dynamic>> getAll() async {
    try {
      final response = await _apiClient.get('/api/recipe-list');
      return response.data as List<dynamic>;
    } on DioException catch (e) {
      final error = handleDioException(e);
      throw ApiException(error.message, code: error.code);
    } catch (e) {
      throw ApiException('Erreur inattendue: $e');
    }
  }

  /// Créer une nouvelle liste de recettes
  Future<void> create(Map<String, dynamic> body) async {
    try {
      await _apiClient.post(
        '/api/recipe-list',
        data: json.encode(body),
      );
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
      await _apiClient.delete('/api/recipe-list/$recipeListId');
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
      await _apiClient.put(
        '/api/recipe-list/$recipeListId',
        data: json.encode(body),
      );
    } on DioException catch (e) {
      final error = handleDioException(e);
      throw ApiException(error.message, code: error.code);
    } catch (e) {
      throw ApiException('Erreur inattendue: $e');
    }
  }
}
