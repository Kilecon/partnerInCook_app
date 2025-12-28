import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/fridge_details_controller.dart';

class FridgeDetailsView extends GetView<FridgeDetailsController> {
  const FridgeDetailsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FridgeDetailsView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'FridgeDetailsView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
