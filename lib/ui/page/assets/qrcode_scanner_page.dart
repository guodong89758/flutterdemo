import 'package:bitfrog/generated/assets.dart';
import 'package:bitfrog/generated/l10n.dart';
import 'package:bitfrog/res/colors.dart';
import 'package:bitfrog/router/routers.dart';
import 'package:bitfrog/ui/view/my_app_bar.dart';
import 'package:bitfrog/utils/image_util.dart';
import 'package:bitfrog/utils/log_utils.dart';
import 'package:bitfrog/utils/screen_helper.dart';
import 'package:bitfrog/utils/take_image_util.dart';
import 'package:bitfrog/utils/toast_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class QrcodeScannerPage extends StatefulWidget {
  const QrcodeScannerPage({Key? key}) : super(key: key);

  @override
  State<QrcodeScannerPage> createState() => _QrcodeScannerPageState();
}

class _QrcodeScannerPageState extends State<QrcodeScannerPage>
    with SingleTickerProviderStateMixin {
  BarcodeCapture? barcode;
  final MobileScannerController controller = MobileScannerController(
      torchEnabled: false, autoStart: true, formats: [BarcodeFormat.qrCode]);
  late AnimationController animController;
  double offsetY = 6;
  bool showLine = false;

  @override
  void initState() {
    super.initState();
    animController =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    // offsetY =
    //     (ScreenHelper.screenHeight - 200.h) / (ScreenHelper.screenWidth / 5);
    Log.d('offsetY = $offsetY');
  }

  @override
  void dispose() {
    controller.dispose();
    animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours.transparent,
      appBar: MyAppBar(
          title: S.current.capture_title,
          bottomLine: false,
          action: InkWell(
            onTap: () async {
              final ImagePicker picker = ImagePicker();
              final XFile? image = await picker.pickImage(
                source: ImageSource.gallery,
              );
              if (image != null) {
                if (await controller.analyzeImage(image.path)) {
                } else {
                  ToastUtil.show(S.current.def_failed);
                }
              }
              // List<AssetEntity>? list = await TakeImageUtil.getImage(context);
              // if ((list ?? []).isNotEmpty) {
              //   AssetEntity entity = list![0];
              //   var file = await entity.file;
              //   if (file != null) {
              //     if (await controller.analyzeImage(file.path)) {
              //     } else {
              //       ToastUtil.show(S.current.def_failed);
              //     }
              //   }
              // }
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 14.w),
              alignment: Alignment.center,
              child: Text(
                S.current.action_photo,
                style: TextStyle(color: Colours.text_color_2, fontSize: 14.sp),
              ),
            ),
          )),
      body: Stack(
        fit: StackFit.expand,
        alignment: Alignment.topCenter,
        children: [
          MobileScanner(
            controller: controller,
            fit: BoxFit.cover,
            onDetect: (barcode) {
              Routers.goBackWithParams(
                  context, barcode?.barcodes.first.rawValue ?? '');
              controller.stop();
            },
            onScannerStarted: (arguments) {
              setState(() {
                showLine = true;
              });
              animController.repeat();
            },
          ),
          Positioned(
            top: 50.h,
            child: Visibility(
              visible: showLine,
              child: SlideTransition(
                position:
                    Tween(begin: const Offset(0, 0), end: Offset(0, offsetY))
                        .chain(CurveTween(curve: Curves.linear))
                        .animate(animController),
                child: Image(
                    width: ScreenHelper.screenWidth,
                    fit: BoxFit.contain,
                    image: ImageUtil.getAssetImage(Assets.imagesScannerLine)),
              ),
            ),
          )
        ],
      ),
    );
  }
}
