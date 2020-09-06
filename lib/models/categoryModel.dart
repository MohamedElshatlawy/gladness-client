class CategoryModel {
  String id;
  String name;
  String imgPath;

  CategoryModel({this.id, this.name, this.imgPath});

  toMap() => {"name": this.name, "imgPath": this.imgPath};
}
