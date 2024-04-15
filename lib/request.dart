import 'package:http/http.dart' as http;
import 'dart:convert';


  Future<String> getPrediction(String tea) async {
    final response = await http.post(
      Uri.parse('http://192.168.0.13:5000/home'),
      body: jsonEncode(({"input": tea})),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['prediction'];
    } else {
      throw Exception('Failed to load prediction');
    }
  }

//'https://github.com/anzieri/anzieri.github.io'
// http://192.168.0.13:3000/home 55072 53373 24
//http://10.66.38.202:5000/home
//10.66.34.170
//127.0.0.1:58234 51811
// Future getData(url) async {
//   Response response = await get(url);
//   return response.body;
// }

// import 'package:http/http.dart' as http;

// void main() async {
//   // Call the backend server API and get the response.
//   var response = await http.get('https://example.com/api/endpoint');

//   // Decode the JSON response.
//   var decodedData = jsonDecode(response.body);

//   // Print the decoded data.
//   print(decodedData['query']);
// }