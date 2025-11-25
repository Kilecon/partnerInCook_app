// import 'dart:convert';
// import 'dart:developer';
// import 'package:flutter/foundation.dart';
// import 'package:get/get_connect/http/src/multipart/multipart_file.dart';
// import 'package:get/get_connect/http/src/response/response.dart';
// import 'app_pref.dart';
//
// Client client = Client();
// String accessToken = '';
// Map<String, String> requestHeaders = {};
//
// class Constants {
//   static String baseUrl = '<API_URL>';
// }
//
// class HttpRemote {
//   HttpRemote._();
//
//   static final HttpRemote instance = HttpRemote._();
//
//   static Future<void> init() async {
//     accessToken = await AppPref.getToken() ?? '';
//     log('accessToken: $accessToken');
//     if (accessToken.isEmpty || accessToken == 'null') {
//       requestHeaders = {
//         'Content-Type': 'application/json',
//         "Accept": "application/json",
//       };
//     } else {
//       requestHeaders = {
//         'Accept': 'application/json',
//         'Content-Type': 'application/x-www-form-urlencoded',
//         'Authorization': 'Bearer $accessToken',
//       };
//     }
//   }
//
//   static Future<void> logOut(int statusCode) async {
//     if (statusCode == 401) {
//       await AppPref.logout();
//     }
//   }
//
//   static Future<Response?> get({
//     required String url,
//     Object? body,
//   }) {
//     return client.get(
//       Uri.parse(Constants.baseUrl + url),
//       headers: requestHeaders,
//     );
//   }
//
//   static Future<Response?> postNormal({
//     required String url,
//     Object? body,
//   }) {
//     return client.post(
//       Uri.parse(Constants.baseUrl + url),
//       headers: {
//         'Content-Type': 'application/json',
//         "Accept": "application/json",
//         'Authorization': 'Bearer $accessToken',
//       },
//       body: jsonEncode(body),
//     );
//   }
//
//   static Future<Response?> postMultipartFile({
//     required String url,
//     Map<String, String>? fields,
//     List<MultipartFile>? files,
//   }) async {
//     final uri = Uri.parse(Constants.baseUrl + url);
//     final request = MultipartRequest('POST', uri);
//     request.headers.addAll({
//       'accept': 'application/json',
//       'Authorization': 'Bearer $accessToken',
//     });
//
//     if (fields != null) {
//       request.fields.addAll(fields);
//     }
//
//     if (files != null) {
//       request.files.addAll(files);
//     }
//
//     debugPrint("postMultipartFile: ${request.fields}, files: ${files?.map((f) => f.filename).toList()}");
//
//     return Response.fromStream(await request.send());
//   }
//
//   static Future<Response?> post({
//     required String url,
//     Object? body,
//   }) {
//     return client.post(
//       Uri.parse(Constants.baseUrl + url),
//       headers: requestHeaders,
//       body: jsonEncode(body),
//     );
//   }
//
//   static Future<Response?> put({
//     required String url,
//     Object? body,
//   }) {
//     return client.put(
//       Uri.parse(Constants.baseUrl + url),
//       headers: requestHeaders,
//       body: jsonEncode(body),
//     );
//   }
//
//   static Future<Response?> delete({
//     required String url,
//     Object? body,
//   }) {
//     return client.delete(
//       Uri.parse(Constants.baseUrl + url),
//       headers: requestHeaders,
//       body: body == null ? null : jsonEncode(body),
//     );
//   }
//
//   static Future<Response?> patch({
//     required String url,
//     Object? body,
//   }) {
//     return client.patch(
//       Uri.parse(Constants.baseUrl + url),
//       headers: requestHeaders,
//       body: body == null ? null : jsonEncode(body),
//     );
//   }
// }