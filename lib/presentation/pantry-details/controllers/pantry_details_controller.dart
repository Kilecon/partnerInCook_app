import 'package:get/get.dart';
import 'package:partner_in_cook/component/widgets/qr_share_dialog.dart';
import 'package:partner_in_cook/model/api/pantry.dart';
import 'package:partner_in_cook/services/pantry_service.dart';
import 'package:partner_in_cook/utils/qr_code.dart';
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
      try {
        fullInvitationLink = 'partnerincook://pantry/join/$pantryId';
        qrImage = generateQrCode(fullInvitationLink!);
      } catch (e) {
        print("QR Code Error: $e");
      }
    } catch (e) {
      pantry.value = null;
    } finally {
      isLoading.value = false;
      update();
    }
  }

  void onShareTap() {
    if (fullInvitationLink == null) return;

    Get.dialog(
      QrShareDialog(
        title: 'Partager mon garde-manger',
        description:
            'Invitez vos amis en scannant ce code ou en copiant le lien ci-dessous.',
        data: fullInvitationLink!,
      ),
    );
  }
}
