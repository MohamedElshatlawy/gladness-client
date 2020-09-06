class ContactPhoneNumberModel{
  String id;
  String phone;

  ContactPhoneNumberModel({this.id,this.phone});

  toMap()=>{
    "phone":this.phone
  };
}