import 'package:packet_tea/data/models/abstract_model.dart';

class UserModel extends AbstractModel{

  String name;
  String phoneNumber;
  String email;

  @override
  AbstractModel fromJson(Map<String, dynamic> json) {
    name =  json['name'] as String ?? "";
    phoneNumber =  json['phoneNo'] as String ?? "";
    email =  json['email'] as String ?? "";
    return this;
  }

  @override
  Map<String, dynamic> toMap() {
    // TODO: implement toMap
    throw UnimplementedError();
  }

}