
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:home_well/Controller/CustomerController/rigesterCustomer.dart';

final CollectionReference customerCollection = Firestore.instance.collection('Customer');

class AddJobRequest{

  Future <void> updateCustomerData(CustomerData bundle) async {

    return await customerCollection.document(bundle.userId).collection('JobRequest').document('Job'+ bundle.jobCount.toString() ).setData({
      'Job': bundle.job,
      'SubJob': bundle.subJob,
      'SubJobField': FieldValue.arrayUnion(bundle.subJobFields),
      //'Date': bundle.date,
      'Time': bundle.time,
      'City': bundle.city,
      'Area': bundle.area,
      'Address': bundle.address,
    });
  }
}