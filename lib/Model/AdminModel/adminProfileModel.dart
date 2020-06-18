import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:home_well/Controller/AdminController/RegisterAdminCtrl.dart';
import 'package:shared_preferences/shared_preferences.dart';


AdminData userData = new AdminData();

class AdminDataFromFireStore {
  final db = Firestore.instance;



  updateData(String uid, String title, String newVal) async {
    await db.collection('Admin').document(uid).updateData({title: newVal});

  }


  getAdminData(String uid) async {
    db.collection('Admin').document(uid).get().then((data) {
      userData.userId = uid;
      save('adminId', uid);
      userData.fname = data['Name'];
      save('Name', data['Name']);
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

      save('password', data['Password']);
    });
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