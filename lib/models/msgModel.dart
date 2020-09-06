class MsgModel{
  String id;
  String name;
  String phone;
  String mail;
  String msg;
  MsgModel({this.id,this.mail,this.msg,this.name,this.phone});

  toMap()=>{
    "name":this.name,
    "phone":this.phone,
    "mail":this.mail,
    "msg":this.msg
  };
}