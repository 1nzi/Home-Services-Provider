import 'package:flutter/material.dart';

import '../customer/c_login.dart';
import '../worker/w_login.dart';

class Home extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Well Home',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
      ),

      home: HomeScreenPage(title: 'Well Home'),
    );
  }
}
class HomeScreenPage extends StatefulWidget
{
  HomeScreenPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreenPage> {
  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;

    return Scaffold(
        resizeToAvoidBottomPadding: true,
        appBar: AppBar(
            title: Text(widget.title),
          ),
      body: Center(
            child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),
                  Image.asset('Images/home.jpg'),

                  Container(
                      width: media.width*0.60,
                      child:RaisedButton(
                        color: Colors.lightGreen,
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0),),

                        onPressed: () {
                          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => CustomerLogin()));
                  },
                        child: Text(
                          "Login As Customer",
                          style: TextStyle(color: Colors.black, fontSize: 20),
                        ),
                      )
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                  ),
                  Container(
                      width: media.width*0.60,
                      child:RaisedButton(
                        color: Colors.lightGreen,
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0),),

                        onPressed: ()  {
                          Navigator.pop(context);
                          Navigator.push(context,
                              new MaterialPageRoute(builder: (context) => new WorkerLogin()));
                        },
                        child: Text(
                          "Login As Worker",
                          style: TextStyle(color: Colors.black, fontSize: 20),
                        ),
                      )
                  ),
                ]
      ),
          )
    );
  }
}