import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:partner_in_cook/core/network/api_client.dart';
import 'package:partner_in_cook/exceptions/api_exception.dart';
import 'package:partner_in_cook/exceptions/exception_handler.dart';
import 'package:partner_in_cook/model/api/user_stats.dart';

class UserStatsService {
  final ApiClient _api = Get.find<ApiClient>();

  Future<UserStats> getOwned() async {
    try {
      final response = await _api.get('/User/userStats');
      final data = response.data['data'] as Map<String, dynamic>;
      return UserStats.fromJson(data);
    } on DioException catch (e) {
      final error = handleDioException(e);
      throw ApiException(error.message, code: error.code);
    } catch (e) {
      throw ApiException('Erreur inattendue: $e');
    }
  }
}
