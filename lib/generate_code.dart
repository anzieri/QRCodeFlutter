import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter/material.dart';
import 'package:flutter_application_1/AESEncryption/AES.dart';
import 'package:flutter_application_1/history.dart';
import 'package:qr_flutter/qr_flutter.dart';



class GenerateCode extends StatefulWidget {
  const GenerateCode({super.key,});
  @override
  _GenerateCodeState createState() => _GenerateCodeState();
}

class _GenerateCodeState extends State<GenerateCode> {

  AESEncryption encryption = new AESEncryption();
  final _formKey = GlobalKey<FormState>();
  final _textController = TextEditingController();
  final input1 = TextEditingController();
  

  String _selectedType = 'Text';
  List<Widget> buttons = [];
  List<String> _history = [];
  List<String> _data = [];

   code() {
    return _data.last;
  }
  
  get hist {
    return _history.last;
    }
    
  void _generateQRCode() {
      String inputText = input1.text;
 
    if (_formKey.currentState!.validate()) {
      setState(() {
        _history.add(_textController.text);
        //_data.add(encryption.encryptMsg(_textController.text).base16);
        //AESEncryption.password = encrypt.Key.fromUtf8(inputText);
        _data.add(encryption.encryptMsgpass(_textController.text,inputText));
        
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      // appBar: AppBar(
        
      //   leading: IconButton(
      //     icon: Icon(Icons.arrow_back_ios_new_rounded),
      //     onPressed: (){
      //     Navigator.push(context,MaterialPageRoute(builder: (context) => StartHome()),);}
      //   ),
      //   //title: Text('QR Code Generator'),
        
      // ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          
          children: [  
            Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.only(left: 4, top: 34),
              child: Text("Make Your Own", 
              style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,
              )
            ),
            TextButton(
            style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
            ),
            onPressed: () { },
            child: Text('TextButton'),
            ),
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DropdownButtonFormField<String>(
                    value: _selectedType,
                    onChanged: (value) {
                      setState(() {
                        _selectedType = value!;
                      });
                    },
                    items: [
                      DropdownMenuItem(
                        value: 'Text',
                        child: Text('Text'),
                      ),
                      DropdownMenuItem(
                        value: 'URL',
                        child: Text('URL'),
                      ),
                      DropdownMenuItem(
                        value: 'WiFi',
                        child: Text('WiFi'),
                      ),
                      DropdownMenuItem(
                        value: 'Email',
                        child: Text('Email'),
                      ),
                    ],
                  ),
                  TextFormField(
                    controller: _textController,
                    decoration: InputDecoration(
                      labelText: 'Enter $_selectedType',
                      
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter $_selectedType';
                      }else{
                        return null;
                      }
                    },
                    
                  ),
                  SizedBox(height: 16.0),

                   TextFormField(
                    controller: input1,
                    decoration: InputDecoration(
                      labelText: 'Enter encryption password',
                    ),
                    //validator: (value) => value!.isEmpty ? 'Please enter password' : null,
                    validator: ($_selectedType) {
                      if ($_selectedType == 'Text') { 
                        return 'Please enter password';
                      }else if($_selectedType == 'Wifi'){

                        // String encodeWifiQR(String ssid, String password, String encryption) {
                        //   return 'WIFI:S:$ssid;T:$encryption;P:$password;;';
                        //   }
                        return 'Please enter password';
                      }else{
                        // dispose(); 
                        return null;
                      }
                    }),
                ],
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: (){
                _generateQRCode();
                //  Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //         builder: (context) => History(
                //           // qrCode: _data.last, history: _history.last
                //         ),
                //         settings: RouteSettings(
                //           arguments: _data.last,
                //           //arguments: _history.last,
                //         ),
                //       ));
              } ,
               
                      
              child: Text('Generate QR Code'),
            ),
            SizedBox(height: 16.0),
            Text(
              'History:',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
                

            Expanded
            (
              child: ListView.builder(
                itemCount: _history.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_history[index]),
                    subtitle: QrImageView(
                      data: _data[index],
                      version: QrVersions.auto,
                      size: 100.0,
                    ),
                  );
                },
              ),
         ), ]
              ),
                
                ),
            
            
            ),
            
        
      );
    
  }
}
