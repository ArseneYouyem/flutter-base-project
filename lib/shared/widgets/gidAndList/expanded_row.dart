
import 'package:flutter/material.dart';


Widget expandedRow({
  required List<Widget> childrens,
  double? padding = 15,
}) {
  return Row(
    children: childrens
        .map((e) => Expanded(
                child: Container(
              padding: EdgeInsets.only(
                  right: e != childrens.last ? padding ?? 0 : 0),
              child: e,
            )))
        .toList(),
  );
}
