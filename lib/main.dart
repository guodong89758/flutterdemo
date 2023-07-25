import 'dart:io';

import 'package:bitfrog/app/build_config.dart';
import 'package:bitfrog/app/default_app.dart';

/*
 生产环境
 打包APK的命令： flutter build apk --flavor=production lib/main.dart
 */
void main() => DefaultApp.run(Flavor.production);



