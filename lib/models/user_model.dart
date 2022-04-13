
class UserModel{
   late String uId;
   late String name;
   late String email;
   late String password;
   late String phoneNumber;
  UserModel({
    required this.uId,
    required this.name,
    required this.email,
    required this.password,
    required this.phoneNumber
  });
  UserModel.fromJson(Map<String,dynamic> json){
    uId=json['uId'];
    name=json['name'];
    email=json['email'];
    password=json['password'];
    phoneNumber=json['phoneNumber'];
  }
  Map<String,dynamic> toMap(){
    return {
      'name':name,
      'email':email,
      'phoneNumber':phoneNumber,
      'uId':uId,
    };
  }
}