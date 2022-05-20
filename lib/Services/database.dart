import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  //Collection reference
  final CollectionReference userCollection =
      Firestore.instance.collection('users');

  Future updateUserData(String email, String name, String age, String blood,
      String userType) async {
    return await userCollection.document(uid).setData({
      'email': email,
      'name': name,
      'age': age,
      'blood': blood,
      'userType': userType
    });
  }

  //get users stream
  Stream<QuerySnapshot> get users {
    return userCollection.snapshots();
  }
}
