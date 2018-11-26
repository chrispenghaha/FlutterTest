import 'package:dio/dio.dart';
import 'package:connectivity/connectivity.dart';

///http请求
class HttpManager {
  static  request(String url) async {
    //没有网络
    var connectivityResult = await (new Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {}
    Dio dio = new Dio();
    Response response;

  }
}
