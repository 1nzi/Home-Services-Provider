import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:home_well/Controller/WorkerController/rigesterWorker.dart';

WorkerData workerData = new WorkerData();

class WorkerDataFromFireStore {
  final db = Firestore.instance;
  FirebaseUser user;


  updateData(String wid, var title, var newVal) async {
    await db.collection('Worker').document(wid).updateData({title: newVal});
  }

  updateFeedBack(String wid, String title, String feedback) async {
    await db.collection('Worker').document(wid).collection('FeedBack').document('fb').setData({title: feedback});
  }

  WorkerData getWorkerData(String workerId) {
    var userQuery = db.collection('Worker').document(workerId);
    userQuery.get().then((data) {
      workerData.workerId = workerId;
      workerData.name = data['Name'];
      workerData.image = data['Image'];
      workerData.cnic = data['Cnic'];
      workerData.email = data['Email'];
      workerData.ph = data['Phone'];
      workerData.city = data['City'];
      workerData.area = data['Area'];
      workerData.job = data['Job'];
      workerData.rating = data['Rating'].toDouble();
      workerData.rater = data['Rater'];
    });
    return workerData;
  }

  getjobs() async {
    return await db.collection('Jobs').getDocuments();
  }

  getWorker(WorkerData user) async {
    return  db.collection('Worker').where('City' , isEqualTo: user.city ).where('Area', isEqualTo: user.area).snapshots();
  }
}
