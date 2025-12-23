import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/recipe_details_controller.dart';

class RecipeDetailsView extends GetView<RecipeDetailsController> {
  const RecipeDetailsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RecipeDetailsView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'RecipeDetailsView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
