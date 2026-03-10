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
          TextButton(onPressed: () => Get.back(), child: const Text('Annuler')),
          const SizedBox(width: 8),
          ElevatedButton(
            onPressed: _isLoading ? null : () => _handleUpdate(),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryOrange,
            ),
            child: _isLoading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                : const Text(
                    'Enregistrer',
                    style: TextStyle(color: Colors.white),
                  ),
          ),
        ],
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
            decoration: const InputDecoration(
              labelText: 'Nom d\'utilisateur',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _emailController,
            decoration: const InputDecoration(
              labelText: 'Email',
              border: OutlineInputBorder(),
            ),
          ),
        ],
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
