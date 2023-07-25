import 'dart:async';
import 'dart:io';

import 'package:bitfrog/utils/log_utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/widgets.dart';
import 'package:bitfrog/provider/locale_provider.dart';
import 'package:bitfrog/res/base_image.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:provider/provider.dart';

class ImageUtil {

  static ImageProvider getAssetImage(String name, {ImageFormat format = ImageFormat.webp}) {
    return AssetImage(name);
  }
  // static ImageProvider getAssetImage(String name, {ImageFormat format = ImageFormat.webp}) {
  //   return AssetImage(getImgPath(name, format: format));
  // }

  static String getImgPath(String name, {ImageFormat format = ImageFormat.webp}) {
    return 'assets/images/$name.${format.value}';
  }

  static ImageProvider getImageProvider(String? imageUrl, {String holderImg = 'none'}) {
    if (TextUtil.isEmpty(imageUrl)) {
      return AssetImage(holderImg);
    }

    return CachedNetworkImageProvider(imageUrl ?? "",);

    // precacheImage(
    //     CachedNetworkImageProvider(imageUrl ?? "",),
    //     context, onError: (e, stackTrace) {
    //   print(('Image failed to load with error：$e'));
    //
    // });



  }

  static BaseImage getImageRes(BuildContext context){
    return Provider.of<LocaleProvider>(context).getImageRes();
  }


  static Future<File> compressFile(String path,int quality) async{
    File zipFile = await FlutterNativeImage.compressImage(path,quality: 100 - quality);
    return zipFile;
  }

  static Future<String> compressFileImage(String path,{int finSizeKB = 1024}) async {
    var imageFile = File(path);
    int imageSize = await imageFile.length();
    double imageSizeKb = imageSize / 1024;
    /// 压缩图片
    if (imageSizeKb > finSizeKB) {
      for (int i = 0; i < 100; i+=2) {
        imageFile = await compressFile(path, i);
        int ss = await imageFile.length();
        if (ss / 1024 <= finSizeKB) {
          break;
        }
      }
      return imageFile.absolute.path;
    }else{
      return path;
    }

  }
}

enum ImageFormat {
  png,
  jpg,
  gif,
  webp
}

extension ImageFormatExtension on ImageFormat {
  String get value => ['png', 'jpg', 'gif', 'webp'][index];
}
