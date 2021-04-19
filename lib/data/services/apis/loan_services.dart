import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:packet_tea/data/config/end_points.dart';

import '../http_services.dart';

class LoanServices{

  Future<bool> requestLoan(
      String amount, DateTime dateTime, String notes) async {
    try{
      Response res = await HttpClientService.postReq(
          EndPoints.requestLoan,
          baseOptionType: BaseOptionType.defaultBaseOption,
          data: {
            "amount": amount,
            "date": dateTime,
            "note": notes
          });

      final Map<String, dynamic> jsonData = jsonDecode(res.data);
      if (res.statusCode == 200 && jsonData["Status"]) {
        return true;
      } else {
        return false;
      }
    }catch(error){
      throw error;
    }
  }
}