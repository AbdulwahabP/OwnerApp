import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:ownerapp/device_model.dart';
import 'package:ownerapp/devices.dart';
import 'main.dart';

class SplashScreen extends StatefulWidget {

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState(){
    super.initState();

    FirebaseAuth.instance.currentUser().then((res) {
      print(res);
      if (res != null) {
        Timer(
            Duration(seconds: 3),
                () =>  Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => myDevice(uid: res.uid)),
                ));
      }
      else
      {
        Timer(
            Duration(seconds: 3),
                () => Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) => MyHomePage(title: "owner app",))));
      }
    });

  }


//  void getuser() async{
//
//    FirebaseUser user =  await auth.currentUser();
//   final String Uid = user.uid;
//    if(user==null){
//      Timer(
//          Duration(seconds: 3),
//              () => Navigator.of(context).pushReplacement(MaterialPageRoute(
//              builder: (BuildContext context) => MyHomePage(title: "owner app",))));
//    }
//    else{
//     mlist = await devices.getDevices(Uid.toString());
//      Timer(
//          Duration(seconds: 3),
//              () => Navigator.of(context).pushReplacement(MaterialPageRoute(
//              builder: (BuildContext context) => myDevice(mlist: mlist,uid: Uid,))));
//    }
//
//  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset('assets/logo.png'),
      ),
    );
  }
}