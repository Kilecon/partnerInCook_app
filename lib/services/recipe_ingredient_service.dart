import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:partner_in_cook/core/network/api_client.dart';
import 'package:partner_in_cook/exceptions/api_exception.dart';
import 'package:partner_in_cook/exceptions/exception_handler.dart';
import 'package:partner_in_cook/model/api/recipe_ingredient.dart';

class RecipeIngredientService {
  final ApiClient _api = Get.find<ApiClient>();

  /// Créer un nouveau recipe ingredient
  Future<List<RecipeIngredient>> create(
    List<RecipeIngredientCreateRequest> body,
  ) async {
    try {
      final response = await _api.post(
        '/RecipeIngredient',
        data: json.encode(body),
      );

      return (response.data['data'] as List)
          .map(
            (json) => RecipeIngredient.fromJson(json as Map<String, dynamic>),
          )
          .toList();
    } on DioException catch (e) {
      final error = handleDioException(e);
      throw ApiException(error.message, code: error.code);
    } catch (e) {
      throw ApiException('Erreur inattendue: $e');
    }
  }
}
