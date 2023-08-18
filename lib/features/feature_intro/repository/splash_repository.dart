// ignore_for_file: depend_on_referenced_packages

import 'dart:io';

class SplashRepository {
  Future<bool> checkConnectivity() async {
    // final connectivityResult = await (Connectivity().checkConnectivity());
    // if (connectivityResult == ConnectivityResult.mobile) {
    //   // I am connected to a mobile network.
    //   return true;
    // } else if (connectivityResult == ConnectivityResult.wifi) {
    //   // I am connected to a wifi network.
    //   return true;
    // } else {
    //   return false;
    // }

    try {
      final result = await InternetAddress.lookup('example.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }
}
