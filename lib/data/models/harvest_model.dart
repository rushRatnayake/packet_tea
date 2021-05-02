import 'package:jiffy/jiffy.dart';
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
    amount = (json['amount'] as double ?? 0).toString();
    weight = (json['weight'] as double ?? 0).toString();
    createAt = Jiffy(DateTime.fromMillisecondsSinceEpoch((json['createdAt'] as int ?? 0)*1000)).format('yyyy-M-dd');
    approvedWeight = (json['approvedWeight'] as double ?? null).toString();
    moistureWeight = (json['moistureWeight'] as double ?? 0).toString();
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