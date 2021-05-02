import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:jiffy/jiffy.dart';
import 'package:packet_tea/data/config/end_points.dart';
import 'package:packet_tea/data/models/loan_model.dart';
import 'package:packet_tea/data/services/shared_preferences_services.dart';

import '../http_services.dart';

class LoanServices{
  static final SharedPreferenceService _sharedPreferenceService = GetIt.I.get<SharedPreferenceService>();

  Future<bool> requestLoan(
      String amount, DateTime dateTime, String notes) async {
    try{
      String estateID = await _sharedPreferenceService.getEstateID();
      Response res = await HttpClientService.postReq(
          EndPoints.requestLoan,
          data: {
            "amount": amount,
            "date": Jiffy(dateTime).format('yyyy-MM-dd'),
            "note": notes,
            "teaEstateId":estateID

          });

      final parsed = PacketTeaAPIResponse<Map<String, dynamic>>(res.data);
      if (res.statusCode == 200 && parsed.status) {
        return true;
      } else {
        return false;
      }
    }catch(error){
      throw error;
    }
  }


  Future<LoanParentModel> fetchLoansByEstateID() async {
    String estateID = await _sharedPreferenceService.getEstateID();
    Response res = await HttpClientService.getReq(EndPoints.getLoansByEstateID+estateID);
    final parsed = PacketTeaAPIResponse<Map<String, dynamic>>(res.data);
    final LoanParentModel model = LoanParentModel();
    if (res.statusCode == 200 && parsed.status) {
      final List<dynamic> results = parsed.value['loans'];
      if (results != null && results.length > 0) {
        List<LoanModel> models = [];
        for (var v in results)
          models.add(LoanModel().fromJson(v as Map<String, dynamic>));
        model.fromJson(parsed.value);
        model.loan = models;
        return model;
      } else {
        model.loan = [];
        return model;
      }
    } else {
      throw Exception("failed to fetch loans");
    }
  }

  Future<bool> deleteLoanByID(String manureID) async{
    try{
      Response res = await HttpClientService.deleteReq(EndPoints.deleteLoans+manureID);
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