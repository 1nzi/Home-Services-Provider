import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:home_well/Controller/CustomerController/rigesterCustomerCtrl.dart';
import 'package:shared_preferences/shared_preferences.dart';

QuerySnapshot jobs;

CustomerData userData = new CustomerData();

class CustomerDataFromFireStore {
  final db = Firestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser user;

  initUser() async {
    user = await _auth.currentUser();
    getCustomerData(user);
  }
  updateData(String uid, String title, String newVal) async {
    await db.collection('Customer').document(uid).updateData({title: newVal});
  }

  updateJobCount(String uid, String title, int newVal) async {
    await db.collection('Customer').document(uid).updateData({title: newVal});
  }
  getCustomerData(FirebaseUser user) async {
    var userQuery = db.collection('Customer').document(user.uid);
    userQuery.get().then((data) {
      userData.userId = user.uid;
      save('userId', user.uid);
      userData.fname = data['Name'];
      save('cName', data['Name']);
      userData.email = data['Email'];
      save('email', data['Email']);
      userData.ph = data['Phone'];
      save('ph', data['Phone']);
      userData.image = data['Image'];
      save('image', data['Image']);
      userData.city = data['City'];
      save('city', data['City']);
      userData.gender = data['Gender'];
      save('gender', data['Gender']);
      userData.area = data['Area'];
      save('area', data['Area']);
      userData.address = data['Address'];
      save('address', data['Address']);
      userData.jobCount = data['JobCount'];
      save('jobCount', data['JobCount']);
      save('password', data['Password']);
    });
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

  setJobs() async {
    await db.collection('Jobs').getDocuments().then((value) {
      jobs = value;
    });
    List<String> jobsTitle = new List();
    List<String> jobsImg = new List();
    if (jobs != null) {
      for (int i = 0; i < jobs.documents.length; i++) {
        jobsTitle.add(jobs.documents[i].data['Title']);
        jobsImg.add(jobs.documents[i].data['ImgUrl']);
      }
      save('JobTitle', jobsTitle);
      save('JobImg', jobsImg);
    }
  }

  getWorker(CustomerData user) async {
    return db
        .collection('Worker')
        .where('City', isEqualTo: user.city)
        .where('Area', isEqualTo: user.area)
        .snapshots();
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