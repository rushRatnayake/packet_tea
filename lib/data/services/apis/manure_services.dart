import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:packet_tea/data/config/end_points.dart';
import '../http_services.dart';

class ManureServices{

  Future<bool> requestManure(
      String weight, String contactPerson, String type) async {
    try{
      Response res = await HttpClientService.postReq(
          EndPoints.requestManure,
          baseOptionType: BaseOptionType.defaultBaseOption,
          data: {
            "weight": weight,
            "contactPerson": contactPerson,
            "type": type
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