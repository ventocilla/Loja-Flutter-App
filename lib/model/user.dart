import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loja_flutter_app/shared/firebase_path.dart';

class User {
  User({this.id, this.email, this.password, this.name, this.confirmPassword});
  User.fromDocument(DocumentSnapshot document){
    id = document.documentID;
    name = document.data['name'] as String;
    email = document.data['email'] as String;
  }

  String id;
  String name;
  String email;
  String password;
  String confirmPassword;

  //DocumentReference get firestoreRef => Firestore.instance.document('users_test/$id');
  DocumentReference get firestoreRef => Firestore.instance.document('${FirebasePath.userCollection}/$id');

  Future<void> saveData() async {
    await firestoreRef.setData(toMap());
  }

  Map<String, dynamic> toMap(){
    return {
      'name': name,
      'email': email,
    };
  }

}