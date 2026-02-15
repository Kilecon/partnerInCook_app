import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import 'package:partner_in_cook/core/network/api_client.dart';
import 'package:partner_in_cook/exceptions/api_exception.dart';
import 'package:partner_in_cook/exceptions/exception_handler.dart';
import 'dart:io';

class UploadService {
  final ApiClient _api = Get.find<ApiClient>();

  /// Upload une image et retourne l'URL
  Future<String> uploadImage(File imageFile) async {
    try {
      // 1. Extraire les noms de fichiers
      String fullPath = imageFile.path;
      String fileNameWithExt = fullPath.split('/').last; // ex: "photo.jpg"
      String nameWithoutExt = fileNameWithExt.split('.').first; // ex: "photo"

      // 2. Préparer le FormData (Le nom de la clé 'File' doit correspondre au DTO C#)
      dio.FormData formData = dio.FormData.fromMap({
        'File': await dio.MultipartFile.fromFile(
          fullPath,
          filename: fileNameWithExt,
        ),
      });

      // 3. Exécuter la requête
      final response = await _api.post(
        '/Images/upload',
        data: formData,
        queryParameters: {
          'filename': nameWithoutExt, // Va dans l'URL ?filename=photo
        },
      );

      // 4. Récupérer le nom de l'objet créé (basé sur ton ImageUploadResponse C#)
      // response.data est déjà un Map grâce à Dio
      if (response.statusCode == 200) {
        return response.data['url'] as String;
      } else {
        throw ApiException('Erreur serveur: ${response.statusCode}');
      }
    } on dio.DioException catch (e) {
      // Utilise ton gestionnaire d'exception habituel
      final error = handleDioException(e);
      throw ApiException(error.message, code: error.code);
    } catch (e) {
      throw ApiException('Erreur lors de l\'upload de l\'image: $e');
    }
  }
}
