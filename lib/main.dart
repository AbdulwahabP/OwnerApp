import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ownerapp/Auth.dart';
import 'package:ownerapp/check_device.dart';
import 'package:ownerapp/devices.dart';
import 'package:ownerapp/splash_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'owner app',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final myControllerEmail = TextEditingController();
  final myControllerPassword = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  // final myController = TextEditingController();

  var authHandler = new Auth();

  @override
  void initState(){
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myControllerEmail.dispose();
    myControllerPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 100,
                ),
                Container(
                  height: 150,
                  width: 250,
                  margin: EdgeInsets.fromLTRB(10, 0, 10, 30),
                  decoration: new BoxDecoration(
                    image: DecorationImage(
                        image: new AssetImage('assets/logo.png'),
                        fit: BoxFit.cover),
                  ),
                ),
                Container(
                  width: 300,
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: myControllerEmail,
                    decoration: InputDecoration(
                        labelText: "email",
                        hintText: 'enter email',
                        prefixIcon: new Icon(Icons.mail),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30)),
                        contentPadding: EdgeInsets.all(10)),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'email is empty';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: 300,
                  child: TextFormField(
                      controller: myControllerPassword,
                      obscureText: true,
                      decoration: InputDecoration(
                          hintText: 'enter password',
                          labelText: 'password',
                          prefixIcon: new Icon(Icons.lock),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30)),
                          contentPadding: EdgeInsets.all(10)),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Enter your password';
                        }
                        return null;
                      }),
                ),
                Container(
                    margin: EdgeInsets.all(10),
                    child: new GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => registerS(),
                            ));
                      },
                      child: Text(
                        'Register',
                        style: TextStyle(color: Colors.blue),
                      ),
                    )),
                SizedBox(
                  height: 20,
                ),
                Container(
                    width: 200,
                    child: FlatButton(
                      color: Colors.blue,
                      padding: EdgeInsets.all(15),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      child: Text(
                        'Login',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () {

                        scaffoldKey.currentState.showSnackBar(new SnackBar(duration: new Duration(seconds: 4),
                          content: new Row(
                            children: <Widget>[
                              new CircularProgressIndicator(),
                              SizedBox(width: 15,),
                              new Text("signing In ...")
                            ],
                          ),));

                        if (formKey.currentState.validate()) {
                          authHandler
                              .handleSignInEmail(myControllerEmail.text.trim(),
                                  myControllerPassword.text.trim())
                              .then((FirebaseUser User) {

                            Navigator.pushAndRemoveUntil(
                                context,
                                new MaterialPageRoute(
                                    builder: (context) => new myDevice(uid: User.uid,)),
                                ModalRoute.withName('/home'));
                          }).catchError((e) => print(e));
                        }
                      },
                    ))
              ],
            ),
          ),
        ));
  }
}

class registerS extends StatefulWidget {
  registerS({Key key}) : super(key: key);

  @override
  register createState() => register();
}

class register extends State<registerS> {
  final regKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  final Econtroller = TextEditingController();
  final Pcontroller = TextEditingController();
  final RPcontroller = TextEditingController();

  var authHandler = new Auth();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    Econtroller.dispose();
    Pcontroller.dispose();
    RPcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        key: scaffoldKey,
        appBar: AppBar(
          title: Text('second activity'),
        ),
        body: Center(
          child: Form(
            key: regKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 100,
                ),

                Container(
                  height: 150,
                  width: 250,
                  padding: EdgeInsets.all(0.0),
                  margin: EdgeInsets.fromLTRB(10, 0, 10, 30),
                  decoration: new BoxDecoration(
                    image: DecorationImage(
                        image: new AssetImage('assets/logo.png'),
                        fit: BoxFit.cover),
                  ),
                ),
//           SizedBox(
//             height: 20,
//           ),

                Container(
                  width: 300,
                  child: TextFormField(
                    controller: Econtroller,
                    decoration: InputDecoration(
                        hintText: 'enter email',
                        labelText: 'email',
                        prefixIcon: new Icon(Icons.mail),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30)),
                        contentPadding: EdgeInsets.all(10)),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'email is empty';
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),

                Container(
                  width: 300,
                  child: TextFormField(
                    obscureText: true,
                    controller: Pcontroller,
                    decoration: InputDecoration(
                        hintText: 'enter password',
                        labelText: 'password',
                        prefixIcon: new Icon(Icons.lock),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30)),
                        contentPadding: EdgeInsets.all(10)),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'password is empty';
                      }
                      else if(value.length<6){
                        return 'password is too short';
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),

                Container(
                  width: 300,
                  child: TextFormField(
                    obscureText: true,
                    controller: RPcontroller,
                    decoration: InputDecoration(
                        hintText: 're-enter password',
                        labelText: 'password confirmation',
                        prefixIcon: new Icon(Icons.lock),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30)),
                        contentPadding: EdgeInsets.all(10)),
                    validator: (value){
                      if(value.isEmpty) {
                        return 're-enter your password';
                      }
                    },
                  ),
                ),

                SizedBox(
                  height: 20,
                ),

                Container(
                    width: 200,
                    child: FlatButton(
                      color: Colors.blue,
                      padding: EdgeInsets.all(15),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      child: Text(
                        'Register',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () {
                        scaffoldKey.currentState.showSnackBar(new SnackBar(duration: new Duration(seconds: 4),
                        content: new Row(
                          children: <Widget>[
                            new CircularProgressIndicator(),
                            SizedBox(width: 15,),
                            new Text("signing Up ...")
                          ],
                        ),));
                        if (regKey.currentState.validate()) {
                          authHandler
                              .handleSignUp(Econtroller.text.trim(), Pcontroller.text.trim())
                              .then((FirebaseUser User) {
                            Navigator.pushAndRemoveUntil(
                                context,
                                new MaterialPageRoute(
                                    builder: (context) => new myDevice(uid: User.uid,)),
                                ModalRoute.withName('/home'));
                          }).catchError((e) => print(e));
                        }
                      },
                    ))
              ],
            ),
          ),
        ));
  }
}
