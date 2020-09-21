class ReservationModel {
  String firebaseID;
  String clientID;
  Map<String, dynamic> selectedItems;
  String selectedDate;
  String selectedTime;
  String totalPrice;
  String paymentMethod;
  String notes;
  String status;
  String reject_reason;
  String vendorName;
  int timeStamp;
  ReservationModel.fromJson({String id, Map<String, dynamic> json}) {
    this.firebaseID = id;
    this.vendorName = json['vendor_name'] ?? "";
    this.clientID = json['client_id'];
    this.selectedItems = json['selected_items'];
    this.selectedDate = json['selected_date'];
    this.totalPrice = json['total'];
    this.paymentMethod = json['payment'];
    this.notes = json['notes'];
    this.timeStamp = json['time_stamp'];
    this.status = json['status'];
    this.selectedTime = json['selected_time'];
    this.reject_reason = json['reject_reason'];
  }
  ReservationModel(
      {this.selectedTime,
      this.notes,
      this.paymentMethod,
      this.totalPrice,
      this.selectedDate,
      this.selectedItems,
      this.clientID,
      this.vendorName,
      this.firebaseID});
  toMap() => {
        "client_id": this.clientID,
        "selected_items": this.selectedItems,
        "selected_date": this.selectedDate,
        "total": this.totalPrice,
        "payment": this.paymentMethod,
        "notes": this.notes,
        "time_stamp": DateTime.now().millisecondsSinceEpoch,
        "status": "sent",
        "vendor_name": this.vendorName,
        "selected_time": this.selectedTime
      };
}
