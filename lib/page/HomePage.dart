import 'package:flutter/material.dart';
import 'package:flutter_app/api/Address.dart';
import 'package:flutter_app/api/Api.dart';
import 'package:flutter_app/api/ResultData.dart';
import 'package:flutter_app/model/banner/BannerListModel.dart';
import 'package:flutter_page_indicator/flutter_page_indicator.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_app/model/banner/BannerItemModel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'dart:ui' as ui;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  List<String> _images = new List();

  @override
  void initState() {
    super.initState();
    _loadBannerData();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("测试"),
        ),
        body: _buildBanner(context));
  }

  @override
  bool get wantKeepAlive => true;

  void _loadBannerData() async {
    var res = await HttpManager.getRequest(Address.getBanner());
    if (res != null && res.result) {
      var data = res.data;
      BannerListModel bannerListModel = BannerListModel.fromJson(data);
      for (BannerItemModel model in bannerListModel.data) {
        print(model.imagePath);
        _images.add(model.imagePath);
      }
      setState(() {});
    }
  }

  Widget _buildBanner(BuildContext context) {
    if (null == _images || _images.length <= 0) {
      return Center(
        child: Text("Loading"),
      );
    } else {
      double screenWidth = MediaQueryData.fromWindow(ui.window).size.width;
      return Container(
        height: screenWidth * 500 / 900,
        width: screenWidth,
        child: Card(
          elevation: 5.0,
//          shape: Border(),
          child: new Swiper(
            itemCount: _images.length == 0 ? 0 : _images.length,
            control: new SwiperControl(),
            pagination: new SwiperPagination(
                margin: new EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10.0),
                builder: new DotSwiperPaginationBuilder(
                    color: Colors.white30,
                    activeColor: Colors.white,
                    size: 10.0,
                    activeSize: 10.0)),
            autoplay: true,
            itemBuilder: (BuildContext context, int index) {
              return new CachedNetworkImage(
                imageUrl: _images[index],
                fit: BoxFit.fill,
                fadeInDuration: new Duration(milliseconds: 0),
                fadeOutDuration: new Duration(milliseconds: 0),
              );
            },
          ),
        ),
      );
    }
  }
}
