import 'package:home_well/Controller/CustomerController/customerProfile.dart';
import 'package:home_well/Controller/CustomerController/rigesterCustomer.dart';

import 'c_history_screen.dart';
import 'c_login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'c_pending_task.dart';
import 'c_profile.dart';

CustomerDataFromFireStore customerDataFromFireStore =
    new CustomerDataFromFireStore();

class CustomerDrawerOnly extends StatelessWidget {
  final CustomerData user;

  const CustomerDrawerOnly({Key key, this.user,}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return new Drawer(
        child: new ListView(
      children: <Widget>[
        new DrawerHeader(
          child: Column(
            children: <Widget>[
              new Container(
                width: 100,
                height: 100,
                decoration: new BoxDecoration(
                  shape: BoxShape.circle,
                  image: new DecorationImage(
                      fit: BoxFit.cover,
                      image: new NetworkImage(
                        user.image!=null?user.image
                            :"https://previews.123rf.com/images/tuktukdesign/tuktukdesign1606/tuktukdesign160600105/59070189-user-icon-man-profile-businessman-avatar-person-icon-in-vector-illustration.jpg"),
                  ),
                ),
              ),
              Text(
                user.fname!=null?user.fname:'Name',
                textAlign: TextAlign.center,
              )
            ],
          ),
          decoration: new BoxDecoration(color: Colors.lightGreen),
        ),
        new ListTile(
          leading:
              Icon(Icons.person_outline, color: Colors.lightGreen, size: 24),
          title: Text('Profile'),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(context,
                new MaterialPageRoute(builder: (context) => new Profile(user: user)));
          },
        ),
        new ListTile(
          leading: Icon(Icons.account_balance_wallet,
              color: Colors.lightGreen, size: 24),
          title: new Text(
            "My Wallet",
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
          leading:
              Icon(Icons.notifications, color: Colors.lightGreen, size: 24),
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
