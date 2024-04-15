import 'package:flutter/material.dart';
import 'package:flutter_application_1/generate_code.dart';
import 'package:qr_flutter/qr_flutter.dart';

class History extends StatefulWidget {
  // final String qrCode;
  // final String history;

  const History({super.key, 
  // required this.qrCode, required this.history
  });

  @override
  State<History> createState() => _HistoryState();
  
}

class _HistoryState extends State<History> {
  String data ='';
  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context)?.settings.arguments as String;

    return Scaffold(
      // appBar: AppBar(
      //   title: Text('QR Code Display'),
      // ),
      body: Center(
        // child: Image.network(widget.qrCode),
        child: Column(
          children: [
            // Text(widget.history),
            // Image.network(widget.qrCode),

            Expanded
            (
              child: ListView.builder(
                itemCount: 1,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('food'),
                    subtitle: QrImageView(
                      data: data,
                      version: QrVersions.auto,
                      size: 100.0,
                    ),
                  );
                },
              ),
         ),
          ],
        ),
        
      ),
    );
  }
}
