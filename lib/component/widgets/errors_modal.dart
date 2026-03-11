import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partner_in_cook/common/config/constants/app_colors.dart';
import 'package:partner_in_cook/component/widgets/app_dialog.dart';
import 'package:partner_in_cook/component/widgets/custom_button.dart';
import 'package:partner_in_cook/model/form/field_error.dart';

class ErrorsModal extends StatelessWidget {
  final List<FieldError> errors;
  const ErrorsModal({super.key, required this.errors});

  @override
  Widget build(BuildContext context) {
    return AppDialog(
      showBorder: true,
      borderColor: Colors.red,
      backgroundColor: AppColors.background,
      titleStyle: TextStyle(
        color: Colors.red[800],
        fontWeight: FontWeight.w700,
        fontSize: 20,
      ),
      title: 'Erreurs de validation',
      footer: CustomButton(
        hasBorder: true,
        borderColor: Colors.red,
        textColor: Colors.red,
        backgroundColor: AppColors.lightRed,
        name: 'Fermer',
        onClick: () => Get.back(),
      ),
      child: SizedBox(
        height: 220,
        child: errors.isEmpty
            ? const Center(child: Text('Aucune erreur'))
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: errors
                      .map((e) => ListTile(
                            contentPadding: EdgeInsets.zero,
                            title: Text(e.message, style: const TextStyle(fontWeight: FontWeight.w600)),
                            subtitle: Text(e.field),
                          ))
                      .toList(),
                ),
              ),
      ),
    );
  }
}