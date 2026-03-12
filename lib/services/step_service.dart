import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:partner_in_cook/core/network/api_client.dart';
import 'package:partner_in_cook/exceptions/api_exception.dart';
import 'package:partner_in_cook/exceptions/exception_handler.dart';
import 'package:partner_in_cook/model/api/step.dart';

class StepService {
  final ApiClient _api = Get.find<ApiClient>();

  /// Créer un nouveau step
  Future<List<Step>> create(List<StepCreateRequest> body) async {
    try {
      final response = await _api.post('/Step', data: json.encode(body));

      return (response.data['data'] as List)
          .map((json) => Step.fromJson(json as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      final error = handleDioException(e);
      throw ApiException(error.message, code: error.code);
    } catch (e) {
      throw ApiException('Erreur inattendue: $e');
    }
  }

  Future<Step> update(StepCreateRequest body, String id
  ) async {
    try {
      final response = await _api.put(
        '/Step/$id',
        data: json.encode(body),
      );
      return Step.fromJson(response.data['data'] as Map<String, dynamic>);
    } on DioException catch (e) {
      final error = handleDioException(e);
      throw ApiException(error.message, code: error.code);
    } catch (e) {
      throw ApiException('Erreur inattendue: $e');
    }
  }

  
  Future<void> sync(String recipeId, List<StepCreateRequest> formSteps, List<Step> originalSteps) async {

    for (var oldItem in originalSteps) {
      if (!formSteps.any((f) => f.id == oldItem.id)) {
        await _api.delete('/Step/${oldItem.id}');
      }
    }
    for (var formItem in formSteps) {
      final data = {
        "description": formItem.description,
        "order": formItem.order,
        "recipe_id": recipeId,
      };

      if (formItem.id == null) {
        await create([StepCreateRequest.fromJson(data)]);
      } else {
        await update(StepCreateRequest.fromJson(data), formItem.id!);
      }
    }
  }
}
