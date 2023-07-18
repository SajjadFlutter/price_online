import 'package:dio/dio.dart';
import 'package:price_online/common/resources/data_state.dart';
import 'package:price_online/features/feature_home/data/data_source/remote/gold_api_provider.dart';

class GoldRepository {
  final GoldApiProvider apiProvider;

  GoldRepository(this.apiProvider);

  Future<dynamic> fetchGoldData() async {
    try {
      Response response = await apiProvider.callGoldData();
      if (response.statusCode == 200) {
        return DataSuccess(response);
      } else {
        return const DataFailed('مشکلی پیش آمده، لطفا دوباره امتحان کنید.');
      }
    } catch (e) {
      return const DataFailed('لطفا اتصال خود را به اینترنت چک کنید.');
    }
  }
}
