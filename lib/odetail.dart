import 'package:flutter/material.dart';
import 'package:ownerapp/device_model.dart';

class detail extends StatefulWidget {
  var title;

  final device_m device;

  detail({Key key, @required this.device}) : super(key: key);

  @override
  details createState() => details();
}

class details extends State<detail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        color: Colors.white,
        constraints: BoxConstraints.expand(height: 500),
        padding: EdgeInsets.all(10),
        child: Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(15),
                  child: Row(
                children: <Widget>[
                  Icon(
                    Icons.devices,
                    color: Colors.grey,
                    size: 48,
                  ),
                  SizedBox(width: 30,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Device type",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          )),
                      Text(widget.device.type),
                    ],
                  )
                ],
              ),),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.all(15),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.branding_watermark,
                      color: Colors.grey,
                      size: 48,
                    ),
                    SizedBox(width: 30,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("Company",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            )),
                        Text(widget.device.company),
                      ],
                    )
                  ],
                ),),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.all(15),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.format_list_numbered,
                      color: Colors.grey,
                      size: 48,
                    ),
                    SizedBox(width: 30,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("Serial number",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            )),
                        Text(widget.device.serial_number),
                      ],
                    )
                  ],
                ),),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.all(15),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.person,
                      color: Colors.grey,
                      size: 48,
                    ),
                    SizedBox(width: 30,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("Owner name",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            )),
                        Text(widget.device.owner_name),
                      ],
                    )
                  ],
                ),),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.all(15),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.dialpad,
                      color: Colors.grey,
                      size: 48,
                    ),
                    SizedBox(width: 30,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("ID number",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            )),
                        Text(widget.device.id),
                      ],
                    )
                  ],
                ),),
            ],
          ),
        ),
      ),
    );
  }
}
