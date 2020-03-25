import 'package:home_well/Controller/WorkerController/rigesterWorker.dart';
import 'package:home_well/Model/WorkerModel/WorkerProfileModel.dart';

WorkerDataFromFireStore dataFromFireStore = new WorkerDataFromFireStore();
class UpdateWorkerData{

  WorkerData _workerData;

  updateRating(String workerId, var rating){
    _workerData = dataFromFireStore.getWorkerData(workerId);
    double preRating = _workerData.rating;
    int preRater = _workerData.rater;
    double newRating = (((preRating*preRater)+ rating)/(preRater+1));
    double finalRating = double.parse((newRating).toStringAsFixed(1)).toDouble();
    print(finalRating);
    dataFromFireStore.updateData(workerId, 'Rating', finalRating);
    dataFromFireStore.updateData(workerId, 'Rater', preRater+1);
     }

  updateFeedback(String workerId, String fb){

    dataFromFireStore.updateFeedBack(workerId, 'fb'+(_workerData.rater+1).toString(), fb);
  }

}