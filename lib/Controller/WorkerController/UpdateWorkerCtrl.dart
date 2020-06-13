import 'package:home_well/Controller/WorkerController/rigesterWorker.dart';
import 'package:home_well/Model/WorkerModel/WorkerProfileModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

WorkerDataFromFireStore dataFromFireStore = new WorkerDataFromFireStore();
SharedPreferences sp;
class UpdateWorkerData{

 // WorkerData _workerData;

  updateRating(String workerId, var rating){
    dataFromFireStore.getSharedPreferences().then((value) => sp=value);

    //_workerData = dataFromFireStore.getWorkerData(workerId);
    double preRating = sp.getDouble('rating');
    int preRater = sp.getInt('rater');
    double newRating = (((preRating*preRater)+ rating)/(preRater+1));
    double finalRating = double.parse((newRating).toStringAsFixed(1)).toDouble();
    print(finalRating);
    dataFromFireStore.updateData(workerId, 'Rating', finalRating.toInt());
    dataFromFireStore.updateData(workerId, 'Rater', preRater+1);
     }

  updateFeedback(String workerId, String fb){
    dataFromFireStore.updateFeedBack(workerId, 'fb'+(sp.getInt('rater')+1).toString(), fb);
  }

}