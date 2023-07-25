import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:bitfrog/res/colors.dart';
import 'package:bitfrog/router/parameters.dart';
import 'package:bitfrog/router/routers.dart';
import 'package:bitfrog/utils/log_utils.dart';

class HomePage extends StatefulWidget {
  final String? routeParams;

  const HomePage({Key? key, this.routeParams}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();

}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Log.d('HomePage initState');
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   if (mounted) {
        // gotoView(widget.routeParams!);
        // Routers.goBack(context);
    //   }
    // });


  }

  @override
  Widget build(BuildContext context) {
    // return Routers.generatePage(context, widget.routeParams!)!;
    return Container(color: Colours.white);
  }

  gotoView(String route) {
    Log.d('route = $route');
    if (route.contains("?")) {
      AppRouteMatch? match = Routers.router?.match(route);
      Log.d("path = ${match?.route.route}");
      Log.d("arguments = ${match?.parameters.toString()}");
      Parameters params = Parameters();
      match?.parameters.forEach((key, value) {
        params.putString(key, value[0]);
      });
      Routers.navigateTo(context, match?.route.route ?? '/',
          parameters: params);
    } else {
      Routers.navigateTo(context, route);
    }
  }
}
