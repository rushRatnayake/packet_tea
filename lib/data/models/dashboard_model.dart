import 'dart:ffi';

import 'package:packet_tea/data/models/abstract_model.dart';

class DashboardModel extends AbstractModel{

  String totalBalance ;
  String dailyHarvestTotal;
  String monthlyManureTotal;
  String monthlyLoanTotal;
  int totalDebitedAmount;
  int totalCreditedAmount;

  @override
  AbstractModel fromJson(Map<String, dynamic> json) {
    // TODO: implement fromJson
    totalBalance = (json['totalBalance'] as int ?? 0).toString();
    dailyHarvestTotal = (json['dailyHarvestTotal'] as int ?? 0).toString();
    monthlyManureTotal = (json['monthlyManureTotal'] as int ?? 0).toString();
    monthlyLoanTotal = (json['monthlyLoanTotal'] as int ?? 0).toString();
    totalDebitedAmount = (json['totalDebitedAmount'] as int ?? 0);
    totalCreditedAmount = (json['totalCreditedAmount'] as int ?? 0);

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