import 'package:flutter/material.dart';
import 'package:flutter_application_1/generate_code.dart';
import 'package:flutter_application_1/history.dart';
import 'package:flutter_application_1/qr_scanner.dart';
import 'package:flutter_application_1/start_home.dart';

class HomeOptions extends StatefulWidget {
  const HomeOptions({super.key,});
  @override
  _HomeOptionsState createState() => _HomeOptionsState();
}

class _HomeOptionsState extends State<HomeOptions> {
  int _selectedIndex = 0;
  final List<Widget> _widgetOptions = [
    
    StartHome(),
    QRScanner(),
    GenerateCode(),
    Text('History'),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      // appBar: AppBar(
        
      // ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
     
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.blue,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home ),
            label: 'Home'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code_scanner),
            label: 'Scan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code),
            label: 'Generate',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
      
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Welcome to QR Code App!'),
              duration: Duration(seconds: 2),
            ),
          );
        },
        child: Icon(Icons.check),
      ),
    );
  }
}
