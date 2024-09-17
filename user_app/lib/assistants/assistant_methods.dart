
import 'package:firebase_database/firebase_database.dart';


import '../global/global.dart';
import '../models/user_model.dart';

class AssistantMethods
{
  static void readCurrentOnlineUserInfo() async
  {
    currentFirebaseUser = fAuth.currentUser;

    DatabaseReference userRef = FirebaseDatabase.instance
        .ref()
        .child("users")
        .child(currentFirebaseUser!.uid);

    userRef.once().then((snap)
    {
      if(snap.snapshot.value != null)
      {
        userModelCurrentInfo = UserModel.fromSnapshot(snap.snapshot);
        // if (kDebugMode) {
        //   print("name = " + userModelCurrentInfo!.name.toString());
        //   print("email = " + userModelCurrentInfo!.email.toString());
        //   print("avatar = " + userModelCurrentInfo!.avatar.toString());
        //   print("info = " + userModelCurrentInfo!.info.toString());
        //
        // }
      }
    });
  }
}