import 'package:dio/dio.dart';
import 'package:html/parser.dart';
import 'package:price_online/common/resources/data_state.dart';
import 'package:price_online/features/feature_home/data/data_source/remote/prices_api_provider.dart';
import 'package:price_online/features/feature_home/data/models/coin_model.dart';
import 'package:price_online/features/feature_home/data/models/gold_model.dart';

class PricesRepository {
  final PricesApiProvider apiProvider;

  PricesRepository(this.apiProvider);

  Future<dynamic> fetchGoldData() async {
    try {
      Response response = await apiProvider.callGoldData();
      if (response.statusCode == 200) {
        var document = parse(response.data);

        List<GoldModel> goldResults = [];
        List<String> goldTitles = [];
        List<String> goldPrices = [];
        List<String> goldPercent = [];

        var goldElements = document.querySelectorAll('#gold .tr-price');
        var titleElements = document.querySelectorAll('#gold .ptitle h2');
        var priceElements = document.querySelectorAll('#gold .p');
        var percentElements = document.querySelectorAll('#gold .d span');

        for (var i = 0; i < goldElements.length; i++) {
          if (i == 0 || i == 5 || i == 10) {
            String title = titleElements[i].text.trim();
            goldTitles.add(title);

            String price = priceElements[i].text.trim();
            goldPrices.add(price);

            String percent = percentElements[i].text.trim();
            percent = percent.substring(1, percent.length - 1);
            goldPercent.add(percent);

            goldResults.add(
              GoldModel(title: title, price: price, percent: percent),
            );
          }
        }

        return DataSuccess(goldResults);
      } else {
        return const DataFailed('مشکلی پیش آمده، لطفا دوباره امتحان کنید.');
      }
    } catch (e) {
      return const DataFailed('لطفا اتصال خود را به اینترنت چک کنید.');
    }
  }

  Future<dynamic> fetchCoinData() async {
    try {
      Response response = await apiProvider.callCoinData();
      if (response.statusCode == 200) {
        var document = parse(response.data);

        List<CoinModel> coinResults = [];
        List<String> coinTitles = [];
        List<String> coinPrices = [];
        List<String> coinPercent = [];

        var coinElements = document.querySelectorAll('#coin .tr-price');
        var titleElements = document.querySelectorAll('#coin .ptitle h2');
        var priceElements = document.querySelectorAll('#coin .p');
        var percentElements = document.querySelectorAll('#coin .d span');

        for (var i = 0; i < coinElements.length; i++) {
          if (i < 5) {
            String title = titleElements[i].text.trim();
            coinTitles.add(title);

            String price = priceElements[i].text.trim();
            coinPrices.add(price);

            String percent = percentElements[i].text.trim();
            percent = percent.substring(1, percent.length - 1);
            coinPercent.add(percent);

            coinResults.add(
              CoinModel(title: title, price: price, percent: percent),
            );
          }
        }
        print(coinResults.length);

        return DataSuccess(coinResults);
      } else {
        return const DataFailed('مشکلی پیش آمده، لطفا دوباره امتحان کنید.');
      }
    } catch (e) {
      return const DataFailed('لطفا اتصال خود را به اینترنت چک کنید.');
    }
  }
}
