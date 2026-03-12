import 'package:flutter/material.dart';
import '../../../core/config/constant_colors.dart';

Widget custumGridView({
  int itemPerRow = 2,
  bool expand = false,
  required List<Widget> childrens,
  double? padding,
  Color? paddingColor,
}) {
  int numberOfRow = (childrens.length / itemPerRow).ceil();
  return Container(
    color: paddingColor ?? AppColor.transparent,
    padding: EdgeInsets.all(padding ?? 0),
    child: Column(
      children: [
        for (var i = 0; i < numberOfRow; i++)
          Row(
            children: [
              for (var j = i * itemPerRow;
                  j < (i * itemPerRow) + itemPerRow;
                  j++)
                if (j >= childrens.length)
                  Expanded(child: Container())
                else
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(padding ?? 8.0),
                      child:
                          expand ? childrens[j] : Center(child: childrens[j]),
                    ),
                  ),
            ],
          ),
      ],
    ),
  );
}
