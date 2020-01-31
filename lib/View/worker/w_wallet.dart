import 'package:flutter/material.dart';

class Wallet extends StatefulWidget {
  @override
  _WalletState createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('My Wallet'),
          centerTitle: true,
          backgroundColor: Colors.lightGreen,
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              }),
        ),
        body: Container(
          padding: EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 330,
                height: 150,
                color: Color(0xffe5e5e5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text('PKR'),
                    Text(
                      '0',
                      style: TextStyle(
                        fontSize: 50,
                        //fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Text('Available balance'),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(15),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      width: 100,
                      height: 100,
                      color: Color(0xfff2f2f2),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.save_alt,
                              color: Colors.lightGreen,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Add amount',
                            ),
                          ]),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                  ),
                  Expanded(
                    child: Container(
                      width: 100,
                      height: 100,
                      color: Color(0xfff2f2f2),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.keyboard_tab,
                              color: Colors.lightGreen,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Send amount',
                            ),
                          ]),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
    );
  }
}
