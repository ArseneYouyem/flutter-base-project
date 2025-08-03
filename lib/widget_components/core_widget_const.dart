import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../config/constant_colors.dart';
import '../config/style.dart';

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

HtmlWidget htmlToWidedget(String html, {TextStyle? style}) {
  return HtmlWidget(
    // the first parameter (`html`) is required
    html,

    // all other parameters are optional, a few notable params:

    // specify custom styling for an element
    // see supported inline styling below
    customStylesBuilder: (element) {
      if (element.classes.contains('foo')) {
        return {'color': 'red'};
      }
      return null;
    },
    customWidgetBuilder: (element) {
      return null;
    },

    // this callback will be triggered when user taps a link
    // onTapUrl: (url) => print('tapped $url'),

    // select the render mode for HTML body
    // by default, a simple `Column` is rendered
    // consider using `ListView` or `SliverList` for better performance
    renderMode: RenderMode.column,

    // set the default styling for text
    textStyle: style ?? titleBodyStyle(),
  );
}
