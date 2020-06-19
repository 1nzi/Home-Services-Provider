import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WorkerHistory extends StatelessWidget {
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
          backgroundImage: AssetImage('https://firebasestorage.googleapis.com/v0/b/well-home.appspot.com/o/IMG-20200617-WA0013.jpg?alt=media&token=a4b18407-a6c2-42ad-9937-6c9f0e5b4329'),
        ),
        title: Text('Ali Raza'),
        subtitle: Text('Samanabad'),
        trailing: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [Text(formattedDate), Text('PKR:155')]),
      ),
      ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage(''),
        ),
        title: Text('Inzamam Asghar'),
        subtitle: Text('Rehmanpura Lahore'),
        trailing: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [Text(formattedDate), Text('PKR:1585')]),
      ),
      ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage(''),
        ),
        title: Text('Umar Akmal'),
        subtitle: Text('DHA'),
        trailing: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [Text(formattedDate), Text('PKR:5855')]),
      ),
      ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage(''),
        ),
        title: Text('Arslan Ahmed'),
        subtitle: Text('Rehmanpura Lahore'),
        trailing: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [Text(formattedDate), Text('PKR:5855')]),
      ),
      ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage(''),
        ),
        title: Text('Umar Akmal'),
        subtitle: Text('Rehmanpura Lahore'),
        trailing: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [Text(formattedDate), Text('PKR:5855')]),
      ),
      ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage('https://firebasestorage.googleapis.com/v0/b/well-home.appspot.com/o/IMG-20200617-WA0013.jpg?alt=media&token=a4b18407-a6c2-42ad-9937-6c9f0e5b4329'),
        ),
        title: Text('Ali Raza'),
        subtitle: Text('Rehmanpura Lahore'),
        trailing: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [Text(formattedDate), Text('PKR:5855')]),
      ),
      ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage(''),
        ),
        title: Text('Ali gul Pir'),
        subtitle: Text('Rehmanpura Lahore'),
        trailing: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [Text(formattedDate), Text('PKR:5855')]),
      ),
      ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage(''),
        ),
        title: Text('Ali gul Pir'),
        subtitle: Text('Rehmanpura Lahore'),
        trailing: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [Text(formattedDate), Text('PKR:5855')]),
      ),
      ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage(''),
        ),
        title: Text('Ali gul Pir'),
        subtitle: Text('Rehmanpura Lahore'),
        trailing: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [Text(formattedDate), Text('PKR:5855')]),
      ),
      ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage(''),
        ),
        title: Text('Ali gul Pir'),
        subtitle: Text('Rehmanpura Lahore'),
        trailing: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [Text(formattedDate), Text('PKR:5855')]),
      ),
      ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage(''),
        ),
        title: Text('Ali gul Pir'),
        subtitle: Text('Rehmanpura Lahore'),
        trailing: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [Text(formattedDate), Text('PKR:5855')]),
      ),
      ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage(''),
        ),
        title: Text('Ali gul Pir'),
        subtitle: Text('Rehmanpura Lahore'),
        trailing: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [Text(formattedDate), Text('PKR:5855')]),
      ),
    ],
  ).toList());
}
