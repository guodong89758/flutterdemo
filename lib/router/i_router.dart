import 'package:bitfrog/router/page_builder.dart';

abstract class IRouter {
  List<PageBuilder> getPageBuilders();
}