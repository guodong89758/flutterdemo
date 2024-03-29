
import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';

import '../widget/dialog/loading_dialog.dart';

abstract class IBasePage {

  BuildContext getContext();

  // 刷新
  Future<void> refresh({slient = false});

  // 跳转
  Future<void> jump({Map<String, dynamic>? params});

  // 显示Progress
  void showProgress();

  // 关闭Progress
  void closeProgress();
}


mixin BasePageMixin<T extends StatefulWidget> on State<T> implements IBasePage {

  bool _isShowDialog = false;

  @override
  BuildContext getContext() {
    return context;
  }

  @override
  Future<void> refresh({slient = false}) async {
    LogUtil.v('$T ==> refresh');
  }

  @override
  Future<void> jump({Map<String, dynamic>? params}) async {
    LogUtil.v('$T ==> jump $params');
  }

  @override
  void showProgress() {
    /// 避免重复弹出
    if (mounted && !_isShowDialog) {
      _isShowDialog = true;
      try {
        showDialog<void>(
          context: context,
          barrierDismissible: true,
          barrierColor: const Color(0x00FFFFFF), // 默认dialog背景色为半透明黑色，这里修改为透明（1.20添加属性）
          builder:(_) {
            return WillPopScope(
              onWillPop: () async {
                // 拦截到返回键，证明dialog被手动关闭
                _isShowDialog = false;
                return Future.value(true);
              },
              child: buildProgress(),
            );
          },
        );
      } catch(e) {
        /// 异常原因主要是页面没有build完成就调用Progress。
        print(e);
      }
    }
  }

  @override
  void closeProgress() {
    if (mounted && _isShowDialog) {
      _isShowDialog = false;

      FocusManager.instance.primaryFocus?.unfocus();
      Navigator.pop(context);
    }
  }

  // 可自定义Progress
  Widget buildProgress() {
    return LoadingDialog();
  }


  @override
  void didChangeDependencies() {
    LogUtil.v('$T ==> didChangeDependencies');
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    LogUtil.v('$T ==> dispose');
    super.dispose();
  }

  @override
  void deactivate() {
    LogUtil.v('$T ==> deactivate');
    super.deactivate();
  }

  @override
  void didUpdateWidget(T oldWidget) {
    //LogUtil.v('$T ==> didUpdateWidgets');
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    LogUtil.v('$T ==> initState');
    super.initState();
  }
  
}