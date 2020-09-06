class OrderModel {
  String id;
  String userID;
  String address;
  String phone;
  Map<String, dynamic> productsQuantity;
  String notes;
  String coupon;
  String couponValue;
  String paymentType;
  String total;
  String totalCost;
  String deliveryCost;
  String orderStatus;
  int timeStamp;
  String reasonOfReject;

  OrderModel(
      {this.id,
      this.userID,
      this.address,
      this.phone,
      this.productsQuantity,
      this.notes,
      this.coupon,
      this.couponValue,
      this.paymentType,
      this.total,
      this.timeStamp,
      this.totalCost,
      this.reasonOfReject,
      this.deliveryCost,
      this.orderStatus});

  OrderModel.fromjson({String id, Map<String, dynamic> json}) {
    this.id = id;
    this.userID = json['userID'];
    this.address = json['address'];
    this.phone = json['phone'];
    this.productsQuantity = json['products'];
    this.notes = json['notes'];
    this.coupon = json['coupon'];
    this.couponValue = json['couponValue'];
    this.paymentType = json['paymentType'];
    this.total = json['total'];
    this.totalCost = json['totalCost'];
    this.deliveryCost = json['deliveryCost'];
    this.orderStatus = json['orderStatus'];
    this.timeStamp = json['timeStamp'];
    this.reasonOfReject = json['reasonOfReject'];
  }

  toMap() => {
        "userID": this.userID,
        "address": this.address,
        "phone": this.phone,
        "products": this.productsQuantity,
        "notes": this.notes,
        "coupon": this.coupon,
        "couponValue": this.couponValue,
        "paymentType": this.paymentType,
        "total": this.total,
        "totalCost": this.totalCost,
        "deliveryCost": this.deliveryCost,
        "orderStatus": this.orderStatus,
        "timeStamp": this.timeStamp,
        "reasonOfReject": this.reasonOfReject
      };
}
