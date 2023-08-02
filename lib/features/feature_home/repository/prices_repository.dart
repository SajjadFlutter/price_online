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
        List<String> goldImages = [
          'https://fs.noorgram.ir/xen/2021/05/1937_a04f325674750b15e1a00d49222b587f_thumb.jpg',
        ];

        var goldElements = document.querySelectorAll('#gold .tr-price');
        var titleElements = document.querySelectorAll('#gold .ptitle h2');
        var timeUpdateElements =
            document.querySelectorAll('#gold .tr-price .t');
        var priceElements = document.querySelectorAll('#gold .p');
        var percentElements = document.querySelectorAll('#gold .d span');
        var percentChangeElements =
            document.querySelectorAll('#gold .tr-price .d');

        for (var i = 0; i < goldElements.length; i++) {
          if (i == 0 || i == 5 || i == 7) {
            String imageUrl = goldImages[0];

            String title = titleElements[i].text.trim();

            String timeUpdate = timeUpdateElements[i].text.trim();

            String price = priceElements[i].text.trim();

            String percent = percentElements[i].text.trim();
            percent = percent.substring(1, percent.length - 1);

            String percentChange =
                percentChangeElements[i].className.contains('high')
                    ? 'high'
                    : percentChangeElements[i].className.contains('low')
                        ? 'low'
                        : 'unChanged';

            goldResults.add(
              GoldModel(
                imageUrl: imageUrl,
                title: title,
                timeUpdate: timeUpdate,
                price: price,
                percent: percent,
                percentChange: percentChange,
              ),
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
        List<String> coinImages = [
          'https://storage.torob.com/backend-api/base/images/uI/ru/uIru5jH_Z3Wkdh_k.png_/216x216.jpg',
          'https://storage.torob.com/backend-api/base/images/uI/ru/uIru5jH_Z3Wkdh_k.png_/216x216.jpg',
          'https://storage.torob.com/backend-api/base/images/f2/uJ/f2uJwWbvGo9Ooxi1.png_/216x216.jpg',
          'https://storage.torob.com/backend-api/base/images/f2/uJ/f2uJwWbvGo9Ooxi1.png_/216x216.jpg',
          'https://storage.torob.com/backend-api/base/images/f2/uJ/f2uJwWbvGo9Ooxi1.png_/216x216.jpg',
        ];

        var coinElements = document.querySelectorAll('#coin .tr-price');
        var titleElements = document.querySelectorAll('#coin .ptitle h2');
        var timeUpdateElements =
            document.querySelectorAll('#coin .tr-price .t');
        var priceElements = document.querySelectorAll('#coin .p');
        var percentElements = document.querySelectorAll('#coin .d span');
        var percentChangeElements =
            document.querySelectorAll('#coin .tr-price .d');

        for (var i = 0; i < coinElements.length; i++) {
          if (i < 5) {
            String imageUrl = coinImages[i];
            String title = titleElements[i].text.trim();
            String timeUpdate = timeUpdateElements[i].text.trim();
            String price = priceElements[i].text.trim();

            String percent = percentElements[i].text.trim();
            percent = percent.substring(1, percent.length - 1);

            String percentChange =
                percentChangeElements[i].className.contains('high')
                    ? 'high'
                    : percentChangeElements[i].className.contains('low')
                        ? 'low'
                        : 'unChanged';

            coinResults.add(
              CoinModel(
                imageUrl: imageUrl,
                title: title,
                timeUpdate: timeUpdate,
                price: price,
                percent: percent,
                percentChange: percentChange,
              ),
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

        var currencyElements = document.querySelectorAll('#azad .tr-price');
        var imagesElements =
            document.querySelectorAll('#azad .ptitle .mini-flag');
        var titleElements = document.querySelectorAll('#azad .ptitle h2');
        var timeUpdateElements =
            document.querySelectorAll('#azad .tr-price .t');
        var priceElements = document.querySelectorAll('#azad .p');
        var percentElements = document.querySelectorAll('#azad .d span');
        var percentChangeElements =
            document.querySelectorAll('#azad .tr-price .d');

        for (var i = 0; i < currencyElements.length; i++) {
          String countryCode = imagesElements[i].className.substring(15);
          String imageUrl =
              'https://bazaretala.com/uploads/flags/$countryCode.svg';
          String title = titleElements[i].text.trim();
          String timeUpdate = timeUpdateElements[i].text.trim();
          String price = priceElements[i].text.trim();

          String percent = percentElements[i].text.trim();
          percent = percent.substring(1, percent.length - 1);

          String percentChange =
              percentChangeElements[i].className.contains('high')
                  ? 'high'
                  : percentChangeElements[i].className.contains('low')
                      ? 'low'
                      : 'unChanged';

          currencyResults.add(
            CurrencyModel(
              imageUrl: imageUrl,
              title: title,
              timeUpdate: timeUpdate,
              price: price,
              percent: percent,
              percentChange: percentChange,
            ),
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

        var cryptoElements =
            document.querySelectorAll('.coingecko-table tbody tr');
        var imagesElements =
            document.querySelectorAll('.coingecko-table tbody tr td div img');
        var titleElements =
            document.querySelectorAll('.coingecko-table .coin-name .font-bold');
        var priceElements = document.querySelectorAll(
            '.coingecko-table .td-price [data-target="price.price"]');
        var percentElements = document.querySelectorAll(
            '.coingecko-table .td-change24h [data-target="percent-change.percent"]');

        for (var i = 0; i < cryptoElements.length; i++) {
          String imageUrl = imagesElements[i].attributes['src'].toString();

          String title = titleElements[i].text.trim();
          String price = priceElements[i].text.trim();

          String percent = percentElements[i].text.trim();

          // print(percentElements[i].text);

          String percentChange = percentElements[i].text.trim().contains('-')
              ? 'low'
              : percentElements[i].text.trim().contains('-') == false &&
                      double.parse(percentElements[i].text.substring(0, 3)) > 0
                  ? 'high'
                  : 'unChanged';

          cryptoResults.add(
            CryptoModel(
              imageUrl: imageUrl,
              title: title,
              timeUpdate:
                  '${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}',
              price: price,
              percent: percent,
              percentChange: percentChange,
            ),
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
