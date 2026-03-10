import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partner_in_cook/common/config/constants/app_colors.dart';
import 'package:partner_in_cook/component/widgets/app_dialog.dart';

class RatingDialog extends StatefulWidget {
  final String title;
  final String description;
  final Function(int rating) onConfirm;
  final int initialRating;

  const RatingDialog({
    super.key,
    required this.title,
    required this.description,
    required this.onConfirm,
    this.initialRating = 0,
  });

  @override
  State<RatingDialog> createState() => _RatingDialogState();
}

class _RatingDialogState extends State<RatingDialog> {
  late int _currentRating;

  @override
  void initState() {
    super.initState();
    _currentRating = widget.initialRating;
  }

  @override
  Widget build(BuildContext context) {
    return AppDialog(
      title: widget.title,
      footer: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Annuler', style: TextStyle(color: AppColors.black)),
          ),
          const SizedBox(width: 8),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryOrange,
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            onPressed: _currentRating == 0 
              ? null 
              : () {
                  widget.onConfirm(_currentRating);
                  Get.back();
                },
            child: const Text('Valider'),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            widget.description,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 14, color: Colors.grey),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (index) {
              final starValue = index + 1;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _currentRating = starValue;
                  });
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Icon(
                    starValue <= _currentRating ? Icons.star_rounded : Icons.star_outline_rounded,
                    size: 45,
                    color: starValue <= _currentRating 
                        ? AppColors.primaryOrange 
                        : Colors.grey[300],
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 8),
          Text(
            _getRatingLabel(_currentRating),
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: _currentRating > 0 ? AppColors.primaryOrange : Colors.grey,
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  String _getRatingLabel(int rating) {
    switch (rating) {
      case 1: return 'Décevant';
      case 2: return 'Pas mal';
      case 3: return 'Très bon';
      case 4: return 'Excellent';
      case 5: return 'Incroyable !';
      default: return 'Sélectionnez une note';
    }
  }
}