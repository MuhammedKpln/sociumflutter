import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:scflutter/components/Avatar.dart';
import 'package:scflutter/components/LoadingNew.dart';
import 'package:scflutter/theme/toast.dart';
import 'package:scflutter/utils/logger.dart';

mixin NewLoadingMixin<T extends StatefulWidget> on State<T>
    implements TickerProviderStateMixin<T> {
  ValueNotifier<bool> isLoading = ValueNotifier(true);
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 2),
    value: 0,
    vsync: this,
  );
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.linear,
  );

  @override
  void initState() {
    _addLoadingListener();
    super.initState();
  }

  _addLoadingListener() {
    isLoading.addListener(() {
      if (!isLoading.value) {
        _controller.animateTo(1);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    isLoading.dispose();
    super.dispose();
  }

  setLoading(bool loading) {
    isLoading.value = loading;
  }

  onError(error) {
    Logger().logError(error);

    const Toast().showToast("fail".tr(), toastType: ToastType.Error);
  }

  _renderSkeleton(LoadingType type, {AvatarSize? size}) {
    switch (type) {
      case LoadingType.list:
        return LoadingNew.listSkeleton();
      case LoadingType.singleLine:
        return LoadingNew.singleLine();
      case LoadingType.circle:
        return LoadingNew.circle(size: size);
      case LoadingType.avatar:
        return LoadingNew.avatar(size: size);
    }
  }

  Widget Loading(
      {required LoadingType type, required Widget child, AvatarSize? size}) {
    if (isLoading.value) {
      return _renderSkeleton(type, size: size);
    }

    return FadeTransition(
      opacity: _animation,
      child: child,
    );
  }
}
