import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:partner_in_cook/core/network/api_client.dart';
import 'package:partner_in_cook/exceptions/api_exception.dart';
import 'package:partner_in_cook/exceptions/exception_handler.dart';
import 'package:partner_in_cook/model/api/notation.dart';

class NotationService {
  final ApiClient _api = Get.find<ApiClient>();

  /// Créer une nouvelle notation
  Future<Notation> create(NotationCreateRequest body) async {
    try {
      final response = await _api.post('/Notation', data: json.encode(body));
      return Notation.fromJson(response.data['data'] as Map<String, dynamic>);
    } on DioException catch (e) {
      final error = handleDioException(e);
      throw ApiException(error.message, code: error.code);
    } catch (e) {
      throw ApiException('Erreur inattendue: $e');
    }
  }

  /// Créer une nouvelle notation
  Future<Notation> update(NotationCreateRequest body, String id) async {
    try {
      final response = await _api.put('/Notation/$id', data: json.encode(body));
      return Notation.fromJson(response.data['data'] as Map<String, dynamic>);
    } on DioException catch (e) {
      final error = handleDioException(e);
      throw ApiException(error.message, code: error.code);
    } catch (e) {
      throw ApiException('Erreur inattendue: $e');
    }
  }

  // récupérer la notation de l'utilisateur connecté pour une recette donnée
  Future<Notation> getUserNotationForRecipe(String recipeId) async {
    try {
      final response = await _api.get('/Notation/getMyNotation/$recipeId');
      return Notation.fromJson(response.data['data'] as Map<String, dynamic>);
    } on DioException catch (e) {
      final error = handleDioException(e);
      throw ApiException(error.message, code: error.code);
    } catch (e) {
      if (e is ApiException && e.code == 404) {
        return Notation(
          id: '',
          recipeId: recipeId,
          userId: '',
          notation: 0,
        );
      }
      throw ApiException('Erreur inattendue: $e');
    }
  }
}
