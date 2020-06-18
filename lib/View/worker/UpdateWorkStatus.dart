import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:home_well/Model/WorkerModel/WorkerProfileModel.dart';
import 'package:home_well/View/worker/w_drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

import 'w_profile.dart';


final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
final TextEditingController _name = new TextEditingController();

class WUpdateStatus extends StatefulWidget {
  final String uid;

  const WUpdateStatus({Key key, this.uid}) : super(key: key);

  @override
  _WUpdateStatusState createState() => _WUpdateStatusState(uid);
}
SharedPreferences sp;
String sDate,eDate, sTime,eTime;
class _WUpdateStatusState extends State<WUpdateStatus> {
  String uid;

  WorkerDataFromFireStore  updateDataFromFireStore = new WorkerDataFromFireStore ();


  void initState() {
    initSp();
    super.initState();

  }
  initSp() {
    updateDataFromFireStore.getSharedPreferences().then((value) {
      setState(() {
        sp = value;

      });
    });
  }

  _WUpdateStatusState(this.uid);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Update Availability Status',
            style: new TextStyle(
                fontSize: 20.0,
                color: Colors.black,
                fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.lightGreen,
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => WorkerDrawerOnly()));
              }),
        ),
        body: Container(
          padding: EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text('Start Date And Time',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      decoration: TextDecoration.none,
                    )),

                SizedBox(
                  height: 20,
                ),
                Text('Date',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Colors.lightGreen,
                      fontSize: 18.0,
                    )),
                Padding(
                    padding: EdgeInsets.fromLTRB(18, 0, 18, 18),
                    child: DateField()),
                Text("Time",
                    style: TextStyle(
                      color: Colors.lightGreen,
                      fontSize: 18.0,
                    )),
                Padding(
                    padding: EdgeInsets.fromLTRB(18, 0, 18, 18),
                    child: TimeField()),

                ////////////////////


                Text('End Date And Time',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      decoration: TextDecoration.none,
                    )),

                SizedBox(
                  height: 20,
                ),
                Text('Date',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Colors.lightGreen,
                      fontSize: 18.0,
                    )),
                Padding(
                    padding: EdgeInsets.fromLTRB(18, 0, 18, 18),
                    child: DateField()),
                Text("Time",
                    style: TextStyle(
                      color: Colors.lightGreen,
                      fontSize: 18.0,
                    )),
                Padding(
                    padding: EdgeInsets.fromLTRB(18, 0, 18, 18),
                    child: TimeField()),
               /////////////////
                Padding(
                  padding: EdgeInsets.only(top: 10),
                ),
                Container(
                    width: 330,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.lightGreen)),
                      color: Colors.lightGreen,
                      child: Text(
                        'Update',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      onPressed: () async {
                      //  if (_formKey.currentState.validate()) {


                        updateDataFromFireStore.updateData(
                            uid, 'StartDate', sDate);
                        updateDataFromFireStore.removeValueFromSP('sdate');
                        updateDataFromFireStore.save('sdate', sDate);

                        updateDataFromFireStore.updateData(
                            uid, 'EndDate', eDate);
                        updateDataFromFireStore.removeValueFromSP('edate');
                        updateDataFromFireStore.save('edate', eDate);

                        updateDataFromFireStore.updateData(
                            uid, 'StartTime', sTime);
                        updateDataFromFireStore.removeValueFromSP('stime');
                        updateDataFromFireStore.save('stime', sTime);

                        updateDataFromFireStore.updateData(
                            uid, 'EndTime', eTime);
                        updateDataFromFireStore.removeValueFromSP('etime');
                        updateDataFromFireStore.save('etime', eTime);


                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => WorkerDrawerOnly()));
                     //   }
                      }, //  padding: EdgeInsets.only(top: 20),
                    )),
              ],
            ),
          ),
        ));
  }
}
class DateField extends StatelessWidget {


  final format = DateFormat.yMMMd();



  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      DateTimeField(
        format: format,
        onShowPicker: (context, currentValue) async{
          final date = await showDatePicker (
              context: context,
              firstDate: DateTime(1900),
              initialDate: currentValue ?? DateTime.now(),
              lastDate: DateTime(2100));
          String date1 = date.toString().substring(0,10);
          sp.setString('date', date1);
        sDate=eDate;
        eDate=date1;

          return date;

        },
      ),

    ]);
  }
}

class TimeField extends StatelessWidget {
  final format = DateFormat.jm();



  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      DateTimeField(
        format: format,
        onShowPicker: (context, currentValue) async {
          final time = await showTimePicker(
            context: context,
            initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
          );
          String time1 = DateTimeField.convert(time).toString().substring(11,16);
          sp.setString('time', time1);
          sTime=eTime;
          eTime=time1;

          return DateTimeField.convert(time);
        },
      ),
    ]);
  }
}
