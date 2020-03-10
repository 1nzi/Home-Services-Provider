
class WorkerData {
  String workerId;
  String name;
  String cnic;
  String ph;
  String email;
  String city;
  String area;
  String job;
  var subJobs = new List();
  String password;
  String imagePath;
  dynamic image;
  String cnicFrontPath;
  dynamic cnicFrontimage;
  String cnicBackPath;
  dynamic cnicBackimage;

  WorkerData({this.name,
    this.cnic,
    this.ph,
    this.email,
    this.city,
    this.area,
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