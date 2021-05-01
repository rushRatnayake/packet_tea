import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:packet_tea/data/services/apis/harvest_services.dart';
import 'package:packet_tea/data/services/apis/loan_services.dart';
import 'package:packet_tea/data/services/apis/manure_services.dart';
import 'package:packet_tea/data/services/apis/user_services.dart';
import 'package:packet_tea/packetteaapp.dart';

import 'data/services/secure_storage.dart';
import 'data/services/shared_preferences_services.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await _loadServices();
  runApp(PacketTeaApp());
}

Future<void> _loadServices() async{
  GetIt.I.registerLazySingleton<SecureStorageService>(() => SecureStorageService());
  GetIt.I.registerLazySingleton<UserServices>(() => UserServices());
  GetIt.I.registerLazySingleton<ManureServices>(() => ManureServices());
  GetIt.I.registerLazySingleton<LoanServices>(() => LoanServices());
  GetIt.I.registerLazySingleton<HarvestService>(() => HarvestService());
  //GetIt.I.registerLazySingleton<CommonServices>(() => CommonServices());
  //GetIt.I.registerLazySingleton<SignUpServices>(() => SignUpServices());

  /// Initialize shared preferences. And load defaults.
  var sps = SharedPreferenceService();
  await sps.ensureInitialized();
  GetIt.I.registerLazySingleton<SharedPreferenceService>(() => sps);

}