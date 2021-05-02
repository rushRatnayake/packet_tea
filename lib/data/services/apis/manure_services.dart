import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:packet_tea/data/config/end_points.dart';
import 'package:packet_tea/data/models/manure_model.dart';
import 'package:packet_tea/data/services/shared_preferences_services.dart';
import '../http_services.dart';

class ManureServices{
  static final SharedPreferenceService _sharedPreferenceService = GetIt.I.get<SharedPreferenceService>();

  Future<bool> requestManure(
      String weight, String contactPerson, String contactNumber,String type) async {
    try{
      String estateID = await _sharedPreferenceService.getEstateID();
      Response res = await HttpClientService.postReq(
          EndPoints.requestManure,
          data: {
            "weight": weight,
            "contactPersonName": contactPerson,
            "contactPersonPhoneNo": contactNumber,
            "type": type,
            "teaEstateId":estateID
          });

      final parsed = PacketTeaAPIResponse<Map<String, dynamic>>(res.data);
      if (res.statusCode == 200 && parsed.status) {
        return true;
      }else {
        return false;
      }
    }catch(error){
      throw error;
    }
  }

  Future<ManureParentModel> fetchManureByID() async {
    String estateID = await _sharedPreferenceService.getEstateID();
    Response res = await HttpClientService.getReq(EndPoints.getManureByUserID+estateID);
    final parsed = PacketTeaAPIResponse<Map<String, dynamic>>(res.data);
    final ManureParentModel model = ManureParentModel();
    if (res.statusCode == 200 && parsed.status) {
      final List<dynamic> results = parsed.value['manures'];
      if (results != null && results.length > 0) {
        List<ManureModel> models = [];
        for (var v in results)
          models.add(ManureModel().fromJson(v as Map<String, dynamic>));
        model.fromJson(parsed.value);
        model.manures = models;
        return model;
      } else {
        model.manures = [];
        return model;
      }
    } else {
      throw Exception("failed to fetch manure");
    }
  }

  Future<bool> deleteManureByID(String manureID) async{
    try{
      Response res = await HttpClientService.deleteReq(EndPoints.deleteManure+manureID);
      if(res.statusCode == 200 && res.data['status']){
        return true;
      }else{
        return false;
      }
    }catch(error){
      throw error;
    }
  }
}

