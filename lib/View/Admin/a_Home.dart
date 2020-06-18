import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:home_well/Model/AdminModel/adminProfileModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'a_drawer.dart';

class AdminHome extends StatefulWidget {
  final String adminId;

  const AdminHome({Key key, this.adminId}) : super(key: key);
  _MyHomePageState createState() => _MyHomePageState();
}
AdminDataFromFireStore _dataFromFireStore = AdminDataFromFireStore();
class _MyHomePageState extends State<AdminHome> {
  SharedPreferences sp;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  void initState() {
    _dataFromFireStore.getAdminData(widget.adminId);
    initSp();
    super.initState();
  }

  initSp() {
    _dataFromFireStore.getSharedPreferences().then((value) {
      setState(() {
        sp = value;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: AdminDrawerOnly(),
      appBar: new AppBar(
        leading: new IconButton(
          icon: Icon(
            Icons.menu,
            size: 30,
            color: Colors.black,
          ),
          onPressed: () {
            _scaffoldKey.currentState.openDrawer();
          },
        ),
        title: new Text(
          "Home",
          style: new TextStyle(
              fontSize: 20.0, color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.notifications_none,
                size: 30,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pop(context);
//                Navigator.push(
//                    context,
//                    MaterialPageRoute(
//                        builder: (context) => FirebaseNotifications()));
              }),
        ],
        centerTitle: true,
      ),
      body: DoubleBackToCloseApp(
          snackBar: const SnackBar(
            content: Text('Tap back again to leave'),
            backgroundColor: Colors.lightGreen,

          ),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset('Images/home.jpg'),
              ])),
    );
  }
}
