import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'file:///C:/Users/Saad/fyp/lib/Model/CustomerModel/AddJobRequest.dart';
import 'package:home_well/Model/CustomerModel/customerProfileModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

AddJobRequest _jobRequest = new AddJobRequest();

class ResponseWait extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ResponseWaitState();
}

CustomerDataFromFireStore customerDataFromFireStore =
new CustomerDataFromFireStore();
SharedPreferences sp;


class ResponseWaitState extends State<ResponseWait>{
  String _job;
  String _worker;

  @override
  void initState() {
    initSp();
    super.initState();

  }
  initSp() {
    customerDataFromFireStore.getSharedPreferences().then((value) {
      setState(() {
        sp = value;
        getInfo();
      });
    });
  }
  getInfo() async {
    _job = sp.getString('job');
    _worker = sp.getString('workerName');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                backToHome();
              }),
          title: Text(
            'Wait for Response',
            style: new TextStyle(
                fontSize: 20.0,
                color: Colors.black,
                fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: Colors.lightGreen,
        ),
        bottomNavigationBar: new BottomNavigationBar(items: [
          new BottomNavigationBarItem(
            icon: new Icon(Icons.home,
            size: 30,),
            title: new Text("Home",
            style: TextStyle(
              fontSize: 20
            ),),
          ),
        ],
         onTap: _onItemTapped,
        ),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text('Your request for the ',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    decoration: TextDecoration.none,
                  )),
              Padding(
                padding: EdgeInsets.only(top: 7),
              ),
              Text(_job??'Job',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    decoration: TextDecoration.underline,
                    color: Colors.lightGreen,
                  )),
              Padding(
                padding: EdgeInsets.only(top: 20),
              ),
              Text(
                'is Sent to the Worker',
                style: TextStyle(
                  fontSize: 15,
                  decoration: TextDecoration.none,
                  color: Colors.black,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10),
              ),
              Text(
                _worker??'Worker',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  decoration: TextDecoration.underline,
                  color: Colors.lightGreen,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20),
              ),
              Text(
                'You will recieve notification at the Acception of your Request',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  decoration: TextDecoration.none,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 70,),
              RaisedButton(
                color: Colors.lightGreen,
                child: Text(
                  'Cancel Request',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                onPressed: () async {

                  await _jobRequest.removeFromPending('job' + sp.getInt('jobCount').toString(), sp.getString('userId'));
                  sp.setInt('jobCount', sp.getInt('jobCount')-1);

                  //clear data for next worker request

                  backToHome();
                }

    //  padding: EdgeInsets.only(top: 20),
              )
            ],
          ),
        ));
  }

backToHome(){
   sp.remove('workerId');
  sp.remove('workerName');
  sp.remove('workerContact');
  sp.remove('workerImg');
  sp.remove('job');
  sp.remove('subJob');
  sp.remove('subJobFields');
  sp.remove('subJobsCounter');
  sp.remove('subJobsPrice');
  sp.remove('date');
  sp.remove('time');
  var count = 0;
  Navigator.popUntil(context, (route) {
    return count++ == 4;
  });
}

  void _onItemTapped(int index) {
    setState(() {
    });
  backToHome();
  }
}

