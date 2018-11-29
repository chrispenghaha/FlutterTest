import 'package:flutter/material.dart';
import 'package:flutter_app/api/Address.dart';
import 'package:flutter_app/api/Api.dart';
import 'package:flutter_app/api/ResultData.dart';
import 'package:flutter_app/model/banner/BannerItemModel.dart';
import 'package:flutter_app/model/banner/BannerListModel.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'dart:ui' as ui;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  List<String> _images;
  double screenWidth = MediaQueryData.fromWindow(ui.window).size.width;

  @override
  void initState() {
    super.initState();
    _loadBannerData();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text("首页")),
      body: new Swiper(
        itemBuilder: (BuildContext context, int index) {
          return new CachedNetworkImage(
            fadeInDuration: Duration(milliseconds: 0),
            fadeOutDuration: Duration(milliseconds: 0),
            imageUrl: _images[index],
          );
        },
        autoplay: true,
        itemCount: _images.length,
        pagination: new SwiperPagination(),
        control: new SwiperControl(),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  void _loadBannerData() {
    ResultData request = HttpManager.getRequest(Address.getBanner());
    if (request != null && request.result) {
      var bannerListModel = BannerListModel.fromJson(request.data);
      var data = bannerListModel.data;
      _images = new List(data.length);
      for (BannerItemModel b in data) {
        _images.add(b.imagePath);
      }
      setState(() {
        _images = _images;
      });
    }
  }
}
