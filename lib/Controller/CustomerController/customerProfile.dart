import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:home_well/Controller/CustomerController/rigesterCustomer.dart';

CustomerData userData = new CustomerData();

class CustomerDataFromFireStore {
  final db = Firestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser user;

  Future<String> getCurrentUser() async {
    user = await  _auth.currentUser();
    return user.uid;
  }


  updateData(String uid, String title, String newVal) async {
    await db.collection('Customer').document(uid).updateData({title: newVal});
  }


  CustomerData getCustomerData(String uid) {
    var userQuery = db.collection('Customer').document(uid);
    userQuery.get().then((data) {
      userData.userId = uid;
      userData.fname = data['First Name'];
      userData.email = data['Email'];
      userData.ph = data['Phone'];
      userData.image = data['Image'];
      userData.city = data['City'];
      userData.gender = 'male';
      userData.area = data['Area'];
      userData.address = data['Address'];
    });
    return userData;
  }

}
