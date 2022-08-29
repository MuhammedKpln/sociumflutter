import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:scflutter/components/Loading.dart';
import 'package:scflutter/theme/toast.dart';
import 'package:scflutter/utils/logger.dart';

mixin LoadingMixin {
  bool isLoading = true;

  onError(error) {
    Logger().logError(error);

    const Toast().showToast("fail".tr(), toastType: ToastType.Error);
  }

  Widget renderLoading({required Widget child}) {
    if (isLoading) {
      return const Loading();
    }

    return child;
  }
}
