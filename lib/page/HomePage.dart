import 'package:flutter/material.dart';
import 'package:flutter_app/api/Address.dart';
import 'package:flutter_app/api/Api.dart';
import 'package:flutter_app/api/ResultData.dart';
import 'package:flutter_app/model/banner/BannerListModel.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_app/model/banner/BannerItemModel.dart';
import 'package:cached_network_image/cached_network_image.dart';

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
        body: new Column(
          children: <Widget>[
            new Swiper(
              itemCount: _images.length == 0 ? 0 : _images.length,
              control: new SwiperControl(),
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
          ],
        ));
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
}
