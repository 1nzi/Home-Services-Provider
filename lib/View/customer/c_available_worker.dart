import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'c_wait_for_response.dart';

class AvailableWorker extends StatefulWidget {

  _MyWorkerPageState createState() => _MyWorkerPageState();
}

class _MyWorkerPageState extends State<AvailableWorker> {
  final List<Worker> worker = WorkerList.getWorker();

  Widget _buildWorkerList() {
    return Container(
      child: worker.length > 0
          ? ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: worker.length,
          itemBuilder: (BuildContext context, int index) {
            return WorkerCard(worker: worker[index]);
          }
      )
          : Center(child: Text('No Items')),
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: new AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            }),

        title: new Text("Available Worker",
          style: new TextStyle(
              fontSize: 20.0, color: Colors.black, fontWeight: FontWeight.bold),
        ),

      ),

      bottomNavigationBar: new BottomNavigationBar(items: [
        new BottomNavigationBarItem(
          icon: new Icon(Icons.home),
          title: new Text("Home"),
        ),
        new BottomNavigationBarItem(
          icon: new Icon(Icons.search),
          title: new Text("Search"),
        )
      ]),


      body: _buildWorkerList(),


    );

  }
}
class Worker {
  final String title;
  final String subtitle;
  final String imageUrl;

  Worker(this.title, this.subtitle, this.imageUrl);

}

class WorkerList {
  static List<Worker> getWorker() {
    return [
      Worker(
          'Inzamam Asghar',
          '4.5',
          'Images/inzi.jpg'
      ),
      Worker(
          'Mubeen Dar',
          '4.8',
          'Images/dari.PNG'
      ),


      Worker(
          'Arslan Ahmad',
          '4.9',
          'Images/rana.jpg'
      ),

      Worker(
          'Almas Asghar',
          '4.3',
          'Images/download.png'
      ),
    ];
  }
}

class WorkerCard extends StatelessWidget {
  final Worker worker;

  const WorkerCard({ this.worker});


  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 8.0,
        margin: new EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        child: Container(
          decoration: BoxDecoration(color: Colors.black12),

          child: Column(
            children: <Widget>[
              ListTile(
                leading:Container(
                  width: 60.0,
                  height: 100.0,
                  decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      image: new DecorationImage(fit: BoxFit.fill, image:AssetImage( worker.imageUrl))),
                ),

                title: Text(worker.title,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontSize: 14.0,

                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold

                  ),
                ),
                subtitle:Row( children: <Widget>[
                  Text(worker.subtitle),
                  Icon(Icons.star)
                ]),
                trailing: RequestButton(),
              )
            ],
          ),
        )
    );
  }
}


class RequestButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70.0,
      height: 30.0,
      child: RaisedButton(
        elevation: 1.0,
        textColor: Colors.black,
        color: Colors.lightGreen,
        child: Text(
          "Request",
          textAlign: TextAlign.start,
          style: TextStyle(
              fontSize: 9.0,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.bold

          ),
        ),
        onPressed: () {
          Navigator.pop(context);
          Navigator.push(context,
              MaterialPageRoute(builder: (context)=>ResponseWait()));

        },
      ),
    );
  }
}
