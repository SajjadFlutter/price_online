import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:price_online/features/feature_home/data/data_source/remote/gold_api_provider.dart';
import 'package:price_online/features/feature_home/repository/gold_repository.dart';

GetIt locator = GetIt.instance;

Future<void> initLocator() async {
  // Dio
  locator.registerSingleton<Dio>(Dio());

  // api provider
  locator.registerSingleton<GoldApiProvider>(GoldApiProvider(locator()));

  // repository
  locator.registerSingleton<GoldRepository>(GoldRepository(locator()));
}
