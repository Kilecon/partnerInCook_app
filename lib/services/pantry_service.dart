import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:partner_in_cook/core/network/api_client.dart';
import 'package:partner_in_cook/exceptions/api_exception.dart';
import 'package:partner_in_cook/exceptions/exception_handler.dart';
import 'package:partner_in_cook/model/api/pantry.dart';

class PantryService {
  final ApiClient _api = Get.find<ApiClient>();

  /// Joindre un pantry existant via son ID
  Future<void> joined(String recipeListId) async {
    try {
      await _api.post('/Pantry/join/$recipeListId');
    } on DioException catch (e) {
      final error = handleDioException(e);
      throw ApiException(error.message, code: error.code);
    } catch (e) {
      throw ApiException('Erreur inattendue: $e');
    }
  }

  /// Récupérer tous les pantries
  Future<List<Pantry>> getAllOwned() async {
    try {
      final response = await _api.get('/Pantry/owned');
      final dataList = response.data['data'] as List<dynamic>;
      return dataList
          .map((data) => Pantry.fromJson(data as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      final error = handleDioException(e);
      throw ApiException(error.message, code: error.code);
    } catch (e) {
      throw ApiException('Erreur inattendue: $e');
    }
  }

  Future<List<Pantry>> getAllJoined() async {
    try {
      final response = await _api.get('/Pantry/joined');
      final dataList = response.data['data'] as List<dynamic>;
      return dataList
          .map((data) => Pantry.fromJson(data as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      final error = handleDioException(e);
      throw ApiException(error.message, code: error.code);
    } catch (e) {
      throw ApiException('Erreur inattendue: $e');
    }
  }

  Future<Pantry> getById(String id) async {
    try {
      final response = await _api.get('/Pantry/$id');
      return Pantry.fromJson(response.data['data'] as Map<String, dynamic>);
    } on DioException catch (e) {
      final error = handleDioException(e);
      throw ApiException(error.message, code: error.code);
    } catch (e) {
      throw ApiException('Erreur inattendue: $e');
    }
  }

  /// Créer un nouveau pantry
  Future<Pantry> create(Map<String, dynamic> body) async {
    try {
      final response = await _api.post('/Pantry', data: json.encode(body));

      return Pantry.fromJson(response.data['data'] as Map<String, dynamic>);
    } on DioException catch (e) {
      final error = handleDioException(e);
      throw ApiException(error.message, code: error.code);
    } catch (e) {
      throw ApiException('Erreur inattendue: $e');
    }
  }

  Future<void> leave(String pantryId) async {
    try {
      await _api.post('/Pantry/leave/$pantryId');
    } on DioException catch (e) {
      final error = handleDioException(e);
      throw ApiException(error.message, code: error.code);
    } catch (e) {
      throw ApiException('Erreur inattendue: $e');
    }
  }
}
