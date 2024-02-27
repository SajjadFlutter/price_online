import 'package:dio/dio.dart';
import 'package:html/parser.dart';
import 'package:price_online/common/resources/data_state.dart';
import 'package:price_online/features/feature_prices/data/data_source/remote/prices_api_provider.dart';
import 'package:price_online/features/feature_prices/data/models/price_model.dart';

class PricesRepository {
  final PricesApiProvider apiProvider;

  PricesRepository(this.apiProvider);

  // Gold
  Future<dynamic> fetchGoldData() async {
    try {
      Response response = await apiProvider.callGoldData();
      if (response.statusCode == 200) {
        var document = parse(response.data);

        List<PriceModel> goldResults = [];
        List<String> goldImages = [
          'https://icons.veryicon.com/png/o/miscellaneous/a-set-of-color-icons-for-financial-management/gold-bullion-4.png',
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
          String imageUrl = goldImages[0];

          String title = titleElements[i].text.trim();

          String timeUpdate = timeUpdateElements[i].text.trim();

          String price = priceElements[i].text.trim();

          String percent = percentElements[i].text.trim();
          percent = percent.substring(1, percent.length - 3);

          String percentChange =
              percentChangeElements[i].className.contains('high')
                  ? 'high'
                  : percentChangeElements[i].className.contains('low')
                      ? 'low'
                      : 'unChanged';

          goldResults.add(
            PriceModel(
              imageUrl: imageUrl,
              title: title,
              timeUpdate: timeUpdate,
              price: price,
              percent: percent,
              percentChange: percentChange,
            ),
          );
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

        List<PriceModel> coinResults = [];
        List<String> coinImages = [
          'https://www.pngkit.com/png/full/107-1072439_gold-coin-vector-png.png',
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
          String imageUrl = coinImages[0];
          String title = titleElements[i].text.trim();
          String timeUpdate = timeUpdateElements[i].text.trim();
          String price = priceElements[i].text.trim();

          String percent = percentElements[i].text.trim();
          percent = percent.substring(1, percent.length - 3);

          String percentChange =
              percentChangeElements[i].className.contains('high')
                  ? 'high'
                  : percentChangeElements[i].className.contains('low')
                      ? 'low'
                      : 'unChanged';

          coinResults.add(
            PriceModel(
              imageUrl: imageUrl,
              title: title,
              timeUpdate: timeUpdate,
              price: price,
              percent: percent,
              percentChange: percentChange,
            ),
          );
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

        List<PriceModel> currencyResults = [];

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
          percent = percent.substring(1, percent.length - 3);

          String percentChange =
              percentChangeElements[i].className.contains('high')
                  ? 'high'
                  : percentChangeElements[i].className.contains('low')
                      ? 'low'
                      : 'unChanged';

          currencyResults.add(
            PriceModel(
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
        var data = response.data['data'];

        List<PriceModel> cryptoResults = [];

        var cryptoList = data['cryptoCurrencyList'];

        for (var i = 0; i < cryptoList.length; i++) {
          String imageUrl =
              'https://s2.coinmarketcap.com/static/img/coins/64x64/${cryptoList[i]['id']}.png';
          String title = cryptoList[i]['name'];
          String symbol = cryptoList[i]['symbol'];
          String price = cryptoList[i]['quotes'][0]['price'].toString();
          String percent =
              cryptoList[i]['quotes'][0]['percentChange24h'].toString();
          String percentChange = cryptoList[i]['quotes'][0]['percentChange24h']
                  .toString()
                  .contains('-')
              ? 'low'
              : cryptoList[i]['quotes'][0]['percentChange24h']
                          .toString()
                          .contains('-') ==
                      false
                  ? 'high'
                  : 'unChanged';

          // Date
          String hour = DateTime.now().hour.toString().length < 2
              ? '0${DateTime.now().hour}'
              : '${DateTime.now().hour}';
          String minute = DateTime.now().minute.toString().length < 2
              ? '0${DateTime.now().minute}'
              : '${DateTime.now().minute}';
          String second = DateTime.now().second.toString().length < 2
              ? '0${DateTime.now().second}'
              : '${DateTime.now().second}';

          cryptoResults.add(
            PriceModel(
              imageUrl: imageUrl,
              title: title,
              symbol: symbol,
              timeUpdate: '$hour:$minute:$second',
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

  // Energy
  Future<dynamic> fetchEnergyData() async {
    try {
      Response response = await apiProvider.callEnergyData();
      if (response.statusCode == 200) {
        var document = parse(response.data);

        List<PriceModel> energyResults = [];
        List<String> energyImages = [
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQG9c9duYAEbne2pwI9JeZ9NHfl9n9NGVvGGaAC7RhKwzDrejs-',
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQG9c9duYAEbne2pwI9JeZ9NHfl9n9NGVvGGaAC7RhKwzDrejs-',
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQknQUcTJQqWecRMddXULx9luUIAw505kFzRw&usqp=CAU',
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQknQUcTJQqWecRMddXULx9luUIAw505kFzRw&usqp=CAU',
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQknQUcTJQqWecRMddXULx9luUIAw505kFzRw&usqp=CAU',
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQknQUcTJQqWecRMddXULx9luUIAw505kFzRw&usqp=CAU',
        ];

        var energyElements =
            document.querySelectorAll('.price-table .tr-price');
        var titleElements =
            document.querySelectorAll('.price-table .ptitle h2');
        var timeUpdateElements =
            document.querySelectorAll('.price-table .tr-price .t');
        var priceElements = document.querySelectorAll('.price-table .p');
        var percentElements = document.querySelectorAll('.price-table .d span');
        var percentChangeElements =
            document.querySelectorAll('.price-table .tr-price .d');

        for (var i = 0; i < energyElements.length - 1; i++) {
          String imageUrl = energyImages[i];

          String title = titleElements[i].text.trim();

          String timeUpdate = timeUpdateElements[i].text.trim();

          String price = priceElements[i].text.trim();

          String percent = percentElements[i].text.trim();
          percent = percent.substring(1, percent.length - 3);

          String percentChange =
              percentChangeElements[i].className.contains('high')
                  ? 'high'
                  : percentChangeElements[i].className.contains('low')
                      ? 'low'
                      : 'unChanged';

          energyResults.add(
            PriceModel(
              imageUrl: imageUrl,
              title: title,
              timeUpdate: timeUpdate,
              price: price,
              percent: percent,
              percentChange: percentChange,
            ),
          );
        }

        return DataSuccess(energyResults);
      } else {
        return const DataFailed('مشکلی پیش آمده، لطفا دوباره امتحان کنید.');
      }
    } catch (e) {
      return const DataFailed('لطفا اتصال خود را به اینترنت چک کنید.');
    }
  }

  // Metal
  Future<dynamic> fetchMetalData() async {
    try {
      Response response = await apiProvider.callMetalData();
      if (response.statusCode == 200) {
        var document = parse(response.data);

        List<PriceModel> energyResults = [];
        List<String> energyImages = [
          'https://freesvg.org/img/Farmeral-metal-icon.png',
        ];

        var metalElements = document.querySelectorAll('.price-table .tr-price');
        var titleElements =
            document.querySelectorAll('.price-table .ptitle h2');
        var timeUpdateElements =
            document.querySelectorAll('.price-table .tr-price .t');
        var priceElements = document.querySelectorAll('.price-table .p');
        var percentElements = document.querySelectorAll('.price-table .d span');
        var percentChangeElements =
            document.querySelectorAll('.price-table .tr-price .d');

        for (var i = 0; i < metalElements.length; i++) {
          String imageUrl = energyImages[0];

          String title = titleElements[i].text.trim();

          String timeUpdate = timeUpdateElements[i].text.trim();

          String price = priceElements[i].text.trim();

          String percent = percentElements[i].text.trim();
          percent = percent.substring(1, percent.length - 3);

          String percentChange =
              percentChangeElements[i].className.contains('high')
                  ? 'high'
                  : percentChangeElements[i].className.contains('low')
                      ? 'low'
                      : 'unChanged';

          energyResults.add(
            PriceModel(
              imageUrl: imageUrl,
              title: title,
              timeUpdate: timeUpdate,
              price: price,
              percent: percent,
              percentChange: percentChange,
            ),
          );
        }

        return DataSuccess(energyResults);
      } else {
        return const DataFailed('مشکلی پیش آمده، لطفا دوباره امتحان کنید.');
      }
    } catch (e) {
      return const DataFailed('لطفا اتصال خود را به اینترنت چک کنید.');
    }
  }
}
