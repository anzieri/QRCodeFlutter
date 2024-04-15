import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/result_screen.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_scanner_overlay/qr_scanner_overlay.dart';
//import 'package:qr_code_scanner/qr_code_scanner.dart';

const bgColor= Color(0xfffafafa);

class QRScanner extends StatefulWidget {
  const QRScanner({super.key,});

  @override
  State<QRScanner> createState() => _QRScannerState();
}

class _QRScannerState extends State<QRScanner> {
  bool isScanCompleted = false;
  

  void closeScreen(){
    setState(() {
      isScanCompleted = false;
    });
  }

  triggerNotification() async {
    // EmojiParser parser = EmojiParser();
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 10,
        channelKey: 'basic_channel',
        title: 'Eureka ${Emojis.smile_smiling_face_with_sunglasses}',
        body: 'QR Code Scanned Successfully',
        // notificationLayout: NotificationLayout.BigPicture,
        // bigPicture: 'asset://assets/images/qr_code.png',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: bgColor,
      // appBar: AppBar(
        
      //   leading: IconButton(
      //     icon: Icon(Icons.arrow_back_ios_new_rounded),
      //     onPressed: (){
      //     Navigator.push(context,MaterialPageRoute(builder: (context) => StartHome()),);}
      //   ),
      //   //title: Text('QR Code Scanner'),
        
      // ),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.all(16), 
        child: Column(
          children: [
            Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.only(left: 4, top: 34),
              child: Text("Let's Scan it", 
              style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,
              )
            ),
            Expanded(
              child: Center( 
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Place the QR code in the area', 
                    style: TextStyle(
                      fontSize: 20,
                      // fontWeight: FontWeight.bold,
                      ),
                      ),
                  SizedBox(height: 10),
                  // Text('Scan the QR code on the back of the device',
                  // style: TextStyle(
                  //     fontSize: 16,
                  //     color: Colors.black54,
                  //     letterSpacing: 1),
                      // ),
                          ],),
                    ),
                    ),
                    ),
            Expanded(
              flex: 4,
              child:SizedBox(
                width: 500,
                height: 500,
              child: Stack(
               children: [ 
                  MobileScanner(
                  controller: MobileScannerController(
                  detectionSpeed: DetectionSpeed.normal,
                  facing: CameraFacing.back,
                  ),
                  //allowDuplicates: false,
                  onDetect: (barcode) {
                  final List<Barcode> barcodes = barcode.barcodes;
                    // final Barcode barcod =Barcode(rawValue: rawValue);
                   //final Uint8List? image = barcode.image;
                    for (final barcode in barcodes) {
                     debugPrint('Barcode found! ${barcode.rawValue}');
                     //setState(() {
                       isScanCompleted = true;
                        triggerNotification();
                       String code = barcode.rawValue ?? '---';
                       print('Scan Complete: ');
                     //});
                    
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ResultScreen(
                          closeScreen: closeScreen, code: code,
                        ),
                      ),
                    );
                  }
                
                },
              ),

              QRScannerOverlay(
                 borderColor: Colors.blueGrey,
                 borderRadius: 10,
                 //borderStrokeWidth: double.infinity,
                 //scanAreaSize:double.infinity,
                 
                 ),

              
              //Overlay(
                //alignment: Alignment.center,
                //overlayColor: Colors.black54,
                //overlayShape: QrScannerOverlayShape(
                //borderColor: Colors.blueGrey,
                //borderRadius: 10,
                //borderLength: 30,
                //borderWidth: 10,
                //cutOutSize: scanArea),
                //),
              
           
               ],
                ),
            ),),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                child: TextButton(
                  onPressed: (){},
                  child: Text(
                    'Developed by Amara',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black87,),
                      ),
                ),),
                )
          ],),
          ),

      );
  }
}