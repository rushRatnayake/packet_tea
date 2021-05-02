import 'dart:ffi';

import 'package:packet_tea/data/models/abstract_model.dart';

class DashboardModel extends AbstractModel{

  String totalBalance ;
  String dailyHarvestTotal;
  String monthlyManureTotal;
  String monthlyLoanTotal;
  double totalDebitedAmount;
  double totalCreditedAmount;

  @override
  AbstractModel fromJson(Map<String, dynamic> json) {
    // TODO: implement fromJson
    totalBalance = (json['totalBalance'] as num ?? 0.0).toString();
    dailyHarvestTotal = (json['dailyHarvestTotal'] as num ?? 0.0).toString();
    monthlyManureTotal = (json['monthlyManureTotal'] as num ?? 0.0).toString();
    monthlyLoanTotal = (json['monthlyLoanTotal'] as num ?? 0.0).toString();

    totalDebitedAmount = (json['totalDebitedAmount'] as num ?? 0.0).toDouble();
    totalCreditedAmount = (json['totalCreditedAmount'] as num ?? 0.0).toDouble() ;

  }

  @override
  Map<String, dynamic> toMap() {
    // TODO: implement toMap
    throw UnimplementedError();
  }

}

class EstateModel extends AbstractModel{

  String id;
  String name;
  String address;

  @override
  AbstractModel fromJson(Map<String, dynamic> json) {
    // TODO: implement fromJson
    id =  json['id'] as String ?? "";
    name =  json['name'] as String ?? "";
    address =  json['address'] as String ?? "";
    return this;

  }

  @override
  Map<String, dynamic> toMap() {
    // TODO: implement toMap
    throw UnimplementedError();
  }

}