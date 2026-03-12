import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../../core/config/constant_colors.dart';

const double pagePading = 18;
const horizontalPagePadding = EdgeInsets.symmetric(horizontal: pagePading);

Widget space(double h, {double? w}) {
  return SizedBox(width: w, height: h);
}

Widget separator({Color? color}) {
  return Divider(color: color ?? Colors.grey.withValues(alpha: .2));
}

Widget custumLoader({double size = 30, Color? color}) {
  return SpinKitDualRing(color: color ?? AppColor.primary, size: size);
}

Widget custumRefresh(
    {required Widget child, VoidCallback? onRefresh, double originOfset = 10}) {
  return RefreshIndicator(
    displacement: 50,
    edgeOffset: originOfset,
    onRefresh: () async {
      onRefresh?.call();
    },
    child: child,
  );
}

Widget custumScrool({required Widget child, ScrollController? controller}) {
  return SingleChildScrollView(
    physics: const AlwaysScrollableScrollPhysics(),
    controller: controller,
    child: child,
  );
}

Widget scrollWithRefresh(
    {required Widget child,
    VoidCallback? onRefresh,
    double originOfset = 10,
    ScrollController? controller}) {
  return custumRefresh(
      onRefresh: onRefresh,
      originOfset: originOfset,
      child: custumScrool(child: child, controller: controller));
}

Widget CustumVisibilityDetector(
    {required String key,
    required Widget child,
    bool startDetection = false,
    bool callBackCondition = false,
    VoidCallback? loadingMoreCallback}) {
  return startDetection
      ? VisibilityDetector(
          key: Key("$key"),
          onVisibilityChanged: (info) {
            if (callBackCondition) loadingMoreCallback?.call();
          },
          child: child)
      : child;
}

