

class VendorModel {
  String id;
  String name;
  String email;
  String phone;
  String optionalPhone;
  String commRec;
  String bio;
  String imgPath;
  String categoryID;
  String categoryName;
  Map<String, String> priceList = {};
  List<String> gallery=[];
  List<dynamic> regularHolidays;
  Map<String, dynamic> nonRegulars;
  VendorModel(
      {this.id,
      this.name,
      this.bio,
      this.commRec,
      this.email,
      this.imgPath,
      this.optionalPhone,
      this.categoryID,
      this.categoryName,
      this.priceList,
      this.phone});

  VendorModel.fromJson({String id, Map<String, dynamic> json}) {
    this.id = id;
    this.name = json['name'];
    this.email = json['email'];
    this.bio = json['bio'];
    this.commRec = json['comm_rec'];

    this.imgPath = json['img_path'];
    this.optionalPhone = json['optional_phone'];
    this.phone = json['phone'];
    this.categoryID = json['categoryID'];
    this.categoryName = json['categoryName'];

    this.regularHolidays=json['regular_holidays'];
    this.nonRegulars=json['non_regular_holidays'];
  }

  toMap() => {
        "name": this.name,
        "email": this.email,
        "bio": this.bio,
        "comm_rec": this.commRec,
        "img_path": this.imgPath,
        "optional_phone": this.optionalPhone,
        "phone": this.phone,
        "categoryID": this.categoryID,
        "categoryName": this.categoryName,
        "regular_holidays": this.regularHolidays,
        "non_regular_holidays": this.nonRegulars
      };
}
