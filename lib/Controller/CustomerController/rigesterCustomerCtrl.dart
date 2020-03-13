
class CustomerData {
  String userId;
  String fname;
  String gender;
  String ph;
  String email;
  String city;
  String area;
  String address;
  String job;
  String subJob;
  int jobCount;
  var subJobFields = new List();
  String date;
  String time;
  String workerId;
  String workerName;
  String workerContact;
  String workerImg;
  String password;
  String imagePath;
  dynamic image;

  CustomerData({
    this.userId,
    this.fname,
    this.gender,
    this.ph,
    this.email,
    this.city,
    this.area,
    this.address,
    this.job,
    this.subJob,
    this.jobCount,
    this.subJobFields,
    this.date,
    this.time,
    this.workerId,
    this.workerName,
    this.workerContact,
    this.workerImg,
    this.password,
    this.imagePath,
    this.image,
  });
}