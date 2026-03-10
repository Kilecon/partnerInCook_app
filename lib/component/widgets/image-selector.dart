import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:partner_in_cook/common/config/constants/app_colors.dart';

class ImageSelector extends StatefulWidget {
  final String title;
  final double width;
  final double height;
  final double borderWidth;
  final Color borderColor;
  final Color iconColor;
  final Color backgroundColor;
  final Function(XFile?) onImageSelect;

  const ImageSelector({
    super.key,
    required this.title,
    required this.onImageSelect,
    this.width = 350,
    this.height = 180,
    this.borderWidth = 2,
    this.borderColor = AppColors.yellowPrimary,
    this.iconColor = AppColors.yellowPrimary,
    this.backgroundColor = AppColors.background,
  });

  @override
  State<ImageSelector> createState() => _ImageSelectorState();
}

class _ImageSelectorState extends State<ImageSelector> {
  String? _selectedImage;

  Future<void> pickImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: source);

    if (image != null) {
      setState(() {
        _selectedImage = image.path;
        widget.onImageSelect(image);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => pickImage(ImageSource.gallery),
      child: Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: widget.borderColor, width: widget.borderWidth),
          color: widget.backgroundColor,
        ),
        clipBehavior: Clip.antiAlias,
        // pour arrondir l'image
        child: _selectedImage == null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    LucideIcons.image,
                    size: 40,
                    color: widget.iconColor,
                  ),
                  Text(
                    widget.title,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              )
            : Image.file(
                File(_selectedImage!),
                fit: BoxFit.cover,
                width: widget.width,
                height: widget.height,
              ),
      ),
    );
  }
}