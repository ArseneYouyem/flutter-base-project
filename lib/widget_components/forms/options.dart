import 'package:flutter/material.dart';
import 'buttons.dart';

Widget checkOption({
  String? label,
  bool checked = false,
  required void Function(bool) onChanged,
}) {
  return Row(
    children: [
      Checkbox(
        value: checked,
        onChanged: (value) {
          onChanged.call(value ?? false);
        },
        semanticLabel: "poids",
      ),
      if (label != null)
        actionButton(
          onTap: () {
            onChanged.call(!checked);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(
              label,
            ),
          ),
        )
    ],
  );
}
