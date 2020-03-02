import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:home_well/Controller/CustomerController/rigesterCustomer.dart';

CustomerData userData = new CustomerData();

class CustomerDataFromFireStore {
  final db = Firestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser user;


  updateData(String uid, String title, String newVal) async {
    await db.collection('Customer').document(uid).updateData({title: newVal});
  }

  updateJobCount(String uid, String title, int newVal) async {
    await db.collection('Customer').document(uid).updateData({title: newVal});
  }

  CustomerData getCustomerData(String uid) {
    var userQuery = db.collection('Customer').document(uid);
    userQuery.get().then((data) {
      userData.userId = uid;
      userData.fname = data['Name'];
      userData.email = data['Email'];
      userData.ph = data['Phone'];
      userData.image = data['Image'];
      userData.city = data['City'];
      userData.gender = 'male';
      userData.area = data['Area'];
      userData.address = data['Address'];
      userData.jobCount = data['JobCount'];
    });
    return userData;
  }

  getjobs() async {
    return await db.collection('Jobs').getDocuments();
  }

  getWorker(CustomerData user) async {
    return await db.collection('Worker').where('City' , isEqualTo: user.city ).where('Area', isEqualTo: user.area).snapshots();
  }
}
