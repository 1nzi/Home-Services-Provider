import 'c_history_screen.dart';
import 'c_login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'c_pending_task.dart';
import 'c_profile.dart';

class CustomerDrawerOnly extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Drawer(
        child: new ListView(
          children: <Widget>[
            new DrawerHeader(
              child: Column(
                children: <Widget>[
                  ImageAsset(),
                  Text(
                    'Name',
                    textAlign: TextAlign.center,
                  )
                ],
              ),
              decoration: new BoxDecoration(color: Colors.lightGreen),
            ),
            new ListTile(
              leading: Icon(Icons.person_outline, color: Colors.lightGreen, size: 24),
              title: new Text(
                "My Profile",
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                  new MaterialPageRoute(builder: (context) => new Profile()));
          },
        ),
            new ListTile(
              leading: Icon(Icons.account_balance_wallet, color: Colors.lightGreen,  size: 24),
              title: new Text(
                "My Wallet",
              ),
             onTap: () {
              Navigator.pop(context);
              Navigator.push(context,
                  new MaterialPageRoute(
                      builder: (context) => new CustomerLogin()));
            },
        ),
            new ListTile(
              leading: Icon(Icons.assignment, color: Colors.lightGreen, size: 24),
              title: new Text(
                "Pending Tasks",
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => new CustomerPendingTask()));
              },
            ),

            new ListTile(
              leading: Icon(Icons.history, color: Colors.lightGreen, size: 24),
              title: new Text(
                "History",
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => new CustomerHistory()));
              },
            ),
            new ListTile(
              leading: Icon(Icons.notifications, color: Colors.lightGreen, size: 24),
              title: new Text(
                "Notifications",
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => new CustomerLogin()));
              },
            ),
            new ListTile(
              leading: Icon(Icons.info, color: Colors.lightGreen, size: 24),
              title: new Text(
                "About Us",
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => new CustomerLogin()));
              },
            ),
            new ListTile(
              leading: Icon(Icons.exit_to_app, color: Colors.lightGreen, size: 24),
              title: new Text(
                "Logout",
              ),
              onTap: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => new CustomerLogin()));
              },
        ),
      ],
    ));
  }
}

class ImageAsset extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AssetImage assetImage = AssetImage('Images/download.png');

    return Container(
      width: 100.0,
      height: 100.0,
      decoration: new BoxDecoration(
          shape: BoxShape.circle,
          image: new DecorationImage(fit: BoxFit.fill, image: assetImage)),
    );
  }
}

class LeadingIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AssetImage assetImage = AssetImage('Images/download.png');

    return Container(
      width: 100.0,
      height: 100.0,
      decoration: new BoxDecoration(
          image: new DecorationImage(fit: BoxFit.fill, image: assetImage)),
    );
  }
}
