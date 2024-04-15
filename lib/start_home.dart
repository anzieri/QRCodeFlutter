import 'dart:io';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter/material.dart';

class StartHome extends StatefulWidget {
  const StartHome({Key? key}) : super(key: key);
  @override
  
  State<StartHome> createState() => _StartHomeState();
  
}

class _StartHomeState extends State<StartHome> {
  void initState() {
    AwesomeNotifications().isNotificationAllowed().then((isAllowed){
      if(isAllowed){
        AwesomeNotifications().requestPermissionToSendNotifications();}
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      // appBar: AppBar(
      //           title: Text('Welcome to MyApp'),
      //   leading: IconButton(
      //     icon: Icon(Icons.arrow_back_ios_new_rounded),
      //     onPressed: (){
      //     //Navigator.pop(context);
      //     Navigator.push(context,MaterialPageRoute(builder: (context) => AlertDialog(
      //   title: new Text('Are you sure?'),
      //   content: new Text('Do you want to exit the App?'),
      //   actions: <Widget>[
      //     ElevatedButton(
      //       child: Text('Yes'),
      //       onPressed: ()=> exit(0), //exit the app
      //     ),
      //     ElevatedButton(
      //       child: Text('No'),
      //       onPressed: ()=> Navigator.pop(context,false),
      //     )
      //   ],
      // )),);}
      //   ),),
      body: Container(
        child: Column(
          children: [
            Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.only(left: 20, top: 50),
              child: Text("Welcome", 
              style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,
              )
            ),
            Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
            Text(
              'Welcome to MyApp!',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 16),
            Text(
              'MyApp is a simple and user-friendly app that provides a straight forward solution to everything Quick Response.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),)
          ],),
        
      ),
    );
  }
}
