class AboutUsModel{
  String id;
  String txt;

  AboutUsModel({this.id,this.txt});

  toMap()=>{
    "aboutus":this.txt
  };
}