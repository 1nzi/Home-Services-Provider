import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class WorkerPendingTask extends StatefulWidget {

  _PendingTask createState() => _PendingTask();
}

class _PendingTask extends State<WorkerPendingTask> {
  final List<Task> task = TaskList.getTask();

  Widget _buildTaskList() {
    return Container(
      child: task.length > 0
          ? ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: task.length,
          itemBuilder: (BuildContext context, int index) {
            return TaskCard(task: task[index]);
          }
      )
          : Center(child: Text('No Pending Task')),
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: new AppBar(
        leading:IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: new Text("Pending Task",
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


      body: _buildTaskList(),


    );

  }
}
class Task {
  final String name;
  final String job;
  final String date;
  final String time;
  final String imageUrl;


  Task(this.name, this.job, this.date, this.time, this.imageUrl);

}

class TaskList {
  static List<Task> getTask() {
    return [
      Task(
          'Inzamam Asghar', 'Electrician', '12-02-2019', '12:00 pm', 'Images/inzi.jpg' ),
    ];
  }
}

class TaskCard extends StatelessWidget {
  final Task task;

  const TaskCard({ this.task});


  @override
  Widget build(BuildContext context) {
    return Card(
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
                      image: new DecorationImage(fit: BoxFit.fill, image:AssetImage( task.imageUrl))),
                ),

                title: Text(task.name,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontSize: 15.0,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                      color: Colors.black
                  ),
                ),
                subtitle:
                Text(task.job),
                trailing: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text(task.date), Text(task.time)]),
              )
            ],
          ),
        )
    );
  }
}
