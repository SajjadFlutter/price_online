import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:price_online/features/feature_prices/data/data_source/remote/prices_api_provider.dart';
import 'package:price_online/features/feature_prices/repository/prices_repository.dart';

GetIt locator = GetIt.instance;

Future<void> initLocator() async {
  // Dio
  locator.registerSingleton<Dio>(Dio());

  // api provider
  locator.registerSingleton<PricesApiProvider>(PricesApiProvider(locator()));

  // repository
  locator.registerSingleton<PricesRepository>(PricesRepository(locator()));
}
