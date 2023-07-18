import 'package:dio/dio.dart';
import 'package:html/parser.dart';
import 'package:price_online/features/feature_home/data/models/gold_model.dart';

class GoldApiProvider {
  final Dio dio;

  GoldApiProvider(this.dio);

  dynamic callGoldData() async {
    Response response =
        await Dio().get('https://bazaretala.com/gold-and-coin-price');

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

    return goldResults;
  }
}
