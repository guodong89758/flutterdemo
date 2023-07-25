import 'package:flutter/material.dart';

class AppRouteObserver {
  AppRouteObserver._();

  static final RouteObserver<ModalRoute<void>> _routeObserver =
      RouteObserver<ModalRoute<void>>();

  static final AppRouteObserver instance = AppRouteObserver._();


  //  State with RouteAware

  //   订阅
  //   @override
  //   void didChangeDependencies() {
  //     super.didChangeDependencies();
  //
  //     final route = ModalRoute.of(context);
  //     if (route != null) {
  //       AppRouteObserver.instance.routeObserver.subscribe(this, route);
  //     }
  //   }

  //   重写 回调方法
  //   void didPopNext() { }
  //   void didPush() { }
  //   void didPop() { }
  //   void didPushNext() { }

  //  取消订阅
  //  AppRouteObserver.instance.routeObserver.unsubscribe(this);

  RouteObserver<ModalRoute<void>> get routeObserver {
    return _routeObserver;
  }
}
