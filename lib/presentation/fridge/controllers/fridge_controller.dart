import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:partner_in_cook/common/config/constants/app_colors.dart';
import 'package:partner_in_cook/component/widgets/app_dialog.dart';
import 'package:partner_in_cook/component/widgets/image-selector.dart';
import 'package:partner_in_cook/data/fridge_mock.dart';
import 'package:partner_in_cook/data/pantry_mock.dart';
import 'package:partner_in_cook/model/api/fridge.dart';
import 'package:partner_in_cook/model/api/pantry.dart';
import 'package:partner_in_cook/model/api/tag.dart';
import 'package:partner_in_cook/routes/app_pages.dart';

class FridgeController extends GetxController {
  var pantries = <Pantry>[].obs;
  var fridge = Rx<Fridge>(fridgeMock);
  var selectedTag = Rxn<Tag>();
  var searchController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    // Initialisation des données de test
    pantries.value = pantriesMock;
    fridge.value = fridgeMock;
  }

  void onPantryTap(String id) {
    // Gérer la sélection du garde-manger
    Get.toNamed(Routes.pantryDetails, arguments: {'id': id});
  }

  void onFridgeTap(String id) {
    Get.toNamed(Routes.fridgeDetails, arguments: {'id': id});
  }

  Future<Map<String, String>?> showCreatePantryDialog(BuildContext context) {
    final nameController = TextEditingController();
    XFile? selectedImage;

    return showDialog<Map<String, String>>(
      context: context,
      builder: (ctx) {
        return AppDialog(
          title: 'Créer un garde‑manger',
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
                  final name = nameController.text.trim();
                  if (name.isEmpty) return;
                  Navigator.of(
                    ctx,
                  ).pop({'name': name, 'image': selectedImage?.path ?? ''});
                },
                child: const Text('Créer'),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 20,
            children: [
              // ImageSelector utilise la galerie pour choisir une image
              ImageSelector(
                title: 'Ajouter une image',
                width: double.infinity,
                height: 140,
                borderColor: AppColors.primaryOrange,
                iconColor: AppColors.primaryOrange,
                backgroundColor: Colors.white,
                onImageSelect: (xfile) {
                  selectedImage = xfile;
                },
              ),
              TextField(
                controller: nameController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Nom',
                  hintText: 'Ex: Cuisine principale',
                  hintStyle: TextStyle(
                    color: AppColors.black.withOpacity(0.45),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: AppColors.primaryOrange.withOpacity(0.18),
                      width: 1,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: AppColors.primaryOrange,
                      width: 1.5,
                    ),
                  ),
                ),
                autofocus: true,
              ),
            ],
          ),
        );
      },
    );
  }
}
