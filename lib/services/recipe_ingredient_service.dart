import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:partner_in_cook/core/network/api_client.dart';
import 'package:partner_in_cook/exceptions/api_exception.dart';
import 'package:partner_in_cook/exceptions/exception_handler.dart';
import 'package:partner_in_cook/model/api/recipe_ingredient.dart';
import 'package:partner_in_cook/model/form/create_recipe_ingredient_form.dart';

class RecipeIngredientService {
  final ApiClient _api = Get.find<ApiClient>();

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
  
  Future<RecipeIngredient> update(RecipeIngredientCreateRequest body,
  ) async {
    try {
      final response = await _api.put(
        '/RecipeIngredient',
        data: json.encode(body),
      );
      return RecipeIngredient.fromJson(response.data['data'] as Map<String, dynamic>);
    } on DioException catch (e) {
      final error = handleDioException(e);
      throw ApiException(error.message, code: error.code);
    } catch (e) {
      throw ApiException('Erreur inattendue: $e');
    }
  }

  Future<RecipeIngredient> getById(String recipeIngredientId) async {
    try {
      final response = await _api.get('/RecipeIngredient/$recipeIngredientId');
      final data = response.data['data'] as Map<String, dynamic>;
      return RecipeIngredient.fromJson(data);
    } on DioException catch (e) {
      final error = handleDioException(e);
      throw ApiException(error.message, code: error.code);
    } catch (e) {
      throw ApiException('Erreur inattendue: $e');
    }
  }

  Future<void> sync(String recipeId, List<CreateRecipeIngredient> formIngredients, List<RecipeIngredient> originalIngredients) async {

    for (var oldItem in originalIngredients) {
      if (!formIngredients.any((f) => f.id == oldItem.id)) {
        await _api.delete('/RecipeIngredient/${oldItem.id}');
      }
    }

    for (var formItem in formIngredients) {
      final data = {
        'ingredient_id': formItem.ingredient.id,
        'quantity': formItem.quantity,
        'recipe_id': recipeId,
      };

      if (formItem.id == null) {
        await create([RecipeIngredientCreateRequest.fromJson(data)]);
      } else {
        await _api.put('/RecipeIngredient/${formItem.id}', data: json.encode(data));
      }
    }
  }
}
