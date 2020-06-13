import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:home_well/Controller/CustomerController/rigesterCustomerCtrl.dart';
import 'package:home_well/Model/CustomerModel/customerProfileModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'c_location_selection.dart';

class SelectSubCategory extends StatefulWidget {
  final CustomerData user;

  const SelectSubCategory({Key key, this.user}) : super(key: key);

  _MySignupPageState createState() => _MySignupPageState(user);
}

List<String> _selectedSubJobs = new List() ;
List<int> _counter = new List();
List<int> _price = new List();
StreamController _event =StreamController<int>.broadcast();

CustomerDataFromFireStore customerDataFromFireStore =
new CustomerDataFromFireStore();

class _MySignupPageState extends State<SelectSubCategory> {
  final CustomerData user;

  _MySignupPageState(this.user);
  SharedPreferences sp;
  var subJob;
  @override
  void initState() {
    initSp();
    super.initState();
  }
  initSp() {
    customerDataFromFireStore.getSharedPreferences().then((value) {
      setState(() {
        sp = value;
        getSubJobName();
      });
    });
  }
  getSubJobName() async {
    subJob = sp.getString('subJob');

  }
  Widget _buildSubJobsList() {
    Size media = MediaQuery.of(context).size;
    return Container(
        height: media.height * 0.65,
        child: StreamBuilder<DocumentSnapshot>(
            stream: Firestore.instance
                .collection("SubJob")
                .document(subJob)
                .get()
                .asStream(),
            builder: (context, snapshot) {
              List<String> jobTitle = new List();
              List<int> jobRate = new List();
              List<SubJobs> subCategory = new List();

              if (!snapshot.hasData) {
                return Text("Loading...");
              } else {
                print(subJob);
                jobTitle = List.from(snapshot.data['Subcategory']);
                jobRate = List.from(snapshot.data['jobRate']);
                print(jobTitle.length);
                print("Job rateeeeeee :$jobRate");

                for (int i = 0; i < jobTitle.length; i++) {
                  subCategory.add(SubJobs(jobTitle[i], jobRate[i], 0));
                }
                return Container(
                  child: subCategory.length > 0
                      ? ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: subCategory.length,
                          itemBuilder: (BuildContext context, int index) {

                            return SubJobsCard(subJobs: subCategory[index]);
                          })
                      : Center(child: Text('No Items')),
                );
              }
            }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      appBar: AppBar(
        title: Text(
          "Select Jobs",
          style: new TextStyle(
              fontSize: 20.0, color: Colors.black, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
              sp.remove('subJobey');
                _selectedSubJobs.clear();
              _counter.clear();
              _price.clear();
            }),
      ),
//      bottomNavigationBar: new BottomNavigationBar(items: [
//        new BottomNavigationBarItem(
//          icon: new Icon(Icons.info,
//          size: 0,
//           ),
//          title: new Text("*Call for Price, If not mentioned",
//          style: TextStyle(color: Colors.red,
//          ),),
//        ),
//      ],
//      ),

      bottomNavigationBar: Container(
        height: 40,
        color: Colors.white,
        child: InkWell(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center ,
                crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text('*Call for Price, If not mentioned',
                    style: TextStyle(color: Colors.red)
                )
              ],
            ),

        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Text(
              "Select Sub Jobs",
            ),
            _buildSubJobsList(),
            SizedBox(
              height: 10,
            ),
            NextButton(user: user, sp: sp)
          ],
        ),
      ),
    );
  }
}

class NextButton extends StatelessWidget {
  final CustomerData user;
  final SharedPreferences sp;

  const NextButton({Key key, this.user, this.sp}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(

      width: 150.0,

      child: RaisedButton(

          elevation: 5.0,
          textColor: Colors.white,
          color: Colors.lightGreen,
          shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30.0),
          ),
          child: Text(
            "Next",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20.0,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold),
          ),
          onPressed: () {
            //user.subJobFields = _selectedSubJobs;
            List<String> _counterInStr = _counter.map((i) => i.toString()).toList();
            List<String> _priceInStr = _price.map((i) => i.toString()).toList();
            sp.setStringList('subJobFields', _selectedSubJobs);
            sp.setStringList('subJobsCounter', _counterInStr);
            sp.setStringList('subJobsPrice', _priceInStr);

            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        CustomerLocationSelection()));
          }),
    );
  }
}

class SubJobs {
  final String title;
  final int price;
  int quantity;

  SubJobs(this.title, this.price, this.quantity,);
}

class SubJobsCard extends StatefulWidget {
  final SubJobs subJobs;
  const SubJobsCard({this.subJobs, });

  @override
  _subJobsCard createState() => _subJobsCard(subJobs: this.subJobs,);
}

// ignore: camel_case_types
class _subJobsCard extends State<SubJobsCard> {
  final SubJobs subJobs;


  _subJobsCard({this.subJobs, });

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 7.0,
        margin: new EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
        child: Container(
          decoration: BoxDecoration(color: Colors.black12),
          child: Column(
            children: <Widget>[
              ListTile(
                title: Text(
                  subJobs.title,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontSize: 16.0,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold),
                ),
                subtitle:Row(children: <Widget>[

                  Container(
                    width: 35,
                    height: 35,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: IconButton(
                        icon: Icon(Icons.remove,
                        color: Colors.red,),
                        onPressed: (){
                          if(subJobs.quantity>0)
                            setState(() {
                              subJobs.quantity--;
                              _onSubJobSelected(subJobs.quantity, subJobs.title, subJobs.price);
                            });
                          },
                        iconSize: 25,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10.0, top: 5.0, bottom: 5.0),
                    child: Container(
                        width: 30,
                        height: 35,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 2,
                            color: Colors.black
                          ),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      child: Center(
                        child: StreamBuilder<int>(
                            stream: _event.stream,
                            builder: (context, snapshot) {
                              return Text(
                                subJobs.quantity.toString(),
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              );
                            }),
                      ),
                    ),
                  ),
                  Container(
                    width: 30,
                    height: 35,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: IconButton(
                      icon: Icon(Icons.add,
                      color: Colors.green,),
                     onPressed: (){
                        setState(() {
                          subJobs.quantity++;
                          _onSubJobSelected(subJobs.quantity, subJobs.title, subJobs.price);
                        });
                        },
                      iconSize: 25,
                    ),

                  ),

                ]),
                trailing:Text(
                  'Rs: '+ subJobs.price.toString()+'/-',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontSize: 16.0,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold),
                ) ,
              )
            ],
          ),
        ));
  }


  void _onSubJobSelected(int num, String subJob, int price, ) {
    if (num == 0) {
      _counter.removeAt(_selectedSubJobs.indexOf(subJob));
      _price.removeAt(_selectedSubJobs.indexOf(subJob));
      _selectedSubJobs.remove(subJob);

    }
    else {
      if(_selectedSubJobs.contains(subJob) )
      {
        _counter.removeAt(_selectedSubJobs.indexOf(subJob));
        _price.removeAt(_selectedSubJobs.indexOf(subJob));
        _selectedSubJobs.remove(subJob);
      }
        _counter.add(num);
        _price.add(price*num);
        _selectedSubJobs.add(subJob);

  }
    print(_counter);
    print(_price);
    print(_selectedSubJobs);
  }
}