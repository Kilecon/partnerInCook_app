import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partner_in_cook/component/widgets/app_dialog.dart';
import 'package:partner_in_cook/presentation/pantry-details/controllers/pantry_details_controller.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

class PantryShareDialog extends StatelessWidget {
  const PantryShareDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AppDialog(
      title: 'Partager mon garde-manger',
      child: GetBuilder<PantryDetailsController>(
        builder: (controller) {
          if (controller.isLoading.value || controller.qrImage == null) {
            return const Padding(
              padding: EdgeInsets.all(24),
              child: Center(child: CircularProgressIndicator()),
            );
          }

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 120,
                  width: 120,
                  child: PrettyQrView(qrImage: controller.qrImage!),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Scannez pour rejoindre le garde-manger',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () {
                    Get.back(
                      result: controller.fullInvitationLink,
                    );
                  },
                  child: const Text('Copier le lien'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
