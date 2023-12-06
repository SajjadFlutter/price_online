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
    Response response = await Dio().get(
        'https://api.coinmarketcap.com/data-api/v3/cryptocurrency/listing?start=1&limit=100&sortBy=market_cap&sortType=desc&convert=USD&cryptoType=all&tagType=all&audited=false&aux=ath,atl,high24h,low24h,num_market_pairs,cmc_rank,date_added,max_supply,circulating_supply,total_supply,volume_7d,volume_30d,self_reported_circulating_supply,self_reported_market_cap');

    return response;
  }

  dynamic callEnergyData() async {
    Response response =
        await Dio().get('https://bazaretala.com/brent-oil-prices-and-energy');

    return response;
  }

  dynamic callMetalData() async {
    Response response = await Dio().get('https://bazaretala.com/rhodium-price');

    return response;
  }
}
