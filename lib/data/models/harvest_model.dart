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
    approvedWeight = (json['approvedWeight'] as num ?? 0.0).toString();
    amount = (json['amount'] as num ?? 0.0).toString();
    weight = (json['weight'] as num ?? 0.0).toString();
    createAt = Jiffy(DateTime.fromMillisecondsSinceEpoch((json['createdAt'] as int ?? 0)*1000)).format('yyyy-M-dd');
    approvedWeight = (json['approvedWeight'] as num ?? null).toString();
    moistureWeight = (json['moistureWeight'] as num ?? 0.0).toString();
    bagWeight = (json['bagWeight'] as num ?? 0.0).toString();
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
    totalHarvestAmount =(json['totalHarvestAmount'] as num ?? 0.0).toString();
    totalHarvestWeight =(json['totalHarvestWeight'] as num ?? 0.0).toString();
    return this;
  }

  @override
  Map<String, dynamic> toMap() {
    // TODO: implement toMap
    throw UnimplementedError();
  }


}