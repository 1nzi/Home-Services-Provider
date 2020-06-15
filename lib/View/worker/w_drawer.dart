
import 'package:home_well/Model/WorkerModel/WorkerProfileModel.dart';
import 'package:home_well/View/common/AboutUs.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'w_login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'w_pending_task.dart';
import 'w_profile.dart';
import 'w_worker_history.dart';

WorkerDataFromFireStore _dataFromFireStore = WorkerDataFromFireStore();

class WorkerDrawerOnly extends StatefulWidget {
  _MyDrawerPageState createState() => _MyDrawerPageState();
}
class _MyDrawerPageState extends State<WorkerDrawerOnly> {

  String uid;
  String name;
  String image;
  SharedPreferences sp;

  @override
  void initState() {
    initSp();
    super.initState();
  }
  initSp() {
    _dataFromFireStore.getSharedPreferences().then((value) {
      sp = value;
      getUserInfo();
    });
  }
  getUserInfo() async {
    uid = sp.getString('workerId');
    name = sp.getString('wName');
    image = sp.getString('image');
    print('id: $uid name: $name');
  }

  @override
  Widget build (BuildContext context) {
    return new Drawer(

        child: new ListView(

          children: <Widget>[
            new DrawerHeader(
              child: Column(
                children: <Widget>[

                  new Container(
                    width: 100,
                    height: 100,
                    decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      image: new DecorationImage(
                        fit: BoxFit.cover,
                        image:  NetworkImage(
                            image??
                                "https://previews.123rf.com/images/tuktukdesign/tuktukdesign1606/tuktukdesign160600105/59070189-user-icon-man-profile-businessman-avatar-person-icon-in-vector-illustration.jpg"),
                      ),
                    ),
                  ),
                  Text(
                    name?? 'Name',
                    textAlign: TextAlign.center,
                  )
                ],
              ),
              decoration: new BoxDecoration(
                  color: Colors.lightGreen
              ),
            ),
            new ListTile(
              leading: Icon(Icons.person_outline, color: Colors.lightGreen, size:24),
              title: new Text("My Profile",
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) => new WProfile()));
              },
            ),
           /* new ListTile(
              leading: Icon(Icons.account_balance_wallet, color: Colors.lightGreen, size:24),
              title: new Text("My Wallet",
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) => new Wallet()));
              },
            ),*/
            new ListTile(
              leading: Icon(Icons.assignment, color: Colors.lightGreen, size:24),
              title: new Text("Pending Task",
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) => new WorkerPendingTask(userId: uid,)));
              },
            ),
            new ListTile(
              leading: Icon(Icons.history, color: Colors.lightGreen, size:24),
              title: new Text("History",
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) => new WorkerHistory()));
              },
            ),

            new ListTile(
              leading: Icon(Icons.info, color: Colors.lightGreen, size:24),
              title: new Text("About Us",),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) => new AboutUs()));
              },
            ),
            new ListTile(
              leading: Icon(Icons.exit_to_app, color: Colors.lightGreen, size:24),
              title: new Text("Logout",
              ),
              onTap: () {
                Navigator.pop(context);
                _signOut();
                sp.remove('workerId');
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => WorkerLogin()));
              },
            ),
          ],
        )
    );
  }


}

class ImageAsset extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AssetImage assetImage = AssetImage('Images/download.png');

    return Container(
      width: 100.0,
      height: 100.0,
      decoration: new BoxDecoration(
          shape: BoxShape.circle,
          image: new DecorationImage(fit: BoxFit.fill, image: assetImage)),
    );
  }
}

class LeadingIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AssetImage assetImage = AssetImage('Images/download.png');

    return Container(
      width: 100.0,
      height: 100.0,
      decoration: new BoxDecoration(
          image: new DecorationImage(fit: BoxFit.fill, image: assetImage)),
    );
  }
}

_signOut()  async{
  await FirebaseAuth.instance.signOut();

}
