class ExtraVatModel{
  String id;
  String txt;

  ExtraVatModel({this.id,this.txt});

  toMap()=>{
    "vat":this.txt
  };
}