import 'package:flutter/material.dart';
import 'package:flutter_app/api/Address.dart';
import 'package:flutter_app/api/Api.dart';
import 'package:flutter_app/api/ResultData.dart';
import 'package:flutter_app/model/article/ArticleItemModel.dart';
import 'package:flutter_app/model/banner/BannerListModel.dart';
import 'package:flutter_app/widget/PullLoadWidget.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_app/model/banner/BannerItemModel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_app/widget/RefreshListState.dart';
import 'dart:ui' as ui;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState
    extends State<HomePage> // ignore: mixin_inherits_from_not_object
    with
        AutomaticKeepAliveClientMixin<HomePage>,
        // ignore: mixin_inherits_from_not_object
        RefreshListState<HomePage> {
  List<String> _images = new List();
  int _totalPage = 0;

  @override
  Future<Null> handleRefresh() async {
    if (isLoading) {
      return null;
    }
    isLoading = true;
    pullLoadWidgetControl.dataList.clear();
    _images.clear();
    page = 1;
    _loadBannerData();
    var res = await HttpManager.getRequest(Address.getHomePage(page - 1));
    if (res != null && res.result) {
      var data = res.data;
      var data2 = data['data']['datas'];
      _totalPage = data['data']['pageCount'];
      for (var sub in data2) {
        var articleItemModel = ArticleItemModel.fromJson(sub);
        pullLoadWidgetControl.dataList.add(articleItemModel);
      }
    }
    setState(() {
      pullLoadWidgetControl.needLoadMore = page < _totalPage;
    });
    isLoading = false;
    return null;
  }

  @override
  @override
  requestLoadMore() async {
    page++;
    var res = await HttpManager.getRequest(Address.getHomePage(page - 1));
    if (res != null && res.result) {
      var data = res.data;
      var data2 = data['data']['datas'];
      _totalPage = data['data']['pageCount'];
      for (var sub in data2) {
        var articleItemModel = ArticleItemModel.fromJson(sub);
        pullLoadWidgetControl.dataList.add(articleItemModel);
      }
    }
    setState(() {
      pullLoadWidgetControl.needLoadMore = page < _totalPage;
    });
    isLoading = false;
    return new ResultData(res.data['data']['datas'],true,0);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("测试"),
        ),
        body: new PullLoadWidget(
          pullLoadWidgetControl,
          (BuildContext context, int index) {
            if (index == 0) {
              return _buildBanner(context);
            } else {
              if (pullLoadWidgetControl.dataList.length > 0) {
                return _getItem(pullLoadWidgetControl.dataList[index]);
              }
            }
          },
          handleRefresh,
          onLoadMore,
          refreshKey: refreshIndicatorKey,
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

  Widget _buildBanner(BuildContext context) {
    double screenWidth = MediaQueryData.fromWindow(ui.window).size.width;
    if (null == _images || _images.length <= 0) {
      return Container(
          height: screenWidth * 500 / 900,
          width: screenWidth,
          child: Card(
            elevation: 5.0,
            shape: Border(),
            margin: EdgeInsets.all(0.0),
          ));
    } else {
      return Container(
        height: screenWidth * 500 / 900,
        width: screenWidth,
        child: Card(
          elevation: 5.0,
          shape: Border(),
          margin: EdgeInsets.all(0.0),
          child: new Swiper(
            itemCount: _images.length,
            control: new SwiperControl(),
            autoplay: true,
            pagination: new SwiperPagination(
                margin: new EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10.0),
                builder: new DotSwiperPaginationBuilder(
                    color: Colors.white30,
                    activeColor: Colors.white,
                    size: 10.0,
                    activeSize: 10.0)),
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

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    clearData();
  }

  @override
  void didChangeDependencies() {
    pullLoadWidgetControl.needLoadMore = true;
    pullLoadWidgetControl.dataList = new List<ArticleItemModel>();
    showRefreshLoading();
    super.didChangeDependencies();
  }

  Widget _getItem(var item) {
    return new Card(
      child: new Padding(
        padding: const EdgeInsets.all(10.0),
        child: _getRowWidget(item),
      ),
      elevation: 3.0,
      margin: const EdgeInsets.all(10.0),
    );
  }

  Widget _getRowWidget(item) {
    return new Row(
      children: <Widget>[
        new Flexible(
            flex: 1,
            fit: FlexFit.tight, //和android的weight=1效果一样
            child: new Stack(
              children: <Widget>[
                new Column(
                  children: <Widget>[
                    new Text(item.title,
                        style: new TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                        ),
                        textAlign: TextAlign.left),
                    new Text(
                      item.desc,
                      maxLines: 3,
                    )
                  ],
                )
              ],
            )),
        new ClipRect(
          child: new FadeInImage.assetNetwork(
            placeholder: "images/1.jpg",
            image: item.envelopePic,
            width: 50.0,
            height: 50.0,
            fit: BoxFit.fitWidth,
          ),
        ),
      ],
    );
  }

  Widget getNullWidget() {
    return new Container(
      height: 300.0,
      child: new Center(
          child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new CircularProgressIndicator(
            strokeWidth: 1.0,
          ),
          new Text("正在加载"),
        ],
      )),
    );
  }

  @override
  bool get isRefreshFirst => false;
}
