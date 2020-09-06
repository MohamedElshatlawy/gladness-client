class NotificationModel{
  String id;
  String title;
  String body;
  String imgPath;
  NotificationModel({this.id,this.imgPath,this.title,this.body});

  NotificationModel.fromJson(String id,Map<String,dynamic> json){
    this.id=id;
    this.title=json['title'];
    this.body=json['body'];
    this.imgPath=json['imgPath'];
  }
}