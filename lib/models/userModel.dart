class UserModel {
  String userToken;
  String email;
  String profileImg;
  String name;
  String phone;

  UserModel({this.email, this.userToken, this.profileImg, this.name});

  UserModel.fromJson(Map<String, dynamic> json, String token,String phone) {
    this.email = json['email']??null;
    this.userToken = token;
    this.name = json['name']??null;
    this.profileImg = json['profile']??null;
    this.phone=phone;
  }

  toMap() =>
      {"email": this.email, "name": this.name, "profile": this.profileImg};
}
