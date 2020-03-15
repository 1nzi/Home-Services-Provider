
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:home_well/Controller/CustomerController/rigesterCustomerCtrl.dart';

final CollectionReference customerCollection = Firestore.instance.collection('Customer');

class AddHistory{

  Future <void> updateHistoryData(CustomerData bundle) async {

    return await customerCollection.document(bundle.userId).collection('History').document('WorkDone'+bundle.jobCount.toString()).setData({
      'WorkerId' : bundle.workerId,
      'WorkerName' : bundle.workerName,
      'WorkerImg' : bundle.workerImg,
      'Job': bundle.job,
      'SubJob': bundle.subJob,
      'SubJobField': FieldValue.arrayUnion(bundle.subJobFields),
      'Date': bundle.date.toString(),
      'Time': bundle.time.toString(),
      'City': bundle.city,
      'Area': bundle.area,
      'Address': bundle.address,
    });
  }
}