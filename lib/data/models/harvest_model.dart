import 'package:packet_tea/data/models/abstract_model.dart';

class HarvestModel extends AbstractModel{

  String id;
  String approvedWeight;
  String moistureWeight;
  String bagWeight;
  String amount;
  String weight;
  String status;
  String createAt;

  @override
  AbstractModel fromJson(Map<String, dynamic> json) {
    id = json['id'] as String ?? "";
    approvedWeight = (json['approvedWeight'] as int ?? 0).toString();
    amount = (json['amount'] as int ?? 0).toString();
    weight = (json['weight'] as int ?? 0).toString();
    createAt = (json['createdAt'] as int ?? 0).toString();
    approvedWeight = (json['approvedWeight'] as int ?? null).toString();
    moistureWeight = (json['moistureWeight'] as int ?? 0).toString();
    bagWeight = (json['bagWeight'] as int ?? 0).toString();
    status = json['status'] as String ?? "";

    return this;
  }

  @override
  Map<String, dynamic> toMap() {
    // TODO: implement toMap
    throw UnimplementedError();
  }

}

class HarvestParentModel extends AbstractModel{

  String totalHarvestAmount;
  String totalHarvestWeight;
  List<HarvestModel> harvests;

  @override
  AbstractModel fromJson(Map<String, dynamic> json) {
    totalHarvestAmount =(json['totalHarvestAmount'] as int ?? 0).toString();
    totalHarvestWeight =(json['totalHarvestWeight'] as int ?? 0).toString();
    return this;
  }

  @override
  Map<String, dynamic> toMap() {
    // TODO: implement toMap
    throw UnimplementedError();
  }


}