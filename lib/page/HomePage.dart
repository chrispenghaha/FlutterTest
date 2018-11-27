import 'package:flutter/material.dart';
import 'package:flutter_app/api/Address.dart';
import 'package:flutter_app/api/Api.dart';
import 'package:flutter_app/api/ResultData.dart';
import 'package:flutter_app/model/banner/BannerListModel.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>  with AutomaticKeepAliveClientMixin{

  @override
  void initState() {
    super.initState();
    _loadBannerData();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  @override
  bool get wantKeepAlive => true;

  void _loadBannerData() {
    ResultData request = HttpManager.getRequest(Address.getBanner());
    if(request!=null&&request.result){
      var bannerListModel = BannerListModel.fromJson(request.data);
      var data = bannerListModel.data;

    }
  }
}
