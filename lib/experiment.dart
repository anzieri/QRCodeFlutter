import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'package:encrypt/encrypt.dart' as encrypt;


class QRCodeGenerator extends StatefulWidget {
  const QRCodeGenerator({super.key,});

  @override
  _QRCodeGeneratorState createState() => _QRCodeGeneratorState();
}

class _QRCodeGeneratorState extends State<QRCodeGenerator> {
  // String _text = '';
  // String _password = '';
  // QrImageView? _qrImage;
  final textController = TextEditingController();


  // void _generateQRCode() {
  //   // Encrypt the text with the password.
  //   final encryptedText = _encryptText(_text, _password);

  //   // Generate the QR code.
  //   setState(() {
  //     _qrImage = QrImageView(data: encryptedText);
  //   });
  // }

  // String _encryptText(String text, String password) {
  //   // Use a strong encryption algorithm, such as AES-256.
  //   final encryptedText = AES256.encrypt(text, password);

  //   return encryptedText;
  // }

  // String _decryptText(String encryptedText, String password) {
  //   // Use the same encryption algorithm to decrypt the text.
  //   final text = AES256.decrypt(encryptedText, password);

  //   return text;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Code Generator'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // TextField(
            //   decoration: InputDecoration(
            //     labelText: 'Text',
            //   ),
            //   onChanged: (text) {
            //     _text = text;
            //   },
            // ),
            // TextField(
            //   decoration: InputDecoration(
            //     labelText: 'Password',
            //   ),
            //   obscureText: true,
            //   onChanged: (password) {
            //     _password = password;
            //   },
            // ),
            TextFormField(
              controller: textController,
              decoration: InputDecoration(
              labelText: 'Enter your text',
               ),
            ),
            ElevatedButton(
              onPressed: () {
                final plainText = textController.text;
                final password = 'amararocks';
                final key = encrypt.Key.fromUtf8(password);
                final iv = encrypt.IV.fromLength(16);
                final encrypter = encrypt.Encrypter(encrypt.AES(key));
                final encrypted = encrypter.encrypt(plainText, iv: iv);

              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                title: Text('QR Code'),
                content: QrImageView(
                data: encrypted.base64,
                version: QrVersions.auto,
                size: 200.0,
                ),
      ),
    );
  },
  child: Text('Generate QR Code'),
),
            // ElevatedButton(
            //   onPressed: _generateQRCode,
            //   child: Text('Generate QR Code'),
            // ),
            // if (_qrImage != null)
            //   QrImage(
            //     QrCode: _qrImage,
            //   ),
          ],
        ),
      ),
    );
  }
}