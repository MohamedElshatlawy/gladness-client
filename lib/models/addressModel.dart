class AddressModel{
  String id;
  String address;
  String phone;
  bool isEnabled;

AddressModel({this.id,this.address,this.isEnabled,this.phone});

AddressModel.fromJson({String id,Map<String,dynamic> json}){
  this.id=id;
  this.address=json['address'];
  this.phone=json['phone'];
  this.isEnabled=json['enabled'];
}
  toMap()=>{
    "address":this.address,
    "phone":this.phone,
    "enabled":this.isEnabled
  };
}