import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:partner_in_cook/common/config/constants/app_colors.dart';
import 'package:partner_in_cook/component/widgets/app_dialog.dart';
import 'package:partner_in_cook/component/widgets/image-selector.dart';

class EditProfileDialog extends StatefulWidget {
  final String initialUsername;
  final String initialEmail;
  final String? initialPicUrl;
  final Function(String username, String email, File? newImage) onConfirm;

  const EditProfileDialog({
    super.key,
    required this.initialUsername,
    required this.initialEmail,
    this.initialPicUrl,
    required this.onConfirm,
  });

  @override
  State<EditProfileDialog> createState() => _EditProfileDialogState();
}

class _EditProfileDialogState extends State<EditProfileDialog> {
  late TextEditingController _usernameController;
  late TextEditingController _emailController;
  File? _newImage;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController(text: widget.initialUsername);
    _emailController = TextEditingController(text: widget.initialEmail);
  }

  @override
  Widget build(BuildContext context) {
    return AppDialog(
      title: "Modifier mon profil",
      footer: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton(
            style: TextButton.styleFrom(foregroundColor: AppColors.black),
            onPressed: () => Get.back(),
            child: const Text('Annuler'),
          ),
          const SizedBox(width: 8),
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: AppColors.primaryOrange,
            ),
            onPressed: _isLoading ? null : () => _handleUpdate(),
            child: _isLoading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      color: AppColors.primaryOrange,
                      strokeWidth: 2,
                    ),
                  )
                : const Text('Enregistrer'),
          ),
        ],
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
          textSelectionTheme: TextSelectionThemeData(
            cursorColor: AppColors.primaryOrange,
            selectionColor: AppColors.primaryOrange.withOpacity(0.25),
            selectionHandleColor: AppColors.primaryOrange,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ImageSelector(
              title: "Changer la photo",
              width: 120,
              height: 120,
              onImageSelect: (XFile? image) {
                if (image != null) {
                  setState(() => _newImage = File(image.path));
                }
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _usernameController,
              style: TextStyle(color: AppColors.black),
              decoration: InputDecoration(
                labelText: 'Nom d\'utilisateur',
                labelStyle: TextStyle(color: AppColors.black.withOpacity(0.45)),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: AppColors.primaryOrange.withOpacity(0.18),
                    width: 1,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: AppColors.primaryOrange,
                    width: 1.5,
                  ),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _emailController,
              style: TextStyle(color: AppColors.black),
              decoration: InputDecoration(
                labelText: 'Email',
                labelStyle: TextStyle(color: AppColors.black.withOpacity(0.45)),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: AppColors.primaryOrange.withOpacity(0.18),
                    width: 1,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: AppColors.primaryOrange,
                    width: 1.5,
                  ),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleUpdate() async {
    setState(() => _isLoading = true);
    try {
      await widget.onConfirm(
        _usernameController.text,
        _emailController.text,
        _newImage,
      );

      Get.back();
      Get.snackbar('Succès', 'Profil mis à jour');
    } catch (e) {
      Get.snackbar(
        'Erreur',
        'Impossible de mettre à jour le profil: ${e.toString()}',
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }
}
