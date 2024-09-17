import 'package:firebase_database/firebase_database.dart';

class UserModel
{
  String? phone;
  String? name;
  String? id;
  String? email;
  String? avatar;
  String? info;


  UserModel({this.phone, this.name, this.id, this.email,this.avatar, this.info});

  UserModel.fromSnapshot(DataSnapshot snap)
  {
    phone = (snap.value as dynamic)["phone"];
    name = (snap.value as dynamic)["name"];
    id = snap.key;
    email = (snap.value as dynamic)["email"];
    avatar = (snap.value as dynamic)["users_details"]["per_avatar"];
    info = (snap.value as dynamic)["users_details"]["per_info"];
  }
}