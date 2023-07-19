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
}
