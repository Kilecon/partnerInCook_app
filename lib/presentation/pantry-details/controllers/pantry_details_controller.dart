import 'package:get/get.dart';
import 'package:partner_in_cook/component/pantry_details/pantry_share_dialog.dart';
import 'package:partner_in_cook/model/api/pantry.dart';
import 'package:partner_in_cook/services/pantry_service.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

class PantryDetailsController extends GetxController {
  final pantryApi = Get.find<PantryService>();

  late final String pantryId;
  var pantry = Rx<Pantry?>(null);

  QrImage? qrImage;
  String? fullInvitationLink;
  RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    pantryId = Get.arguments['id']!;
    _loadPantry();
  }

  Future<void> _loadPantry() async {
    try {
      final details = await pantryApi.getById(pantryId);
      pantry.value = details;
      // _generateQrCode();
    } catch (e) {
      pantry.value = null;
      fullInvitationLink = null;
    } finally {
      isLoading.value = false;
      update();
    }
  }

  void _generateQrCode() {
    fullInvitationLink = 'partnerincook://pantry/join/$pantryId';

    final qrCode = QrCode(5, QrErrorCorrectLevel.H)
      ..addData(fullInvitationLink!);

    qrImage = QrImage(qrCode);
  }

  void onShareTap() {
    Get.dialog(const PantryShareDialog());
  }
}
