import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:home_well/Controller/WorkerController/UpdateWorkerCtrl.dart';
import 'package:home_well/Controller/WorkerController/rigesterWorker.dart';

import 'c_pending_task.dart';

class RatingBar extends StatefulWidget {
  final Task task;

  const RatingBar({Key key, this.task}) : super(key: key);

  @override
  _RatingBarState createState() => _RatingBarState(task);
}

UpdateWorkerData _updateWorkerData = new UpdateWorkerData();
final TextEditingController _feedback = new TextEditingController();
var rating;
class _RatingBarState extends State<RatingBar> {
  final Task task;

  _RatingBarState(this.task);

  @override
  Widget build(BuildContext context) {
    return new AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      title: Center(
        child: const Text(
          'Rate Worker',
          style: TextStyle(
              color: Colors.black, fontSize: 24.0, fontWeight: FontWeight.bold),
        ),
      ),
      content: SingleChildScrollView(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          new Container(
              width: 120.0,
              height: 120.0,
              decoration: new BoxDecoration(
                  shape: BoxShape.circle,
                  image: new DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(task.workerImage)))),
              SizedBox(
                height: 10,
              ),
              Text(
                task.workerName,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                ),
              ),
              FlutterRatingBar(
                initialRating: 3,
                itemSize: 30,
                fillColor: Colors.lightGreen,
                borderColor: Colors.lightGreen.withAlpha(100),
                allowHalfRating: true,
                onRatingUpdate: (ratingValue) {
                  rating = ratingValue;
                },
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 180,
                width: 220,
                child: Stack(
                  children: <Widget>[
                    TextField(
                      maxLines: 10,
                      controller: _feedback,
                      decoration: InputDecoration(
                          hintText: "Type Your FeedBack",
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          )),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                      width: 90,
                      child: RaisedButton(
                        color: Colors.lightGreen,
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0),
                        ),
                        onPressed: () {
                          var count = 0;
                          Navigator.popUntil(context, (route) {
                            return count++ == 3;
                          });
                          _updateWorkerData.updateRating(task.workerId, rating);
                          if(_feedback.text!=null){
                            _updateWorkerData.updateFeedback(task.workerId, _feedback.text);
                          }
                        },
                        child: Text(
                          "Submit",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      )),
                  Container(
                      width: 90,
                      child: RaisedButton(
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0),
                        ),
                        color: Colors.lightGreen,
                        onPressed: () {

                          var count = 0;
                          Navigator.popUntil(context, (route) {
                            return count++ == 3;
                          });
                        },
                        child: Text(
                          "Skip",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      )),
                ],
              ),
            ],
          )),
        );
      }
    }
