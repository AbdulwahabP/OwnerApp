import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:ownerapp/device_model.dart';
import 'package:ownerapp/odetail.dart';

class DeviceCheck extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'owner app',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DeviceCheckState(title: 'Check device'),
    );
  }
}

class DeviceCheckState extends StatefulWidget {
  final String title;

  DeviceCheckState({Key key, this.title}) : super(key: key);

  checkPageState createState() => checkPageState();
}

class checkPageState extends State<DeviceCheckState> {
  final formKey = GlobalKey<FormState>();
  final serialController = TextEditingController();

  var Data;
  device_m data;

  String name,company,serial_num,type,nid;

  @override
  void dispose(){
    serialController.dispose();
    super.dispose();
  }

  FirebaseDatabase database = FirebaseDatabase.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("check device"),
      ),
      body: Center(
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 30,
              ),
              Container(
                width: 300,
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: serialController,
                  decoration: InputDecoration(
                      labelText: "Search",
                      hintText: 'enter device serial number',
                      prefixIcon: new Icon(Icons.search),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30)),
                      contentPadding: EdgeInsets.all(10)),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'enter serial number';
                    }
                    return null;
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
                      'check',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {

                      database.reference().child("device").child(serialController.text)
                          .once().then((DataSnapshot snapshot){

                              Data = device_m.fromSnapshot(snapshot);

                              type = Data.type;
                              company = Data.company;
                              name = Data.owner_name;
                              serial_num = Data.serial_number;
                              nid = Data.id;
                              data = new device_m(type, company, serial_num, name, nid);

                      }).whenComplete(() =>
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>detail(device: data)))
                      );

                    },
                  )),

            ],
          ),
        ),
      ),
    );
  }

}
