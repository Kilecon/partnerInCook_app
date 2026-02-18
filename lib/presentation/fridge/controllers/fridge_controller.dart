import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partner_in_cook/common/config/constants/app_colors.dart';
import 'package:partner_in_cook/component/widgets/app_dialog.dart';
import 'package:partner_in_cook/model/api/fridge.dart';
import 'package:partner_in_cook/model/api/pantry.dart';
import 'package:partner_in_cook/model/api/tag.dart';
import 'package:partner_in_cook/routes/app_pages.dart';
import 'package:partner_in_cook/services/fridge_service.dart';
import 'package:partner_in_cook/services/pantry_service.dart';

class FridgeController extends GetxController {
  var pantries = <Pantry?>[].obs;
  var fridge = Rx<Fridge?>(null);
  var selectedTag = Rxn<Tag>();
  var searchController = TextEditingController();
  final fridgeService = FridgeService();
  final pantryService = PantryService();
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    loadFridgeDetails('');
    loadAllPantry();
  }

  Future<void> loadFridgeDetails(String id) async {
    try {
      isLoading.value = true;
      final details = await fridgeService.getOwned();
      fridge.value = details;
    } catch (e) {
      print("Error loading fridge details: $e");
      fridge.value = null;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadAllPantry() async {
    try {
      isLoading.value = true;

      // Charger les listes owned et joined
      final owned = await pantryService.getAllOwned();
      print("Owned pantries loaded: ${owned.length}");

      final joined = await pantryService.getAllJoined();
      print("Joined pantries loaded: ${joined.length}");

      // Combiner les deux listes
      pantries.value = [...owned, ...joined];

      // Trier : les favoris en premier
      final sortedList = List<Pantry>.from(pantries);

      sortedList.sort((a, b) => a.name.compareTo(b.name));
      pantries.value = sortedList;

      print("Total pantries: ${pantries.length}");
    } catch (e) {
      print("Error loading pantries: $e");
      pantries.value = [];
    } finally {
      isLoading.value = false;
    }
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
                  ).pop({'name': name});
                },
                child: const Text('Créer'),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 20,
            children: [
           
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
