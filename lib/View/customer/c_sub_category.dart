import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:home_well/Controller/CustomerController/rigesterCustomerCtrl.dart';
import 'package:home_well/Model/CustomerModel/customerProfileModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'c_drawer.dart';
import 'c_select_subCategory.dart';


class SubJobs extends StatefulWidget {
  final CustomerData user;
//recive Customer data
  const SubJobs({Key key, this.user}) : super(key: key);

  _MySubCategoryPageState createState() => _MySubCategoryPageState( user);
}
CustomerData _customerData;

CustomerDataFromFireStore customerDataFromFireStore =
new CustomerDataFromFireStore();



class _MySubCategoryPageState extends State<SubJobs> {
  final CustomerData user;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  _MySubCategoryPageState(this.user);
  SharedPreferences sp;
  var job;
  @override
  void initState() {
    _customerData = user;

    initSp();
    super.initState();


  }

  initSp() {
    customerDataFromFireStore.getSharedPreferences().then((value) {
      setState(() {
        sp = value;
        getJobName();
      });
    });
  }
  getJobName() async {
    job = sp.getString('job');
  }

  Widget _buildSubCategoryList() {
    return Container(
      child: StreamBuilder<DocumentSnapshot>(
          stream: Firestore.instance.collection("Jobs").document(job).get().asStream(),
          builder: (context, snapshot) {
            List<String> subJob = new List();
            List<String> subJobImg = new List();
            List<SubCategory> subCategory = new List();

            if (!snapshot.hasData) {



              return Text("Loading...");
            } else {
              subJob = List.from(snapshot.data["subjob"]);

              subJobImg = List.from(snapshot.data['subjobImg']);
              for (int i = 0; i < subJob.length; i++) {
                subCategory.add(SubCategory(subJob[i], subJobImg[i]));
              }
              return Container(
                child: subJob.length > 0
                    ? ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: subJob.length,

                        itemBuilder: (BuildContext context, int index) {
                          return SubCategoryCard(
                              subCategory: subCategory[index]);
                        })
                    : Center(child: Text('This Job has No SubJobs')),
              );
            }
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: CustomerDrawerOnly(),
      appBar: new AppBar(
        leading: new IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            //user.subJob = null;
            sp.remove('job');
            Navigator.pop(context);
          },
        ),
        title: new Text(
          "SubCategory",
          style: new TextStyle(
              fontSize: 20.0, color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      bottomNavigationBar: new BottomNavigationBar(items: [
        new BottomNavigationBarItem(
          icon: new Icon(Icons.home),
          title: new Text('Home'),
        ),
        new BottomNavigationBarItem(
          icon: new Icon(Icons.search),
          title: new Text("Search"),
        )
      ]),
      body: _buildSubCategoryList(),
    );
  }
}

class SubCategory {
  final String title;
  final String imageUrl;

  SubCategory(this.title, this.imageUrl);
}

class SubCategoryCard extends StatelessWidget {
  final SubCategory subCategory;

  const SubCategoryCard({this.subCategory});

  @override
  Widget build(BuildContext cxt) {
    return Container(
      margin: EdgeInsets.all(8.0),
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0))),
        child: InkWell(
          onTap: () {
           // _customerData.subJob = subCategory.title;
            customerDataFromFireStore.save('subJob', subCategory.title);

            Navigator.push(
                cxt,
                new MaterialPageRoute(
                    builder: (context) => new SelectSubCategory( user: _customerData)));
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  topRight: Radius.circular(8.0),
                ),
                child: Image.asset(subCategory.imageUrl,
                    height: 150, fit: BoxFit.fill),
              ),
              ListTile(
                title: Text(
                  subCategory.title,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
