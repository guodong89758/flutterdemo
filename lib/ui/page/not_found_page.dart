import 'package:bitfrog/router/routers.dart';
import 'package:bitfrog/ui/view/my_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:bitfrog/generated/l10n.dart';
import 'package:bitfrog/res/colors.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        onBack: (){
          Routers.goBack(context);
        },
        title: "页面错误",
      ),
      body: Container(
        color: Colours.white,
        child: Center(child: Text(S.current.error_page)),
      ),
    );
  }
}
