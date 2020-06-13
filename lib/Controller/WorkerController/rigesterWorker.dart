
class WorkerData {
  String workerId;
  String fname;
  String cnic;
  String ph;
  String email;
  String city;
  String area;
  double rating;
  int rater;
  String job;
  var subJobs = new List();
  String password;
  String imagePath;
  dynamic image;
  String cnicFrontPath;
  dynamic cnicFrontimage;
  String cnicBackPath;
  dynamic cnicBackimage;

  WorkerData({this.fname,
    this.cnic,
    this.ph,
    this.email,
    this.city,
    this.area,
    this.rating,
    this.rater,
    this.job,
    this.subJobs,
    this.password,
    this.imagePath,
    this.image,
    this.cnicFrontPath,
    this.cnicFrontimage,
    this.cnicBackPath,
    this.cnicBackimage,
  });
}