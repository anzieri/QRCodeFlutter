import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/qr_scanner.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_flutter/qr_flutter.dart';
 // import 'package:url_check/url_check.dart';
import 'AESEncryption/AES.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter_application_1/request.dart';
import 'dart:math' as math;


class ResultScreen extends StatefulWidget {
  final String code;
  final Function() closeScreen;
  //final Barcode barcode;

  const ResultScreen({super.key, required this.closeScreen, required this.code});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      wowMe();
    });
  }
  //List<String> _data = [];
   String _data = '';
   ValueNotifier<String> reel = ValueNotifier('');
  //  ValueNotifier<String> dialogTrigger = ValueNotifier('');

  //  dialogueTrigger(String value) {
  //   dialogTrigger.value = value;}
  AESEncryption encryption = new AESEncryption();
  //final _formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();

  bool isEncrypted(String data) {
    if (!data.contains(RegExp(r'\s')) && data.contains(RegExp(r'[a-zA-Z]')) && data.contains(RegExp(r'[0-9]')) && data.contains(RegExp(r'[+=%/*]')) && !data.contains('.')){
      return true;
    }else if (data.contains('.')){
      return false;
    }
    return false;
  }

   String wowMe(){
    ValueNotifier<String> dialogTrigger = ValueNotifier('');
    if (isEncrypted(widget.code) == true){
      dialogTrigger.value = widget.code;
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Detected encryption'),
            content: Text('This QR code is encrypted. Please decrypt it first.'),
            actions: <Widget>[
              ElevatedButton(
                child: Text('Decrypt'),
                            onPressed: () {
                            showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Enter your password for decryption'),
                                content: TextField(
                                  controller: passwordController,
                                  //obscureText: true,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Password',
                                  ),
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    child: Text('OK'),
                                    onPressed: () {
                                      _interpretQRCode();
                                      Navigator.of(context).pop(context);
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                              // Navigator.of(context).pop();
                            },
              ),
            ],
          );
        },
      );
      
    }else{
      dialogTrigger.value = 'mustard';
      
    }
     
    String mustard = 'Not working';
      return mustard;
      }



  bool isURL(String data) {
    if (data.startsWith('http://') || data.startsWith('https://')) {
      return true;
    }else if (data.contains('www.') || data.contains('.com') || data.contains('.org') || data.contains('.net') ) {
      return true;
    }else if (data.contains('/') && data.contains('.')) {
      return true;
    }
    return false;
  }

  Future<String> presentURL() async{
    if (isURL(widget.code) == true){
      return widget.code;
    }
    return 'This QR code is a URL.';
  }
  

  Future<String> _interpretQRCode() async{
   //void _interpretQRCode() {
       String inputText = passwordController.text;
    debugPrint('something found! ${widget.code}');
    final encrypted = encrypt.Encrypted.fromBase64(widget.code);
        _data = AESEncryption.decryptMsgpass(encrypted,inputText).toString();
        print('${_data}');
        debugPrint('${_data}');
      return Text('hmm').toString();
    }
   
    
  @override
  Widget build(BuildContext context) {
    //urlCheck();
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: (){ widget.closeScreen();
          Navigator.pop(context);}
        ),
        centerTitle: true,
        title: Text(
                    'QR Scanner', 
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1),
                      ),
      ),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8.0),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children:[ 
            Expanded(
            child: SingleChildScrollView(
              child: ElevatedButton(
                child: Text('Decrypt'),
                onPressed: () { 
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Enter your password for decryption'),
                        content: TextField(
                          controller: passwordController,
                          //obscureText: true,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Password',
                          ),
                        ),
                        actions: <Widget>[
                          TextButton(
                            child: Text('OK'),
                            onPressed: () {
                              _interpretQRCode();
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                  })
            ),
            ),

            
            // FutureBuilder<String>(
            //   future: check(), 
            //   builder: (context, snapshot){
            //     if (snapshot.hasData &&
            //     snapshot.connectionState == ConnectionState.done) {
            //      return Text(snapshot.data!);
            //   } return Text('Complete'); },),
            // SizedBox(height: 10),
            
            FutureBuilder<String>(
              future: _interpretQRCode(),
              builder: (context,  snapshot) {
            QrImageView(
              data: _data,
              version: QrVersions.auto,
              size: 150.0,
              gapless: false,
              // onQRViewCreated: _onQRViewCreated,
              // cameraFacing: CameraFacing.front 
            );
            
              
              return QrImageView(
              data: widget.code,
              size: 200.0,);
            },
            ),
            
            FutureBuilder<String>(
            future: getPrediction(widget.code),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text('Prediction: ${snapshot.data}');
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }
              return CircularProgressIndicator();
            },
          ),
            
            
            // FutureBuilder<String>(
            //   future: ,
            //   builder: (context,  snapshot) {
            //   if (snapshot.hasData){
            //     return Text('${snapshot.data}');
            //   } else{
            //     return Text('Error');
            //   }
            //   },
            //   ),
            
          // Text('${compareCSV(code)}', 
          //       textAlign: TextAlign.center,
          //       style: TextStyle(
          //       fontWeight: FontWeight.bold,
          //       letterSpacing: 1),
          //     ),
          SizedBox(height: 10),
           
          Text('${_data}', 
                style: TextStyle(
                  fontSize: 16,
                fontWeight: FontWeight.bold,
                letterSpacing: 1),
              ),
          Text('${widget.code}', 
                style: TextStyle(
                  fontSize: 16,
                fontWeight: FontWeight.bold,
                letterSpacing: 1),
              ),
          SizedBox(
            width: MediaQuery.of(context).size.width- 100,
            height: 48),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.blue,
              onPrimary: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            onPressed: (){
              Clipboard.setData(ClipboardData(text: widget.code));
            }, 
          child: Text('Copy',
          style: TextStyle(
                  fontSize: 16,
                letterSpacing: 1)),
                ),
          SizedBox(height: 10),
          // ElevatedButton(
          //   style: ElevatedButton.styleFrom(
          //     primary: Colors.blue,
          //     onPrimary: Colors.white,
          //     shape: RoundedRectangleBorder(
          //       borderRadius: BorderRadius.circular(10.0),
          //     ),
          //   ),
          //   onPressed: (){
          //     Clipboard.setData(ClipboardData(text: _data));
          //   },)
        ]),
      ),
    );
  }
}




 // Future<String> compareCSV(String userInput) async {
  // final csvData = await rootBundle.loadString('assets/malicious_phish.csv');
  // final List<List<dynamic>> rowsAsListOfValues =
  //     const CsvToListConverter().convert(csvData);

//   for (final row in rowsAsListOfValues) {
//     if (row.contains(userInput)) {
      
//       Text success = Text(userInput +': This is an unsafe URL. Please reconsider redirecting.', 
//       textAlign: TextAlign.center,
//       style: TextStyle(
//                   fontSize: 16,
//                   letterSpacing: 1));
//       //return '$userInput is an unsafe URL. Please reconsider redirecting';
//       String done = success.toString();
//       return done;
//     }
//   }
//   Text failed = Text('This is a safe URL. Proceed to browser', 
//       textAlign: TextAlign.center,
//       style: TextStyle(
//                   fontSize: 16,
//                   letterSpacing: 1));
//     String fail = failed.toString();              
//   return fail;
// }