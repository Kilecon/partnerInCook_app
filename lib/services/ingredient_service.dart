import 'package:dio/dio.dart';
import 'package:partner_in_cook/core/network/api_client.dart';
import 'package:partner_in_cook/exceptions/api_exception.dart';
import 'package:partner_in_cook/exceptions/exception_handler.dart';
import 'package:partner_in_cook/model/api/ingredient.dart';
import 'package:get/get.dart';

class IngredientService {
    final ApiClient _api = Get.find<ApiClient>();

  Future<List<Ingredient>> getAll() async {
    try {
      final response = await _api.get('/Ingredient/all');
      final dataList = response.data as List<dynamic>;
      return dataList.map((data) => Ingredient.fromJson(data as Map<String, dynamic>)).toList();
    } on DioException catch (e) {
      final error = handleDioException(e);
      throw ApiException(error.message, code: error.code);
    } catch (e) {
      throw ApiException('Erreur inattendue: $e');
    }
  }
}
