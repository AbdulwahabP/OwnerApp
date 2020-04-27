import 'dart:async';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:ownerapp/check_device.dart';
import 'package:ownerapp/device_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ownerapp/main.dart';

class myDevice extends StatefulWidget {
  var title;
  final String uid;

  myDevice({Key key, this.title, @required this.uid}) : super(key: key);

  @override
  myDevices createState() => myDevices();
}

class myDevices extends State<myDevice> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  String selected;
  final typeController = TextEditingController();
  final comController = TextEditingController();
  final serialController = TextEditingController();
  final ownerController = TextEditingController();
  final idController = TextEditingController();
  List<device_m> mlist;

  @override
  void dispose() {
    super.dispose();
    typeController.dispose();
    comController.dispose();
    serialController.dispose();
    ownerController.dispose();
    idController.dispose();
  }

  @override
  void initState() {
    super.initState();

    setState(() {
      // getDevices();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomPadding: true,
      appBar: AppBar(
        title: Text('my devices'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.subdirectory_arrow_right,
              color: Colors.white,
            ),
            padding: EdgeInsets.all(10),
            onPressed: () {


              showDialog(
                  context: context,
                  builder: (BuildContext dialogContext) {
                    return AlertDialog(
                      content: Container(
                        padding: EdgeInsets.all(20),
                        child: Text("Logout?",style: TextStyle(color: Colors.pink,fontWeight: FontWeight.bold),),
                      ),
                      actions: <Widget>[
                        GestureDetector(
                            child: Text("Yes",style: TextStyle(color: Colors.pink,fontWeight: FontWeight.bold),),
                          onTap: () {
                            FirebaseAuth.instance.signOut().whenComplete(() =>
                                Navigator.pushReplacement(context,
                                    MaterialPageRoute(builder: (context) => MyHomePage(title: "owner app",))));
                          },
                        ),
                        SizedBox(width: 50,height: 50,),
                        GestureDetector(
                          child: Text("No",style: TextStyle(color: Colors.pink,fontWeight: FontWeight.bold),),
                          onTap: () {
                            Navigator.pop(dialogContext);
                          },
                        ),
                        SizedBox(width: 50,height: 50,),
                      ],
                    );
                  });
              
            },
          ),
        ],
      ),
      body: new Column(
        children: <Widget>[
          new Flexible(
            child: new FirebaseAnimatedList(
                query: FirebaseDatabase.instance
                    .reference()
                    .child("users")
                    .child(widget.uid)
                    .orderByChild("type"),
                itemBuilder: (_, DataSnapshot snapshot,
                    Animation<double> animation, int x) {
                  device_m data = device_m.fromSnapshot(snapshot);
                  return Ui(data.type, data.serial_number, widget.uid);
                }),
          ),
        ],
      ),
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        animatedIconTheme: IconThemeData(size: 22.0),
        // this is ignored if animatedIcon is non null
        // child: Icon(Icons.add),
        curve: Curves.bounceIn,
        overlayColor: Colors.black,
        overlayOpacity: 0.5,
        onOpen: () => print('OPENING DIAL'),
        onClose: () => print('DIAL CLOSED'),
        tooltip: 'Speed Dial',
        heroTag: 'speed-dial-hero-tag',
        backgroundColor: Colors.blue,
        elevation: 8.0,
        shape: CircleBorder(),
        children: [
          SpeedDialChild(
              child: Icon(Icons.add),
              backgroundColor: Colors.red,
              label: 'Add device',
              onTap: () {
                showDialog(
                    context: context,
                    builder: (BuildContext dialogContext) {
                      return AlertDialog(
                        content: Stack(
                          overflow: Overflow.visible,
                          children: <Widget>[
                            Positioned(
                              right: -40.0,
                              top: -40.0,
                              child: InkResponse(
                                onTap: () {
                                 // Navigator.of(context).pop();
                                  Navigator.of(context, rootNavigator: true).pop();
                                },
                                child: CircleAvatar(
                                  child: Icon(Icons.close),
                                  backgroundColor: Colors.grey,
                                ),
                              ),
                            ),
                            Form(
                              key: _formKey,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.all(6.0),
                                    child: DropdownButtonFormField(
                                      hint: Text("(Device type)"),
                                      value: selected,
                                      items: ["Smartphone", "Tablet"]
                                          .map((label) => DropdownMenuItem(
                                                child: Text(label),
                                                value: label,
                                              ))
                                          .toList(),
                                      onChanged: (value) {
                                        setState(() => selected = value);
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(6.0),
                                    child: TextFormField(
                                      controller: comController,
                                      decoration:
                                          InputDecoration(hintText: "company"),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(6.0),
                                    child: TextFormField(
                                      controller: serialController,
                                      decoration: InputDecoration(
                                          hintText: "serial number"),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(6.0),
                                    child: TextFormField(
                                      controller: ownerController,
                                      decoration: InputDecoration(
                                          hintText: "Owner name"),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(6.0),
                                    child: TextFormField(
                                      controller: idController,
                                      decoration: InputDecoration(
                                          hintText: "ID number"),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(6.0),
                                    child: RaisedButton(
                                      child: Text("Add Device"),
                                      onPressed: () {

                                            add_dev(
                                                selected,
                                                comController.text.trim(),
                                                serialController.text.trim(),
                                                ownerController.text.trim(),
                                                idController.text.trim());

                                      },
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    });
              }),
          SpeedDialChild(
              child: Icon(Icons.check),
              backgroundColor: Colors.green,
              label: 'Check a device',
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DeviceCheckState()));
              }),
        ],
      ),
    );
  }

  void add_dev(String type, String com, String s, String ow, String id) async {
    final databaseReference = FirebaseDatabase.instance.reference();

    final auth = FirebaseAuth.instance;
    final FirebaseUser user = await auth.currentUser();
    final uid = user.uid;

    databaseReference.child("device").child(s).once().then((DataSnapshot snapshot){
      if(snapshot.value==null){

        databaseReference.child("device").child(s).set({
          'type': type,
          'company': com,
          'serial_num': s,
          'owner_name': ow,
          'nid': id,
        }).whenComplete(
                () => databaseReference.child("users").child(uid).child(s).set({
              'type': type,
              'company': com,
              'serial_num': s,
              'owner_name': ow,
              'nid': id,
            }));
      }

      else{


        _scaffoldKey.currentState.showSnackBar(new SnackBar(duration: new Duration(seconds: 4),
          content: new Row(
            children: <Widget>[
              new Icon(Icons.warning),
              new Text("The device is already registered!")
            ],
          ),));

      }

    });

  }

  Widget Ui(String type, String Serial, String uid) {
    return new Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 10,
      child: Container(
        padding: EdgeInsets.all(10),
        child: ListTile(
          title: Text("Type: $type"),
          subtitle: Text("Serial number: $Serial"),
          leading: CircleAvatar(
            backgroundImage: new AssetImage('assets/avatar.jpg'),
          ),
          trailing: GestureDetector(
            child: Icon(
              Icons.delete,
              color: Colors.red,
            ),
            onTap: () {
              showDialog(
                  context: context,
                  builder: (BuildContext dialogContext) {
                    return AlertDialog(
                      content: Container(
                        child: Text("delete item $Serial",style: TextStyle(color: Colors.pink,fontWeight: FontWeight.bold),),
                      ),
                      actions: <Widget>[
                          GestureDetector(
                              child: Text("delete",style: TextStyle(color: Colors.pink,fontWeight: FontWeight.bold),),
                            onTap: () {
                              FirebaseDatabase.instance
                                  .reference()
                                  .child("users")
                                  .child(uid)
                                  .child(Serial)
                                  .remove().whenComplete(() => Navigator.pop(dialogContext));
                            },
                        ),
                        SizedBox(width: 50,height: 50,),
                        GestureDetector(
                          child: Text("cancel",style: TextStyle(color: Colors.pink,fontWeight: FontWeight.bold),),
                          onTap: () {
                            Navigator.pop(dialogContext);
                          },
                        ),
                        SizedBox(width: 50,height: 50,),
                      ],
                    );
                  });
            },
          ),
        ),
      ),
    );
  }
}
