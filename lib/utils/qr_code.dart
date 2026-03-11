import 'package:pretty_qr_code/pretty_qr_code.dart';

QrImage generateQrCode(String link) {
    QrImage qrImage;
    final qrCode = QrCode(10, QrErrorCorrectLevel.H)
      ..addData(link);
    qrImage = QrImage(qrCode);
    return qrImage;
  }