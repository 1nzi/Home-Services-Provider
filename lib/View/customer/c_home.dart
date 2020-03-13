
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:home_well/Controller/CustomerController/customerProfileCtrl.dart';
import 'package:home_well/Controller/CustomerController/rigesterCustomerCtrl.dart';
import 'c_drawer.dart';
import 'c_sub_category.dart';

class HomeScreen extends StatelessWidget {
  // This widget is the root of your application.
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
class CustomerHome extends StatefulWidget {
  _MyHomePageState createState() => _MyHomePageState();
}

CustomerDataFromFireStore customerDataFromFireStore = new CustomerDataFromFireStore();
CustomerData _customerData;


class _MyHomePageState extends State<CustomerHome> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser user;
  QuerySnapshot jobs;


  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();


  @override
  void initState() {
    initJobs();
    initUser();
    super.initState();

  }

  initUser() async {
    user = await _auth.currentUser();
    _customerData = customerDataFromFireStore.getCustomerData(user);
  }

  initJobs(){
    customerDataFromFireStore.getjobs().then((results) {
      setState(() {
        jobs = results;
      });
    });
  }

  Widget _buildCatogeryList() {
    return Container(
      child: jobs!=null
          ? ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: jobs.documents.length,
          itemBuilder: (BuildContext context, int index) {
            List <Category> category = new List();
            for(int i=0; i<jobs.documents.length; i++){
              category.add(Category(jobs.documents[i].data['Title'], jobs.documents[i].data['ImgUrl']));
            }
            return CategoryCard(category: category[index]);
          }
      )
          : Center(child: Text('Loading...')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: CustomerDrawerOnly(
          user: _customerData),
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
      body: _buildCatogeryList(),
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
                  _customerData.job = category.title;
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) =>new SubJobs(user: _customerData )));
                },
              ),
            )));
  }
}
