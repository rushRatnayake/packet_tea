import 'package:jiffy/jiffy.dart';
import 'package:packet_tea/data/models/abstract_model.dart';


class LoanModel extends AbstractModel{

  String id;
  String amount;
  String notes;
  String dateTime;
  String status;

  @override
  AbstractModel fromJson(Map<String, dynamic> json) {
    id = json['id'] as String ?? "";
    amount = (json['amount'] as int ?? 0).toString();
    notes =  json['notes'] as String ?? "";
    dateTime = Jiffy(DateTime.fromMillisecondsSinceEpoch((json['createdAt'] as int ?? 0)*1000)).format('yyyy-M-dd');
    status = json['status'] as String ?? "";

    return this;
  }

  @override
  Map<String, dynamic> toMap() {
    // TODO: implement toMap
    throw UnimplementedError();
  }

}

class LoanParentModel extends AbstractModel{

  String totalLoan;
  List<LoanModel> loan;

  @override
  AbstractModel fromJson(Map<String, dynamic> json) {
    totalLoan =(json['totalLoanAmount'] as int ?? 0).toString();
    return this;
  }

  @override
  Map<String, dynamic> toMap() {
    // TODO: implement toMap
    throw UnimplementedError();
  }


}