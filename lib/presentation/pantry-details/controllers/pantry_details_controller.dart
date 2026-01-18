import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partner_in_cook/common/config/constants/app_colors.dart';
import 'package:partner_in_cook/component/widgets/app_dialog.dart';

class PantryDetailsController extends GetxController {

  Future<Map<String, String>?> onShareTap(BuildContext context) {

    return showDialog<Map<String, String>>(
      context: context,
      builder: (ctx) {
        return AppDialog(
          title: 'Partager mon garde-manger',
          footer: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextButton(
                style: TextButton.styleFrom(foregroundColor: AppColors.black),
                onPressed: () => Navigator.of(ctx).pop(),
                child: const Text('Annuler'),
              ),
              const SizedBox(width: 8),
              TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.primaryOrange,
                ),
                onPressed: () {
                  
                },
                child: const Text('Partager'),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 20,
            children: [
            ],
          ),
        );
      },
    );
  }
}
