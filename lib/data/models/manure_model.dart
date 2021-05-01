import 'package:packet_tea/data/models/abstract_model.dart';

class ManureModel extends AbstractModel{

  String id;
  String weight;
  String contactPerson;
  String contactNumber;
  String status;
  String type;

  @override
  AbstractModel fromJson(Map<String, dynamic> json) {
    id = json['id'] as String ?? "";
    weight = (json['weight'] as int ?? 0).toString();
    contactPerson = json['contactPersonName'] as String ?? "";
    contactNumber = json['contactPersonPhoneNo'] as String ?? "";
    status = json['status'] as String ?? "";
    type = json['type'] as String ?? "CIC";

    return this;
  }

  @override
  Map<String, dynamic> toMap() {
    // TODO: implement toMap
    throw UnimplementedError();
  }

}

class ManureParentModel extends AbstractModel{

  String totalManure;
  String totalManureAmount;
  List<ManureModel> manures;

  @override
  AbstractModel fromJson(Map<String, dynamic> json) {
    totalManureAmount =(json['totalManureAmount'] as int ?? 0).toString();
    totalManure =(json['totalManureWeight'] as int ?? 0).toString();
    return this;
  }

  @override
  Map<String, dynamic> toMap() {
    // TODO: implement toMap
    throw UnimplementedError();
  }


}