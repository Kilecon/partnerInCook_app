import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:partner_in_cook/core/network/api_client.dart';
import 'package:partner_in_cook/exceptions/api_exception.dart';
import 'package:partner_in_cook/exceptions/exception_handler.dart';
import 'package:partner_in_cook/model/api/pantry.dart';

class PantryService {
  final ApiClient _apiClient = ApiClient();

  /// Joindre un pantry existant via son ID
  Future<void> joined(String recipeListId) async {
    try {
      final response = await _apiClient.post(
        '/api/pantry/join/$recipeListId',
      );

      // Ici, si l'API renvoie un payload, tu peux le parser :
      // final data = response.data as Map<String, dynamic>;

    } on DioException catch (e) {
      final error = handleDioException(e);
      throw ApiException(error.message, code: error.code);
    } catch (e) {
      throw ApiException('Erreur inattendue: $e');
    }
  }

  /// Récupérer tous les pantries
  Future<List<dynamic>> getAll() async {
    try {
      final response = await _apiClient.get('/api/pantry');

      // Retourne la liste brute ou convertie en model
      return response.data as List<dynamic>;
    } on DioException catch (e) {
      final error = handleDioException(e);
      throw ApiException(error.message, code: error.code);
    } catch (e) {
      throw ApiException('Erreur inattendue: $e');
    }
  }

    Future<Pantry> getById(String id) async {
    try {
      final response = await _apiClient.get('/api/recipe-list/$id');
      return response.data;
    } on DioException catch (e) {
      final error = handleDioException(e);
      throw ApiException(error.message, code: error.code);
    } catch (e) {
      throw ApiException('Erreur inattendue: $e');
    }
  }

  /// Créer un nouveau pantry
  Future<void> create(Map<String, dynamic> body) async {
    try {
      await _apiClient.post(
        '/api/pantry',
        data: json.encode(body),
      );
    } on DioException catch (e) {
      final error = handleDioException(e);
      throw ApiException(error.message, code: error.code);
    } catch (e) {
      throw ApiException('Erreur inattendue: $e');
    }
  }

  Future<void> leave(String pantryId) async {
    try {
      await _apiClient.post(
        '/api/pantry/leave/$pantryId',
      );
    } on DioException catch (e) {
      final error = handleDioException(e);
      throw ApiException(error.message, code: error.code);
    } catch (e) {
      throw ApiException('Erreur inattendue: $e');
    }
  }
}
