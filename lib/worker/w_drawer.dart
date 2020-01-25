import 'package:home_well/worker/w_pending_task.dart';
import 'package:home_well/worker/w_wallet.dart';
import 'package:home_well/worker/w_profile.dart';
import 'package:home_well/worker/w_worker_history.dart';

import 'w_login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WorkerDrawerOnly extends StatelessWidget {
  @override
  Widget build (BuildContext context) {
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
              decoration: new BoxDecoration(
                  color: Colors.lightGreen
              ),
            ),
            new ListTile(
              leading: Icon(Icons.person_outline, color: Colors.lightGreen, size:24),
              title: new Text("My Profile",
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) => new WorkerProfile()));
              },
            ),
            new ListTile(
              leading: Icon(Icons.account_balance_wallet, color: Colors.lightGreen, size:24),
              title: new Text("My Wallet",
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) => new Wallet()));
              },
            ),
            new ListTile(
              leading: Icon(Icons.assignment, color: Colors.lightGreen, size:24),
              title: new Text("Pending Task",
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) => new WorkerPendingTask()));
              },
            ),
            new ListTile(
              leading: Icon(Icons.history, color: Colors.lightGreen, size:24),
              title: new Text("History",
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) => new WorkerHistory()));
              },
            ),

            new ListTile(
              leading: Icon(Icons.info, color: Colors.lightGreen, size:24),
              title: new Text("About Us",),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) => new WorkerLogin()));
              },
            ),
            new ListTile(
              leading: Icon(Icons.exit_to_app, color: Colors.lightGreen, size:24),
              title: new Text("Logout",
              ),
              onTap: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) => new WorkerLogin()));
              },
            ),
          ],
        )
    );
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


