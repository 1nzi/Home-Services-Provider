
class WorkerHistoryData {
  String workerId;
  String ph;
  String city;
  String area;
  String address;
  String job;
  String subJob;
  var subJobFields = new List();
  String date;
  String time;
  String customerId;
  String customerName;
  String customerImg;

  WorkerHistoryData({
    this.workerId,
    this.ph,
    this.city,
    this.area,
    this.address,
    this.job,
    this.subJob,
    this.subJobFields,
    this.date,
    this.time,
    this.customerId,
    this.customerName,
    this.customerImg,
  });
}