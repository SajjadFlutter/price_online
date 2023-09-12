import 'package:dio/dio.dart';

class PricesApiProvider {
  final Dio dio;

  PricesApiProvider(this.dio);

  dynamic callGoldData() async {
    Response response =
        await Dio().get('https://bazaretala.com/gold-and-coin-price');

    return response;
  }

  dynamic callCoinData() async {
    Response response =
        await Dio().get('https://bazaretala.com/gold-and-coin-price');

    return response;
  }

  dynamic callCurrencyData() async {
    Response response =
        await Dio().get('https://bazaretala.com/dollar-and-currency-price');

    return response;
  }

  dynamic callCryptoData() async {
    Response response = await Dio().get('https://www.coingecko.com/');

    return response;
  }

  dynamic callEnergyData() async {
    Response response = await Dio().get('https://bazaretala.com/brent-oil-prices-and-energy');

    return response;
  }

  dynamic callMetalData() async {
    Response response = await Dio().get('https://bazaretala.com/rhodium-price');

    return response;
  }
}
