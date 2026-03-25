import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:partner_in_cook/common/config/constants/app_colors.dart';
import 'package:partner_in_cook/component/widgets/app_dialog.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

class QrShareDialog extends StatefulWidget {
  final String title;
  final String description;
  final String data; // Le lien ou l'ID à encoder
  final String copyLabel;

  const QrShareDialog({
    super.key,
    required this.title,
    required this.description,
    required this.data,
    this.copyLabel = 'Copier le lien',
  });

  @override
  State<QrShareDialog> createState() => _QrShareDialogState();
}

class _QrShareDialogState extends State<QrShareDialog> {
  late QrImage _qrImage;

  @override
  void initState() {
    super.initState();
    _generateQr();
  }

  void _generateQr() {
    // On utilise une version élevée (10) et une correction M 
    // pour éviter l'erreur "Input too long" que tu as eu.
    final qrCode = QrCode(10, QrErrorCorrectLevel.M)..addData(widget.data);
    _qrImage = QrImage(qrCode);
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
            child: const Text('Fermer', style: TextStyle(color: AppColors.black)),
          ),
          const SizedBox(width: 8),
          TextButton(
            style: TextButton.styleFrom(foregroundColor: AppColors.primaryOrange),
            onPressed: () {
              Clipboard.setData(ClipboardData(text: widget.data));
              Get.snackbar(
                'Succès',
                'Copié dans le presse-papiers'
              );
            },
            child: Text(widget.copyLabel),
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
          Center(
            child: SizedBox(
              height: 180,
              width: 180,
              child: PrettyQrView(
                qrImage: _qrImage,
                decoration: const PrettyQrDecoration(
                  shape: PrettyQrSmoothSymbol(color: AppColors.black),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}