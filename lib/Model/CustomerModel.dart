import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:home_well/Controller/CustomerController/rigesterCustomer.dart';

class DatabaseService {
  final String uid;

  DatabaseService({this.uid});

  //collection reference
  final CollectionReference customerCollection =
      Firestore.instance.collection('Customer');

  Future <void> updateCustomerData(CustomerData bundle) async {
    return await customerCollection.document(uid).setData({
      'First Name': bundle.fname,
      'Last Name': bundle.lname,
      'Phone': bundle.ph,
      'Email': bundle.email,
      'City': bundle.city,
      'Area': bundle.area,
      'Address': bundle.address,
      'Password': bundle.password,
    });
  }
}

