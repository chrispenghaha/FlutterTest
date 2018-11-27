import 'package:dio/dio.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter_app/api/ResultData.dart';
import 'package:flutter_app/api/StatusCode.dart';

///http请求
class HttpManager {

  static getRequest(String url) async {
    var connectivityResult = await (new Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      return new ResultData(null, false, StatusCode.NETWORK_ERROR);
    }
    Dio dio = new Dio();
    Response response;
    try {
      response = await dio.get(url);
    } on DioError catch (e) {
      Response errorResponse;
      if (e.response != null) {
        errorResponse = e.response;
      } else {
        errorResponse = new Response(statusCode: 666);
      }
      if (e.type == DioErrorType.CONNECT_TIMEOUT) {
        errorResponse.statusCode = StatusCode.NETWORK_TIMEOUT;
      }
      return new ResultData(errorResponse, false, StatusCode.NETWORK_TIMEOUT);
    }
    try {
      if (response.statusCode == 200 || response.statusCode == 201) {
        return new ResultData(response.data, true, StatusCode.SUCCESS);
      }
    } catch (e) {
      print(e.toString() + url);
      return new ResultData(response.data, false, response.statusCode);
    }
  }

  static postRequest(String url) async {
    //没有网络
    var connectivityResult = await (new Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      return new ResultData(null, false, StatusCode.NETWORK_ERROR);
    }
    Dio dio = new Dio();
    Response response;
    try {
      response = await dio.post(url);
    } on DioError catch (e) {
      Response errorResponse;
      if (e.response != null) {
        errorResponse = e.response;
      } else {
        errorResponse = new Response(statusCode: 666);
      }
      if (e.type == DioErrorType.CONNECT_TIMEOUT) {
        errorResponse.statusCode = StatusCode.NETWORK_TIMEOUT;
      }
      return new ResultData(errorResponse, false, StatusCode.NETWORK_TIMEOUT);
    }
    try {
      if (response.statusCode == 200 || response.statusCode == 201) {
        return new ResultData(response.data, true, StatusCode.SUCCESS);
      }
    } catch (e) {
      print(e.toString() + url);
      return new ResultData(response.data, false, response.statusCode);
    }
  }

}
