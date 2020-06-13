import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:home_well/Model/CustomerModel/customerProfileModel.dart';
import 'package:home_well/Controller/CustomerController/rigesterCustomerCtrl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'c_drawer.dart';
import 'c_sub_category.dart';

class CustomerHomeScreen extends StatelessWidget {
  // This widget is th root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Well Home',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
      home: CustomerHome(),
    );
  }
}
final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
_getToken(){
  _firebaseMessaging.getToken().then((deviceToken){
    print("device token: $deviceToken");
    return deviceToken;
  });
}
class CustomerHome extends StatefulWidget {
  _MyHomePageState createState() => _MyHomePageState();
}

CustomerDataFromFireStore customerDataFromFireStore =
    new CustomerDataFromFireStore();
CustomerData _customerData;
SharedPreferences sp;

class _MyHomePageState extends State<CustomerHome> {
  List<String> jobsTitle;
  List<String> jobsImg;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    initJobs();
    initSp();
    customerDataFromFireStore.initUser();
    super.initState();
  }

  initSp() {
    customerDataFromFireStore.getSharedPreferences().then((value) {
      setState(() {
        sp = value;
        setDeviceToken();
      });
    });
  }
  setDeviceToken() async {
    sp.setString('token', _getToken());
  }

  initJobs() {
    customerDataFromFireStore.getList('JobTitle').then((results) {
      setState(() {
        jobsTitle = results;
      });
    });
    customerDataFromFireStore.getList('JobImg').then((results) {
      setState(() {
        jobsImg = results;
      });
    });
  }

  Widget _buildCatogeryList() {
    return Container(
      child: jobsTitle != null
          ? ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: jobsTitle.length,
              itemBuilder: (BuildContext context, int index) {
                List<Category> category = new List();
                for (int i = 0; i < jobsTitle.length; i++) {
                  category.add(Category(jobsTitle[i], jobsImg[i]));
                }
                return CategoryCard(category: category[index]);
              })
          : Center(child: Text('Loading...')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: CustomerDrawerOnly(),
      appBar: new AppBar(
        leading: new IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            _scaffoldKey.currentState.openDrawer();
          },
        ),
        title: new Text(
          "Home",
          style: new TextStyle(
              fontSize: 20.0, color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      bottomNavigationBar: new BottomNavigationBar(items: [
        new BottomNavigationBarItem(
          icon: new Icon(Icons.home),
          title: new Text("Home"),
        ),
        new BottomNavigationBarItem(
          icon: new Icon(Icons.search),
          title: new Text("Search"),
        )
      ]),
      body: DoubleBackToCloseApp(
        snackBar: const SnackBar(
          content: Text('Tap back again to leave'),
          backgroundColor: Colors.lightGreen,
        ),
        child: _buildCatogeryList(),
      ),
    );
  }
}

class Category {
  final String title;
  final String imageUrl;

  Category(this.title, this.imageUrl);
}

class CategoryCard extends StatelessWidget {
  final Category category;

  const CategoryCard({this.category});

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 8.0,
        margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
        child: Container(
            decoration: BoxDecoration(
                color: Colors.black12,
                border: Border.all(color: Colors.lightGreen, width: 2.0)),
            child: ListTile(
              leading: Container(
                width: 100.0,
                height: 100.0,
                decoration: new BoxDecoration(
                    image: new DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage(category.imageUrl))),
              ),
              title:
                  Text(category.title, style: TextStyle(color: Colors.black)),
              trailing: IconButton(
                icon: Icon(Icons.arrow_forward_ios, color: Colors.lightGreen),
                onPressed: () {

                  
                  //_customerData.job = category.title;
                  customerDataFromFireStore.save('job', category.title);




                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) =>
                              new SubJobs(user: _customerData)));
                },
              ),
            )));
  }
}
