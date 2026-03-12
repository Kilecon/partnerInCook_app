import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partner_in_cook/common/config/constants/app_colors.dart';
import 'package:partner_in_cook/common/config/constants/visibility_state_enum.dart';
import 'package:partner_in_cook/component/widgets/app_dialog.dart';
import 'package:partner_in_cook/component/widgets/image-selector.dart';
import 'package:partner_in_cook/model/api/recipe_list.dart';

class EditRecipeListDialog extends StatefulWidget {
  final RecipeList recipeList;
  final Function(RecipeListUpdateRequest data, File? newImage) onConfirm;

  const EditRecipeListDialog({super.key, required this.recipeList, required this.onConfirm});

  @override
  State<EditRecipeListDialog> createState() => _EditRecipeListDialogState();
}

class _EditRecipeListDialogState extends State<EditRecipeListDialog> {
  late TextEditingController _nameController;
  late TextEditingController _descController;
  late VisibilityStateEnum _state;
  File? _newImage;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.recipeList.name);
    _descController = TextEditingController(text: widget.recipeList.description ?? '');
    _state = widget.recipeList.visibilityState;
  }

  @override
  Widget build(BuildContext context) {
    // Hauteur dispo = écran - clavier - marges dialog
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    final screenHeight = MediaQuery.of(context).size.height;
    final maxHeight = (screenHeight * 0.55) - keyboardHeight;

    return AppDialog(
      title: "Modifier la liste",
      footer: _buildFooter(),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: maxHeight.clamp(200.0, screenHeight * 0.55),
        ),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ImageSelector(
                title: "Changer la couverture",
                width: double.infinity,
                height: 140,
                onImageSelect: (file) {
                  if (file != null) setState(() => _newImage = File(file.path));
                },
              ),
              const SizedBox(height: 20),
              _buildField(_nameController, "Nom de la liste", Icons.edit),
              const SizedBox(height: 16),
              _buildField(_descController, "Description (optionnel)", Icons.description, maxLines: 3),
              const SizedBox(height: 16),
              _buildDropdown(),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildField(TextEditingController ctrl, String label, IconData icon, {int maxLines = 1}) {
    return TextField(
      controller: ctrl,
      maxLines: maxLines,
      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, size: 20, color: AppColors.primaryOrange),
        filled: true,
        fillColor: AppColors.primaryOrange.withOpacity(0.05),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primaryOrange, width: 1),
        ),
      ),
    );
  }

  Widget _buildDropdown() {
    return DropdownButtonFormField<VisibilityStateEnum>(
      value: _state,
      decoration: InputDecoration(
        labelText: "Visibilité",
        prefixIcon: Icon(
          _state == VisibilityStateEnum.publicState ? Icons.public : Icons.lock,
          size: 20, color: AppColors.primaryOrange,
        ),
        filled: true,
        fillColor: AppColors.primaryOrange.withOpacity(0.05),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
      ),
      items: VisibilityStateEnum.values.map((v) => DropdownMenuItem(
        value: v,
        child: Text(v == VisibilityStateEnum.publicState ? "Public" : "Privé"),
      )).toList(),
      onChanged: (val) => setState(() => _state = val!),
    );
  }

  Widget _buildFooter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: () => Get.back(),
          child: const Text("Annuler", style: TextStyle(color: Colors.grey)),
        ),
        const SizedBox(width: 12),
        ElevatedButton(
          onPressed: _isLoading ? null : _submit,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryOrange,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            elevation: 0,
          ),
          child: _isLoading
            ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
            : const Text("Enregistrer", style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }

  void _submit() async {
    setState(() => _isLoading = true);
    final data = RecipeListUpdateRequest(
      name: _nameController.text,
      description: _descController.text,
      visibilityState: _state,
      isFavorite: widget.recipeList.isFavorite,
      authorId: widget.recipeList.author.id,
      pictureUrl: widget.recipeList.pictureUrl,
    );
    await widget.onConfirm(data, _newImage);
    if (mounted) setState(() => _isLoading = false);
  }
}