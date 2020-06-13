import 'package:flutter/material.dart';


class AboutUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: new ThemeData(
            primarySwatch: Colors.lightGreen),

        home: Scaffold(
            resizeToAvoidBottomPadding: false,
            appBar: AppBar(
              title: Text("About Us",),
            ),
            body:  Container(
              height: 1200,
              padding: EdgeInsets.all(10.0),
              child: Column(


                  children: <Widget>[
                    SizedBox(height: 12),


                    Text(
                      'Home Services Provider',
                      textAlign: TextAlign.center,

                      style: TextStyle(

                        color: Colors.green,
                        fontSize: 25.0,
                        fontWeight:FontWeight.bold,
                        fontFamily: 'Indies',


                      ),
                    ),
                    SizedBox(height: 10),

                    Text('Home Services Provider is a fast and '' reliable solution for your home maintenance needs. Tell us what you need, where and when you need it, and we’ll connect you with the right professional. An Electrical Wiring or a broken air conditioner tends to happen at the worst time possible, but this is where we come in.',
                      textAlign: TextAlign.center,

                      style: TextStyle(

                        color: Colors.black,
                        fontSize: 17.0,



                      ),
                    ),
                    Text('Home Services Provider makes it incredibly easy to find the right person for your home maintenance needs, be it for routine maintenance or for a home emergency.'
                      ,
                      textAlign: TextAlign.center,

                      style: TextStyle(

                        color: Colors.black,
                        fontSize: 17.0,



                      ),
                    ),






                    SizedBox(height: 10),
                    Column(
                        children: <Widget>[


                          Container(
                            alignment: Alignment.centerLeft,

                            padding: const EdgeInsets.all(10.0),

                            decoration: BoxDecoration(

                              border: Border(
                                top: BorderSide(width: 0.3, color: Colors.grey),
                                bottom: BorderSide(width: 0.3, color: Colors.grey),

                              ),


                            ),
                            child: Row(
                                children: <Widget>[

                                  Icon(Icons.phone,color: Colors.lightGreen,),
                                  Text("   +9233-8967456"),

                                ] ),




                          ),
                          Container(
                            alignment: Alignment.centerLeft,

                            padding: const EdgeInsets.all(10.0),

                            decoration: BoxDecoration(

                              border: Border(
                                top: BorderSide(width: 0.3, color: Colors.grey),
                                bottom: BorderSide(width: 0.3, color: Colors.grey),

                              ),


                            ),
                            child: Row(
                                children: <Widget>[

                                  Icon(Icons.email,color: Colors.lightGreen),
                                  Text("   help@gmail.com"),

                                ] ),




                          ),


                          Container(
                            alignment: Alignment.centerLeft,

                            padding: const EdgeInsets.all(10.0),

                            decoration: BoxDecoration(

                              border: Border(
                                top: BorderSide(width: 0.3, color: Colors.grey),
                                bottom: BorderSide(width: 0.3, color: Colors.grey),

                              ),


                            ),
                            child: Row(
                                children: <Widget>[

                                  Icon(Icons.pin_drop,color: Colors.lightGreen,),
                                  Text("    Lahore Pakistan"),

                                ] ),




                          ),
                          Container(
                            alignment: Alignment.centerLeft,

                            padding: const EdgeInsets.all(10.0),

                            decoration: BoxDecoration(

                              border: Border(
                                top: BorderSide(width: 0.3, color: Colors.grey),
                                bottom: BorderSide(width: 0.3, color: Colors.grey),

                              ),


                            ),
                            child: Row(
                                children: <Widget>[

                                  Icon(Icons.android,color: Colors.lightGreen,),
                                  Text("   Android-Version 1.0.0"),

                                ] ),




                          )
                        ]
                    )
                  ]
              )

              ,
            )
        )
    );

  }
}

