import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;

  DatabaseService({this.uid});

  //collection reference
  final CollectionReference customerCollection =
      Firestore.instance.collection('Customer');

  Future updateCustomerData(String fname, String lname, String ph, String email,
      String city, String area, String address, String password) async {
    return await customerCollection.document(uid).setData({
      'First Name': fname,
      'Last Name': lname,
      'Phone': ph,
      'Email': email,
      'City': city,
      'Area': area,
      'Address': address,
      'Password': password,
    });
  }
}
