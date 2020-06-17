import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:home_well/Controller/AdminController/RegisterAdminCtrl.dart';
class DatabaseService {
  final String uid;

  DatabaseService({this.uid});

  //collection reference
  final CollectionReference adminCollection = Firestore.instance.collection('Admin');
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  _getToken(){
    _firebaseMessaging.getToken().then((deviceToken){
      print("device token: $deviceToken");
      return deviceToken;
    });
  }
  Future <void> updateAdminData(AdminData bundle) async {
    String imgUrl;
    //upload image to firebase storage
    if(bundle.image != null && bundle.imagePath != null) {
      StorageReference firebaseStorageRef = FirebaseStorage.instance.ref()
          .child(bundle.imagePath);
      StorageUploadTask uploadTask = firebaseStorageRef.putFile(bundle.image);
      StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
      imgUrl = await taskSnapshot.ref.getDownloadURL();
    }
    //upload customer data to firebase
    return await adminCollection.document(uid).setData({
      'Name': bundle.fname,
      'Gender': bundle.gender,
      'Phone': bundle.ph,
      'Email': bundle.email,
      'City': bundle.city,
      'Area': bundle.area,
      'Address': bundle.address,
      'Password': bundle.password,
      'Image': imgUrl,
      'device_token': _getToken(),
    });
  }

  Future signin(_email, _password) async {
    try {
      AuthResult authResult = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
          email: _email, password: _password);
      FirebaseUser user = authResult.user;
      return user;
    } catch (signinError) {
      print(signinError.toString());
      return null;
    }
  }
}

