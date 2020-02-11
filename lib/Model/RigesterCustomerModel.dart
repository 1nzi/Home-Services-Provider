import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:home_well/Controller/CustomerController/rigesterCustomer.dart';
class DatabaseService {
  final String uid;

  DatabaseService({this.uid});

  //collection reference
  final CollectionReference customerCollection =
      Firestore.instance.collection('Customer');

  Future <void> updateCustomerData(CustomerData bundle) async {
    String imgUrl = null;
    //upload image to firebase storage
    if(bundle.image != null && bundle.imagePath != null) {
      StorageReference firebaseStorageRef = FirebaseStorage.instance.ref()
          .child(bundle.imagePath);
      StorageUploadTask uploadTask = firebaseStorageRef.putFile(bundle.image);
      StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
      imgUrl = await taskSnapshot.ref.getDownloadURL();
    }
    //upload customer data to firebase
    return await customerCollection.document(uid).setData({
      'Name': bundle.fname,
      'Gender': bundle.gender,
      'Phone': bundle.ph,
      'Email': bundle.email,
      'City': bundle.city,
      'Area': bundle.area,
      'Address': bundle.address,
      'Password': bundle.password,
      'Image': imgUrl,
    });
  }
}

