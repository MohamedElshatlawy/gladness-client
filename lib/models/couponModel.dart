class CouponModel{
  String id;
  String coupon;
  String discountValue;
  String description;

  CouponModel({this.discountValue,this.coupon,this.id,this.description});

  toMap()=>{
    "coupon":this.coupon,
    "description":this.description,
    "discountValue":this.discountValue
  };
}