class ProductModel {
  String id;
  String categoryName;
  String categoryId;
  Map<String, dynamic> priceList;
  String vendorID;
  String vendorName;
  List<dynamic>galleryPaths;

  int quantity;

  ProductModel({
    this.id,
    this.priceList,
    this.categoryId,
    this.categoryName,
    this.vendorID,
    this.galleryPaths,
    this.vendorName,
  });

  ProductModel.fromJson({String id, Map<String, dynamic> json}) {
    this.id = id;

    this.categoryId = json['categoryID'];
    this.categoryName = json['categoryName'];

    this.vendorID = json['vendorID'];
    this.vendorName = json['vendorName'];
    this.priceList = json['priceList'];
    this.galleryPaths=json['gallery'];
  }

  toMap() => {
        "categoryID": this.categoryId,
        "categoryName": this.categoryName,
        "priceList": this.priceList,
        "vendorID": this.vendorID,
        "vendorName": this.vendorName,
        "gallery":this.galleryPaths
      };
}
