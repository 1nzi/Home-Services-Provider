import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomerHistory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'History',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('History'),
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              }),
        ),
        body: BodyLayout(),
      ),
    );
  }
}

class BodyLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _myListView(context);
  }
}

DateTime now = DateTime.now();
String formattedDate = DateFormat('kk:mm:ss \n EEE d MMM').format(now);
// replace this function with the code in the examples
Widget _myListView(BuildContext context) {
  return ListView(
      children: ListTile.divideTiles(
    context: context,
    color: Colors.lightGreen,
    tiles: [
      ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage('Images/dari.PNG'),
        ),
        title: Text('Noor Ali'),
        subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [Text('Electrian'), Text('wiring,Capacitor')]),
        trailing: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [Text(formattedDate), Text('PKR:155')]),
      ),
      ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage('assets/images/2.jpg'),
        ),
        title: Text('Inzamam Asghar'),
        subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [Text('Plumber'), Text('tap,motor')]),
        trailing: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [Text(formattedDate), Text('PKR:1585')]),
      ),
      ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage('assets/images/3.jpg'),
        ),
        title: Text('Ali gul Pir'),
        subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [Text('Home Decor'), Text('Bride Room Decor')]),
        trailing: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [Text(formattedDate), Text('PKR:5855')]),
      ),
      ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage('assets/images/3.jpg'),
        ),
        title: Text('Ali gul Pir'),
        subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [Text('Home Decor'), Text('Bride Room Decor')]),
        trailing: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [Text(formattedDate), Text('PKR:5855')]),
      ),
      ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage('assets/images/3.jpg'),
        ),
        title: Text('Ali gul Pir'),
        subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [Text('Home Decor'), Text('Bride Room Decor')]),
        trailing: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [Text(formattedDate), Text('PKR:5855')]),
      ),
      ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage('assets/images/3.jpg'),
        ),
        title: Text('Ali gul Pir'),
        subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [Text('Home Decor'), Text('Bride Room Decor')]),
        trailing: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [Text(formattedDate), Text('PKR:5855')]),
      ),
      ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage('assets/images/3.jpg'),
        ),
        title: Text('Ali gul Pir'),
        subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [Text('Home Decor'), Text('Bride Room Decor')]),
        trailing: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [Text(formattedDate), Text('PKR:5855')]),
      ),
      ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage('assets/images/3.jpg'),
        ),
        title: Text('Ali gul Pir'),
        subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [Text('Home Decor'), Text('Bride Room Decor')]),
        trailing: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [Text(formattedDate), Text('PKR:5855')]),
      ),
      ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage('assets/images/3.jpg'),
        ),
        title: Text('Ali gul Pir'),
        subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [Text('Home Decor'), Text('Bride Room Decor')]),
        trailing: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [Text(formattedDate), Text('PKR:5855')]),
      ),
      ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage('assets/images/3.jpg'),
        ),
        title: Text('Ali gul Pir'),
        subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [Text('Home Decor'), Text('Bride Room Decor')]),
        trailing: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [Text(formattedDate), Text('PKR:5855')]),
      ),
      ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage('assets/images/3.jpg'),
        ),
        title: Text('Ali gul Pir'),
        subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [Text('Home Decor'), Text('Bride Room Decor')]),
        trailing: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [Text(formattedDate), Text('PKR:5855')]),
      ),
      ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage('assets/images/3.jpg'),
        ),
        title: Text('Ali gul Pir'),
        subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [Text('Home Decor'), Text('Bride Room Decor')]),
        trailing: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [Text(formattedDate), Text('PKR:5855')]),
      ),
      ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage('assets/images/2.jpg'),
        ),
        title: Text('Inzamam Asghar'),
        subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [Text('Plumber'), Text('tap,motor')]),
        trailing: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [Text(formattedDate), Text('PKR:1585')]),
      ),
      ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage('assets/images/2.jpg'),
        ),
        title: Text('Inzamam Asghar'),
        subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [Text('Plumber'), Text('tap,motor')]),
        trailing: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [Text(formattedDate), Text('PKR:1585')]),
      ),
    ],
  ).toList());
}
