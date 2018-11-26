import 'package:flutter/material.dart';

class CustomTabBarWidget extends StatefulWidget {
  ///底部模式type
  static const int BOTTOM_TAB = 1;

  ///顶部模式type
  static const int TOP_TAB = 2;
  final int type;

  final List<Widget> tabItems;

  final List<Widget> tabViews;

  final Color backgroundColor;

  final Color indicatorColor;

  final Widget title;

  final Widget drawer;

  final Widget floatingActionButton;

  final TarWidgetControl tarWidgetControl;

  final PageController topPageControl;

  final ValueChanged<int> onPageChanged;

  CustomTabBarWidget({
    Key key,
    this.type,
    this.tabItems,
    this.tabViews,
    this.backgroundColor,
    this.indicatorColor,
    this.title,
    this.drawer,
    this.floatingActionButton,
    this.tarWidgetControl,
    this.topPageControl,
    this.onPageChanged,
  }) : super(key: key);

  @override
  _CustomTabBarWidgetState createState() => _CustomTabBarWidgetState(
        type,
        tabViews,
        indicatorColor,
        title,
        drawer,
        floatingActionButton,
        tarWidgetControl,
        topPageControl,
        onPageChanged,
      );
}

class _CustomTabBarWidgetState extends State<CustomTabBarWidget>
    with SingleTickerProviderStateMixin {
  final int _type;

  final List<Widget> _tabViews;

  final Color _indicatorColor;

  final Widget _title;

  final Widget _drawer;

  final Widget _floatingActionButton;

  final TarWidgetControl _tarWidgetControl;

  final PageController _pageController;

  final ValueChanged<int> _onPageChanged;

  _CustomTabBarWidgetState(
      this._type,
      this._tabViews,
      this._indicatorColor,
      this._title,
      this._drawer,
      this._floatingActionButton,
      this._tarWidgetControl,
      this._pageController,
      this._onPageChanged)
      : super();

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController =
        new TabController(vsync: this, length: widget.tabItems.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_type == CustomTabBarWidget.TOP_TAB) {
      return new Scaffold(
        floatingActionButton: _floatingActionButton,
        persistentFooterButtons:
            _tarWidgetControl == null ? [] : _tarWidgetControl.footerButton,
        appBar: new AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: _title,
          bottom: new TabBar(
            controller: _tabController,
            tabs: widget.tabItems,
            indicatorColor: _indicatorColor,
          ),
        ),
        body: new PageView(
          controller: _pageController,
          children: _tabViews,
          onPageChanged: (index) {
            _tabController.animateTo(index);
            _onPageChanged?.call(index);
          },
        ),
      );
    }
    return new Scaffold(
      drawer: _drawer,
      appBar: new AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: _title,
      ),
      body: new TabBarView(
        children: _tabViews,
        controller: _tabController,
      ),
      bottomNavigationBar: new Material(
        color: Theme.of(context).primaryColor, //底部导航栏主题颜色
        child: new TabBar(
          tabs: widget.tabItems,
          controller: _tabController,
          indicatorColor: _indicatorColor,
        ),
      ),
    );
  }
}

class TarWidgetControl {
  List<Widget> footerButton = [];
}
