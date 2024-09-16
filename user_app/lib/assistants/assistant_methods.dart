import 'package:firebase_database/firebase_database.dart';
import '../global/global.dart';
import '../models/user_model.dart';

class AssistantMethods {
  static Future<void> readCurrentOnlineUserInfo() async {
    currentFirebaseUser = firebaseAuthAuth.currentUser;
    if (currentFirebaseUser == null) return;

    DatabaseReference messyHouseRef = FirebaseDatabase.instance
        .ref()
        .child("messyHouse")
        .child(currentFirebaseUser!.uid);

    final snapshot = await messyHouseRef.once();

    if (snapshot.snapshot.value != null) {
      userModelCurrentInfo = UserModel.fromSnapshot(snapshot.snapshot);
    }
  }
}