import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loja_flutter_app/shared/firebase_path.dart';
import '../helpers/firebase_errors.dart';
import './user.dart';

class UserManager extends ChangeNotifier {

  UserManager(){
    _loadCurrentUser();
  }

  User user;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final Firestore firestore = Firestore.instance;

  bool _loading = false;
  bool get loading => _loading;

  bool get isLoggedIn => user != null;

  Future<void> signIn({User user, Function onFail, Function onSucess}) async {
    loading = true;
    try {
      final AuthResult result = await auth.signInWithEmailAndPassword(
          email: user.email,
          password: user.password
      );
      await _loadCurrentUser(firebaseUser: result.user);
      onSucess();
    } on PlatformException catch(e){
      onFail(getErrorString(e.code));
    }
    loading = false;
  }

  Future<void> signup({User user, Function onFail, Function onSucess}) async {
    loading = true;
    try {
      final AuthResult result = await auth.createUserWithEmailAndPassword(
          email: user.email, password: user.password
      );
      user.id = result.user.uid;
      this.user = user;
      await user.saveData();
      onSucess();
    } on PlatformException catch(e) {
      onFail(getErrorString(e.code));
    }
    loading = false;
  }

  void signout(){
    auth.signOut();
    user = null;
    notifyListeners();
  }

  set loading(bool value){
    _loading = value;
    notifyListeners();
  }

  Future<void> _loadCurrentUser({FirebaseUser firebaseUser}) async {
    final FirebaseUser currentUser = firebaseUser ?? await auth.currentUser();
    if(currentUser != null){
      //final DocumentSnapshot docUser = await firestore.collection('users_test')
      final DocumentSnapshot docUser = await firestore.collection(FirebasePath.userCollection)
          .document(currentUser.uid).get();
      user = User.fromDocument(docUser);
      notifyListeners();
    }
  }

}