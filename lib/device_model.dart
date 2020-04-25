import 'package:firebase_database/firebase_database.dart';

class device_m{
  String key;
  String type;
  String owner_name;
  String serial_number;
  String company;
  String id;

  device_m(
      this.type,
      this.company,
      this.serial_number,
      this.owner_name,
      this.id
      );

  device_m.fromSnapshot(DataSnapshot snapshot):
      key = snapshot.key,
  type = snapshot.value["type"],
  company = snapshot.value["company"],
  serial_number = snapshot.value["serial_num"],
  owner_name = snapshot.value["owner_name"],
  id = snapshot.value["nid"];

  toJson(){
    return {
      "type":type,
      "company":company,
      "serial_number":serial_number,
      "owner_name":owner_name,
      "id":id
    };
  }

}






