import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:packet_tea/data/config/end_points.dart';
import 'package:packet_tea/data/models/dashboard_model.dart';
import 'package:packet_tea/data/services/secure_storage.dart';
import 'package:packet_tea/data/services/shared_preferences_services.dart';

import '../http_services.dart';

class UserServices {
  final SharedPreferenceService _preferenceService = GetIt.I.get<SharedPreferenceService>();

  final SecureStorageService _secureStorageService =
      GetIt.I.get<SecureStorageService>();

  Future<String> fetchUserBalance() async {
    Response res = await HttpClientService.getReq(EndPoints.getUserBalance);
    return Future.delayed(Duration(seconds: 3), () {
      if (res.data['state']) {
        final Map<String, dynamic> jsonData = jsonDecode(res.data);
        if (res.statusCode == 200 && jsonData["Status"]) {
          return jsonData["results"]["name"];
        } else {
          return "";
        }
      }
      throw Error();
    });
  }

  /// Customer Login service : Uses organization base options
  /// Stores access token
  Future<bool> customerLoginService(String userName, String pwd) async {
    try {
      Response res = await HttpClientService.postReq<Map<String, dynamic>>(
          EndPoints.customerLogin,
          data: {
            "email": userName,
            "password": pwd,
          });
      final parsed = PacketTeaAPIResponse<Map<String, dynamic>>(res.data);
      if (res.statusCode == 200 && parsed.status) {
        final access = parsed.value["token"];

        if (await _secureStorageService.readSecureData("AccessToken") != null) {
          _secureStorageService.deleteSecureData("AccessToken");
        }
        await _preferenceService.setEstateID(parsed.value["teaEstates"][0]["id"]);
        await _preferenceService.setEstateName(parsed.value["teaEstates"][0]["name"]);
        await _preferenceService.setUserName(parsed.value["name"]);
        await _secureStorageService.writeSecureData("AccessToken", access);
        return Future.value(true);
      } else {
        return Future.value(false);
      }
    } catch (error) {
      return Future.value(null);
    }
  }


  Future<DashboardModel> fetchDashboard() async {
    try{
      String estateID = await _preferenceService.getEstateID();
      dynamic something = EndPoints.getDashboardData+estateID;

      Response res = await HttpClientService.getReq(EndPoints.getDashboardData+estateID);
      final parsed = PacketTeaAPIResponse<Map<String, dynamic>>(res.data);
      if (res.statusCode == 200 && parsed.status) {
        final DashboardModel model = DashboardModel();
        model.fromJson(parsed.value);
        return model;
      } else {
        return null;
      }
    }catch(error){
      throw Exception("failed to fetch manure");

    }
  }

  Future<List<EstateModel>> fetchUserEstates()async{
    try{
      Response res = await HttpClientService.getReq(EndPoints.getEstates);
      if (res.statusCode == 200 && res.data['status']) {
        final List<dynamic> results = res.data['value'];
        if (results != null && results.length > 0) {
          List<EstateModel> models = [];
          for (var v in results)
            models.add(EstateModel().fromJson(v as Map<String, dynamic>));
          return models;
        } else {
          return List.empty(growable: false);
        }
      } else {
        throw Exception("failed to fetch estates");
      }
    }catch(error){
      throw Exception("Failed to fetch estates");
    }
  }
}
