import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:packet_tea/data/config/end_points.dart';
import 'package:packet_tea/data/models/harvest_model.dart';
import 'package:packet_tea/data/services/http_services.dart';

import '../shared_preferences_services.dart';

class HarvestService{

  static final SharedPreferenceService _sharedPreferenceService = GetIt.I.get<SharedPreferenceService>();

  Future<HarvestParentModel> fetchHarvestByEstateID() async {
    String estateID = await _sharedPreferenceService.getEstateID();
    Response res = await HttpClientService.getReq(EndPoints.getHarvestByEstateID+estateID);
    final parsed = PacketTeaAPIResponse<Map<String, dynamic>>(res.data);
    // final Map<String, dynamic> parsed = jsonDecode(res.data);
    if (res.statusCode == 200 && parsed.status) {
      final List<dynamic> results = parsed.value['harvests'];
      if (results != null && results.length > 0) {
        List<HarvestModel> models = [];
        for (var v in results)
          models.add(HarvestModel().fromJson(v as Map<String, dynamic>));
        final HarvestParentModel model = HarvestParentModel();
        model.fromJson(parsed.value);
        model.harvests = models;
        return model;
      } else {
        return null;
      }
    } else {
      throw Exception("failed to fetch loans");
    }
  }
}