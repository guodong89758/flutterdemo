import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

/// Provider封装类
///
/// 方便数据初始化
class ProviderWidget<T extends ChangeNotifier> extends StatefulWidget {
  final ValueWidgetBuilder<T> builder;
  final T model;
  final Widget? child;
  final Function(T model)? onModelReady;
  final bool autoDispose;

  ProviderWidget({
    Key? key,
    required this.builder,
    required this.model,
    this.child,
    this.onModelReady,
    this.autoDispose: true,
  }) : super(key: key);

  _ProviderWidgetState<T> createState() => _ProviderWidgetState<T>();
}

class _ProviderWidgetState<T extends ChangeNotifier>
    extends State<ProviderWidget<T>> {
  late T model;

  @override
  void initState() {
    model = widget.model;
    widget.onModelReady?.call(model);
    super.initState();
  }

  @override
  void dispose() {
    if (widget.autoDispose) model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>.value(
      value: model,
      child: Consumer<T>(
        builder: widget.builder,
        child: widget.child,
      ),
    );
  }
}

class ProviderWidget2<A extends ChangeNotifier, B extends ChangeNotifier>
    extends StatefulWidget {
  final Widget Function(BuildContext context, A model1, B model2, Widget? child) builder;
  final A model1;
  final B model2;
  final Widget? child;
  final Function(A model1, B model2)? onModelReady;
  final bool autoDispose;

  ProviderWidget2({
    Key? key,
    required this.builder,
    required this.model1,
    required this.model2,
    this.child,
    this.onModelReady,
    this.autoDispose: true,
  }) : super(key: key);

  _ProviderWidgetState2<A, B> createState() => _ProviderWidgetState2<A, B>();
}

class _ProviderWidgetState2<A extends ChangeNotifier, B extends ChangeNotifier>
    extends State<ProviderWidget2<A, B>> {
  late A model1;
  late B model2;

  @override
  void initState() {
    model1 = widget.model1;
    model2 = widget.model2;
    widget.onModelReady?.call(model1, model2);
    super.initState();
  }

  @override
  void dispose() {
    if (widget.autoDispose) {
      model1.dispose();
      model2.dispose();
    }
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<A>.value(value: model1),
          ChangeNotifierProvider<B>.value(value: model2),
        ],
        child: Consumer2<A, B>(
          builder: widget.builder,
          child: widget.child,
        ));
  }
}




class ProviderWidget3<A extends ChangeNotifier, B extends ChangeNotifier,C extends ChangeNotifier>
    extends StatefulWidget {
  // final Widget Function(BuildContext context, A model1, B model2, C model3,Widget? child) builder;
  final Widget Function(BuildContext context, A model1, B model2, C model3, Widget? child) builder;
  final A model1;
  final B model2;
  final C model3;
  final Widget? child;
  final Function(A model1, B model2,C model3)? onModelReady;
  final bool autoDispose;

  ProviderWidget3({
    Key? key,
    required this.builder,
    required this.model1,
    required this.model2,
    required this.model3,
    this.child,
    this.onModelReady,
    this.autoDispose: true,
  }) : super(key: key);

  _ProviderWidgetState3<A, B,C> createState() => _ProviderWidgetState3<A, B,C>();
}

class _ProviderWidgetState3<A extends ChangeNotifier, B extends ChangeNotifier,C extends ChangeNotifier>
    extends State<ProviderWidget3<A, B,C>> {
// extends State<ProviderWidget2<A, B>> {
  late A model1;
  late B model2;
  late C model3;

  @override
  void initState() {
    model1 = widget.model1;
    model2 = widget.model2;
    model3 = widget.model3;
    widget.onModelReady?.call(model1, model2,model3);
    super.initState();
  }

  @override
  void dispose() {
    if (widget.autoDispose) {
      model1.dispose();
      model2.dispose();
      model3.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<A>.value(value: model1),
          ChangeNotifierProvider<B>.value(value: model2),
          ChangeNotifierProvider<C>.value(value: model3),
        ],
        child: Consumer3<A, B,C>(
          builder: widget.builder,
          child: widget.child,
        ));
  }
}

