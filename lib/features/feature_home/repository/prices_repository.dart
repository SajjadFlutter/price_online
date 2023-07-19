import 'package:dio/dio.dart';
import 'package:html/parser.dart';
import 'package:price_online/common/resources/data_state.dart';
import 'package:price_online/features/feature_home/data/data_source/remote/prices_api_provider.dart';
import 'package:price_online/features/feature_home/data/models/coin_model.dart';
import 'package:price_online/features/feature_home/data/models/crypto_model.dart';
import 'package:price_online/features/feature_home/data/models/currency_model.dart';
import 'package:price_online/features/feature_home/data/models/gold_model.dart';

class PricesRepository {
  final PricesApiProvider apiProvider;

  PricesRepository(this.apiProvider);

  // Gold
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

  // Coin
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

        return DataSuccess(coinResults);
      } else {
        return const DataFailed('مشکلی پیش آمده، لطفا دوباره امتحان کنید.');
      }
    } catch (e) {
      return const DataFailed('لطفا اتصال خود را به اینترنت چک کنید.');
    }
  }

  // Currency
  Future<dynamic> fetchCurrencyData() async {
    try {
      Response response = await apiProvider.callCurrencyData();
      if (response.statusCode == 200) {
        var document = parse(response.data);

        List<CurrencyModel> currencyResults = [];
        List<String> currencyTitles = [];
        List<String> currencyPrices = [];
        List<String> currencyPercent = [];

        var currencyElements = document.querySelectorAll('#azad .tr-price');
        var titleElements = document.querySelectorAll('#azad .ptitle h2');
        var priceElements = document.querySelectorAll('#azad .p');
        var percentElements = document.querySelectorAll('#azad .d span');

        for (var i = 0; i < currencyElements.length; i++) {
          String title = titleElements[i].text.trim();
          currencyTitles.add(title);

          String price = priceElements[i].text.trim();
          currencyPrices.add(price);

          String percent = percentElements[i].text.trim();
          percent = percent.substring(1, percent.length - 1);
          currencyPercent.add(percent);

          currencyResults.add(
            CurrencyModel(title: title, price: price, percent: percent),
          );
        }

        return DataSuccess(currencyResults);
      } else {
        return const DataFailed('مشکلی پیش آمده، لطفا دوباره امتحان کنید.');
      }
    } catch (e) {
      return const DataFailed('لطفا اتصال خود را به اینترنت چک کنید.');
    }
  }

  // Crypto
  Future<dynamic> fetchCryptoData() async {
    try {
      Response response = await apiProvider.callCryptoData();
      if (response.statusCode == 200) {
        var document = parse(response.data);

        List<CryptoModel> cryptoResults = [];
        List<String> cryptoTitles = [];
        List<String> cryptoPrices = [];
        List<String> cryptoPercent = [];

        var cryptoElements = document.querySelectorAll('.coingecko-table tbody tr');
        var titleElements = document.querySelectorAll('.coingecko-table .coin-name .font-bold');
        var priceElements = document.querySelectorAll('.coingecko-table [data-target="price.price"]');
        var percentElements = document.querySelectorAll('.coingecko-table .td-change24h [data-target="percent-change.percent"]');

        for (var i = 0; i < cryptoElements.length; i++) {
          String title = titleElements[i].text.trim();
          cryptoTitles.add(title);

          String price = priceElements[i].text.trim();
          cryptoPrices.add(price);

          String percent = percentElements[i].text.trim();
          cryptoPercent.add(percent);

          cryptoResults.add(
            CryptoModel(title: title, price: price, percent: percent),
          );
        }

        return DataSuccess(cryptoResults);
      } else {
        return const DataFailed('مشکلی پیش آمده، لطفا دوباره امتحان کنید.');
      }
    } catch (e) {
      return const DataFailed('لطفا اتصال خود را به اینترنت چک کنید.');
    }
  }
}
