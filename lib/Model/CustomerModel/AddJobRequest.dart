import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:home_well/Controller/CustomerController/rigesterCustomerCtrl.dart';
import 'package:home_well/Controller/WorkerController/historyDataModel.dart';


import 'customerProfileModel.dart';

final CollectionReference customerCollection =
    Firestore.instance.collection('Customer');
final CollectionReference workerCollection =
Firestore.instance.collection('Worker');

CustomerDataFromFireStore customerDataFromFireStore =
new CustomerDataFromFireStore();

class AddJobRequest{

  Future<void> updateCustomerHistory(String docId,CustomerData bundle) async {
    return await customerCollection
        .document(bundle.userId)
        .collection('History')
        .document('History'+docId)
        .setData({
      'WorkerName': bundle.workerName,
      'WorkerContact': bundle.workerContact,
      'WorkerImg': bundle.workerImg,
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

  Future<void> updateWorkerHistory(String docId, WorkerHistoryData bundle) async {
    return await
    workerCollection
        .document(bundle.workerId)
        .collection('History')
        .document(docId)
        .setData({
      'CustomerName': bundle.customerName,
      'CustomerContact': bundle.ph,
      'CustomerImg': bundle.customerImg,
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

  Future<void> removeFromPendingCustomer(String docId, String userId) async {
    return await customerCollection
        .document(userId)
        .collection('JobRequest')
        .document(docId).delete();


  }

  Future<void> removeFromPendingWorker(String docId, String userId) async {
    return await workerCollection
        .document(userId)
        .collection('JobRequest')
        .document(docId).delete();


  }

}
