import 'dart:async';
import 'package:app_links/app_links.dart';
import 'package:get/get.dart';
import 'package:partner_in_cook/routes/app_pages.dart';

class DeepLinkController extends GetxController {
  late final AppLinks _appLinks;
  StreamSubscription<Uri>? _sub;

  @override
  void onInit() {
    _appLinks = AppLinks();
    _handleInitialLink();
    _listen();
    super.onInit();
  }

  Future<void> _handleInitialLink() async {
    final uri = await _appLinks.getInitialLink();
    if (uri != null) {
      _route(uri);
    }
  }

  void _listen() {
    _sub = _appLinks.uriLinkStream.listen(_route);
  }

  void _route(Uri uri) {
    if (uri.scheme != 'partnerincook') return;

    if (uri.pathSegments.isEmpty) return;

    switch (uri.host) {
      case 'pantry':
        _handlePantry(uri);
        break;

      case 'recipe-list':
        _handleRecipeList(uri);
        break;

      default:
        // deeplink inconnu → ignore ou home
        break;
    }
  }

  void _handlePantry(Uri uri) {
    final id = uri.pathSegments.last;
    Get.toNamed(Routes.pantryJoin, arguments: {'id': id});
  }

  void _handleRecipeList(Uri uri) {
    final id = uri.pathSegments.last;
    Get.toNamed(Routes.recipeListJoin, arguments: {'id': id});
  }

  @override
  void onClose() {
    _sub?.cancel();
    super.onClose();
  }
}
