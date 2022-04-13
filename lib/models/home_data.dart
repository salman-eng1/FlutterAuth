class HomeDataModel{
  late String image;
  HomeDataModel(this.image);
  HomeDataModel.fromJson(Map<String,dynamic>json){
    image=json['image'];
  }
}