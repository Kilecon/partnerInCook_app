import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partner_in_cook/core/auth/auth_service.dart';
import 'package:partner_in_cook/core/deeplink/deep_link_controller.dart';
import 'package:partner_in_cook/core/network/api_client.dart';

import 'routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Get.put(ApiClient(), permanent: true);
  await Get.putAsync(() => AuthService().init(), permanent: true);

  // Deeplink controller global
  Get.put(DeepLinkController(), permanent: true);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Partner in cook',
      initialRoute: AppPages.initial,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
    );
  }
}
