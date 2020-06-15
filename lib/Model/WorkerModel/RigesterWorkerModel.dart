import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:home_well/Controller/WorkerController/rigesterWorker.dart';

class DatabaseService {
  final String uid;

  DatabaseService({this.uid});

  //collection reference
  final CollectionReference workerCollection = Firestore.instance.collection('Worker');

  Future <void> updateWorkerData(WorkerData bundle) async {
    String imgUrl;
    String cincFrontUrl ;
    String cnicBackUrl ;

    //upload image & cnic pics to firebase storage
      //profile image
      StorageReference firebaseStorageRef = FirebaseStorage.instance.ref()
          .child(bundle.imagePath);
      StorageUploadTask uploadTask = firebaseStorageRef.putFile(bundle.image);
      StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
      imgUrl = await taskSnapshot.ref.getDownloadURL();

      //cnic front
       firebaseStorageRef = FirebaseStorage.instance.ref()
          .child(bundle.cnicFrontPath);
       uploadTask = firebaseStorageRef.putFile(bundle.cnicFrontimage);
       taskSnapshot = await uploadTask.onComplete;
      cincFrontUrl = await taskSnapshot.ref.getDownloadURL();

      //cnic back
       firebaseStorageRef = FirebaseStorage.instance.ref()
          .child(bundle.cnicBackPath);
       uploadTask = firebaseStorageRef.putFile(bundle.cnicBackimage);
       taskSnapshot = await uploadTask.onComplete;
      cnicBackUrl = await taskSnapshot.ref.getDownloadURL();


    //upload worker data to firebase

    await workerCollection.document(uid).setData({
      'Id': uid,
      'Name': bundle.fname,
      'Cnic': bundle.cnic,
      'Phone': bundle.ph,
      'Email': bundle.email,
      'City': bundle.city,
      'Area': bundle.area,
      'Job': bundle.job,
      'SubJobs': FieldValue.arrayUnion(bundle.subJobs),
      'Password': bundle.password,
      'Image': imgUrl,
      'CnicFront': cincFrontUrl,
      'CnicBack': cnicBackUrl,
      'Rating': 0,
    });
  }
}

