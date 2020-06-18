import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:home_well/Controller/WorkerController/rigesterWorker.dart';
import 'package:shared_preferences/shared_preferences.dart';

WorkerData workerData = new WorkerData();

class WorkerDataFromFireStore {
  final db = Firestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser user;

  initUser() async {
    user = await _auth.currentUser();
    getWorkerData(user);
  }


  updateData(String wid, var title, var newVal) async {
    await db.collection('Worker').document(wid).updateData({title: newVal});
  }

  updateFeedBack(String wid, String title, String feedback) async {
    await db.collection('Worker').document(wid).collection('FeedBack').document('fb').setData({title: feedback});
  }

   getWorkerData(FirebaseUser user) {
    var userQuery = db.collection('Worker').document(user.uid);
    userQuery.get().then((data) {
      workerData.workerId = user.uid;
      save('workerId', user.uid);
      workerData.fname = data['Name'];
      save('wName', data['Name']);
      workerData.image = data['Image'];


      workerData.sdate = data['StartDate'];
      save('sdate', data['StartDate']);
      workerData.edate = data['EndDate'];
      save('edate', data['EndDate']);
      workerData.stime = data['StartTime'];
      save('stime', data['StartTime']);
      workerData.etime = data['EndTime'];
      save('etime', data['EndTime']);


      save('image', data['Image']);
      workerData.cnic = data['Cnic'];
      save('cnic', data['Cnic']);
      workerData.email = data['Email'];
      save('email', data['Email']);
      workerData.ph = data['Phone'];
      save('ph', data['Phone']);
      workerData.city = data['City'];
      save('city', data['City']);
      workerData.area = data['Area'];
      save('area', data['Area']);
      workerData.job = data['Job'];
      save('job', data['Job']);
      workerData.rating = data['Rating'].toDouble();
      save('rating', data['Rating'].toDouble());
      workerData.rater = data['Rater'];
      save('rater', data['Rater'].toInt());
    });
    return workerData;
  }

  getList(String key) async {
    final SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    List<String> spList = sharedPrefs.getStringList(key);
    return spList;
  }


  Future<SharedPreferences> getSharedPreferences() async {
    final SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    return sharedPrefs;
  }

  getString(String key) async {
    final SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    String spString = sharedPrefs.getString(key);
    return spString;
  }

  getjobs() async {
    return await db.collection('Jobs').getDocuments();
  }

  getWorker(WorkerData user) async {
    return  db.collection('Worker').where('City' , isEqualTo: user.city ).where('Area', isEqualTo: user.area).snapshots();
  }

  save(String key, dynamic value) async {
    final SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    if (value is bool) {
      sharedPrefs.setBool(key, value);
    } else if (value is String) {
      sharedPrefs.setString(key, value);
    } else if (value is int) {
      sharedPrefs.setInt(key, value);
    } else if (value is double) {
      sharedPrefs.setDouble(key, value);
    } else if (value is List<String>) {
      sharedPrefs.setStringList(key, value);
    }
  }

  removeValueFromSP(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }
}