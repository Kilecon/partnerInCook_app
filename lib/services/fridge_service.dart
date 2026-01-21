import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:partner_in_cook/core/network/api_client.dart';
import 'package:partner_in_cook/exceptions/api_exception.dart';
import 'package:partner_in_cook/exceptions/exception_handler.dart';
import 'package:partner_in_cook/model/api/fridge.dart';

class FridgeService {
  final ApiClient _api = Get.find<ApiClient>();

    Future<List<Fridge>> getAllJoined() async {
    try {
      final response = await _api.get('/Fridge/joined');

      // Retourne la liste brute ou convertie en model
      return response.data as List<Fridge>;
    } on DioException catch (e) {
      final error = handleDioException(e);
      throw ApiException(error.message, code: error.code);
    } catch (e) {
      throw ApiException('Erreur inattendue: $e');
    }
  }


    Future<Fridge> getById(String id) async {
    try {
      final response = await _api.get('/Fridge/$id');
      return response.data;
    } on DioException catch (e) {
      final error = handleDioException(e);
      throw ApiException(error.message, code: error.code);
    } catch (e) {
      throw ApiException('Erreur inattendue: $e');
    }
  }

  /// Créer un nouveau fridge
  Future<Fridge> create(Map<String, dynamic> body) async {
    try {
      final response = await _api.post(
        '/Fridge',
        data: json.encode(body),
      );
      return response.data;
    } on DioException catch (e) {
      final error = handleDioException(e);
      throw ApiException(error.message, code: error.code);
    } catch (e) {
      throw ApiException('Erreur inattendue: $e');
    }
  }
}
