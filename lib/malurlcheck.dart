import 'package:flutter/material.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

class MaliciousUrlChecker extends StatefulWidget {
  @override
  _MaliciousUrlCheckerState createState() => _MaliciousUrlCheckerState();
}

class _MaliciousUrlCheckerState extends State<MaliciousUrlChecker> {
  // Load the TensorFlow Lite model.
  final interpreter = Interpreter.fromAsset('my_model.tflite');

  // Create a text input field to accept the URL string.
  final TextEditingController _urlController = TextEditingController();

  // Create a button to check if the URL is malicious.
  final ButtonStyle _buttonStyle = ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
    // foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
  );

  // Create a text variable to store the result of the check.
  String _result = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Malicious URL Checker'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _urlController,
              decoration: InputDecoration(
                hintText: 'Enter a URL string',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Check if the URL is malicious.
                final input = _urlController.text;
                // final output = List<dynamic>(1);
                // interpreter.run(input, output);

                // Get the result of the check.
                //final result = output[0];

                // Update the text variable to store the result.
                //_result = result == 1.0 ? 'Malicious URL' : 'Safe URL';

                // Set the state to update the UI.
                setState(() {});
              },
              style: _buttonStyle,
              child: Text('Check'),
            ),
            SizedBox(height: 16.0),
            Text(_result),
          ],
        ),
      ),
    );
  }
}