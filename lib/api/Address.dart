///地址数据
class Address {
  static const String host = "http://www.wanandroid.com/";

  static getBanner() {
    return "${host}banner/json";
  }

  static getHomePage(int page) {
    return "${host}article/list/$page/json";
  }
}
