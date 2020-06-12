import 'file:///C:/Users/InZi/fyp/lib/Model/CustomerModel/customerProfileModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:home_well/Controller/CustomerController/rigesterCustomerCtrl.dart';
import 'package:home_well/View/common/AboutUs.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'c_history.dart';
import 'c_login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'c_pending_task.dart';
import 'c_profile.dart';

CustomerDataFromFireStore customerDataFromFireStore =
new CustomerDataFromFireStore();

class CustomerDrawerOnly extends StatefulWidget {
  final CustomerData user;

  const CustomerDrawerOnly({Key key, this.user}) : super(key: key);
  _MyDrawerPageState createState() => _MyDrawerPageState(user);
}
class _MyDrawerPageState extends State<CustomerDrawerOnly> {
  final CustomerData user;
  _MyDrawerPageState(this.user);

  String name;
  String image;
  SharedPreferences sp;

  @override
  void initState() {
    initSp();
    super.initState();
  }
  initSp() {
    customerDataFromFireStore.getSharedPreferences().then((value) {
      setState(() {
        sp = value;
        getUserInfo();
      });
    });
  }
  getUserInfo() async {
     name = sp.getString('cName');
     image = sp.getString('image');
  }

  @override
  Widget build(BuildContext context) {
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
                    name??'Name',
                    textAlign: TextAlign.center,
                  )
                ],
              ),
              decoration: new BoxDecoration(color: Colors.lightGreen),
            ),
            new ListTile(
              leading:
              Icon(Icons.person_outline, color: Colors.lightGreen, size: 24),
              title: Text('Profile'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) => new Profile()));
              },
            ),
    //      new ListTile(
    //          leading: Icon(Icons.account_balance_wallet,
    //      color: Colors.lightGreen, size: 24),
    //      title: new Text(
    //          "My Wallet",
    //        ),
    //        onTap: () {
    //          Navigator.pop(context);
    //          Navigator.push(
    //              context,
    //             new MaterialPageRoute(
    //                builder: (context) => new CustomerLogin()));
    //        },),

            new ListTile(
              leading: Icon(Icons.assignment, color: Colors.lightGreen, size: 24),
              title: new Text(
                "Pending Tasks",
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => new CustomerPendingTask(userId: user.userId)));
              },
            ),
            new ListTile(
              leading: Icon(Icons.history, color: Colors.lightGreen, size: 24),

              title: new Text(
                "History",
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => new CustomerHistory(userId: user.userId)));
              },
            ),
            new ListTile(
              leading:
              Icon(Icons.notifications, color: Colors.lightGreen, size: 24),
              title: new Text(
                "Notifications",
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => new CustomerLogin()));
              },
            ),
            new ListTile(
              leading: Icon(Icons.info, color: Colors.lightGreen, size: 24),
              title: new Text(
                "About Us",
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => new AboutUs()));
              },
            ),
            new ListTile(
              leading: Icon(Icons.exit_to_app, color: Colors.lightGreen, size: 24),
              title: new Text(
                "Logout",
              ),
              onTap: () {
                _signOut();
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => CustomerLogin()));

                },
            ),
          ],
        ));
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