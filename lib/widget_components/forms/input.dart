import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'buttons.dart';
import '../../config/constant_colors.dart';
import '../../config/style.dart';
import '../../config/type.dart';

Widget inputForm({
  Widget? surfix,
  Widget? prefix,
  TextInputType? type = TextInputType.text,
  bool? hide = false,
  bool? expand = false,
  bool showLabel = false,
  String? hintText,
  bool? autoFocus = false,
  bool? multiLine = false,
  int? maxlength,
  int? maxline,
  bool? readOnly,
  String? initialValue,
  ParamsCallback? onChanged,
  ParamsCallback? onSubmit,
  VoidCallback? onTap,
  VoidCallback? onTapOutside,
  bool? filled = true,
  Color? filledColor,
  bool enableBorder = true,
  double borderRadius = 12,
  bool enabled = true,
  double? height,
  TextEditingController? controller,
  Color? focusedBorderColor,
  Color? unFocudBorderColor,
}) {
  final hideText = type == TextInputType.visiblePassword ? true.obs : hide!.obs;
  return Center(
    child: Obx(() => Container(
          child: TextFormField(
            // expands: expand!,
            enabled: enabled,
            initialValue: initialValue,
            enableSuggestions: false,
            inputFormatters: [
              if (maxlength != null)
                LengthLimitingTextInputFormatter(maxlength),
              if (type == TextInputType.number)
                FilteringTextInputFormatter.digitsOnly
            ],
            readOnly: readOnly ?? false,
            // cursorHeight: 15,
            keyboardType: type,
            obscureText: hideText.value,
            controller: controller,
            maxLines: multiLine! ? maxline ?? 7 : 1,
            autofocus: autoFocus!,
            onChanged: onChanged,
            // onSubmitted: onSubmit,
            onTap: onTap,
            // onTapOutside: (pointer) {
            //   if (onTapOutside != null) onTapOutside.call();
            //   print('taped outside ');
            // },
            style: titleBodyStyle(),
            cursorColor: Colors.black,
            decoration: InputDecoration(
              filled: filled,
              isDense: true,
              fillColor: filledColor ?? AppColor.white,
              labelStyle: titleBodyStyle(size: 14, color: AppColor.grey),
              hintText: showLabel ? null : hintText ?? '',
              labelText: showLabel ? hintText ?? '' : null,
              alignLabelWithHint: true,
              hintStyle: textBodyStyle(
                  color: AppColor.grey, fontWeight: FontWeight.w400),
              // fillColor: Colors.pink,
              // focusColor: Colors.orange,
              // hoverColor: Colors.red,
              prefixIcon: prefix == null
                  ? null
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: prefix,
                    ),
              suffixIcon: type == TextInputType.visiblePassword
                  ? actionButton(
                      onTap: () {
                        hideText.value = !hideText.value;
                      },
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        child:
                            //  hideText.value
                            //     ? Image.asset(AssetIcons.lock)
                            //     :
                            Icon(
                          hideText.value
                              ? Icons.visibility_off
                              : Icons.visibility_outlined,
                          color: AppColor.grey,
                          size: 27,
                        ),
                      ))
                  : surfix == null
                      ? null
                      : Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: surfix,
                        ),
              border: enableBorder ? null : InputBorder.none,
              enabledBorder: !enableBorder
                  ? null
                  : OutlineInputBorder(
                      borderRadius: BorderRadius.circular(borderRadius),
                      borderSide: BorderSide(
                          color: unFocudBorderColor ?? AppColor.greyBorder),
                    ),
              focusedBorder: !enableBorder
                  ? null
                  : OutlineInputBorder(
                      borderRadius: BorderRadius.circular(borderRadius),
                      borderSide: BorderSide(
                        color: focusedBorderColor ?? AppColor.grey,
                      ), // Highlight on focus
                    ),
            ),
          ),
        )),
  );
}

Widget inputSelect({
  required String text,
  bool select = false,
  IconData? selectIcon,
  VoidCallback? ontap,
  double? height,
}) {
  return actionButton(
    onTap: ontap,
    child: Container(
      height: height ?? 56,
      width: Get.width,
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      margin: EdgeInsets.only(bottom: 16),
      decoration: deco.copyWith(
        border: Border.all(color: AppColor.greyBorder),
        color: AppColor.white,
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              "$text",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: titleBodyStyle(
                  color: AppColor.black.withOpacity(select ? 1 : 0.4)),
            ),
          ),
          Icon(
            selectIcon ?? Icons.keyboard_arrow_down,
            color: AppColor.greyBorder,
          )
        ],
      ),
    ),
  );
}

// inputPhoneField({
//   TextEditingController? controller,
//   String? initialCountryCode,
//   String? initialValue,
//   String? hintText,
//   bool showLabel = false,
//   bool? dropDownSelector,
//   int item = 0,
//   Color? color,
//   bool filled = true,
//   bool showSurfix = true,
//   required ParamsCallback onchanged,
//   Color? focusedBorderColor,
//   Color? unFocudBorderColor,
// }) {
//   return Container(
//     // height: 45,
//     // padding: EdgeInsets.symmetric(horizontal: 8),
//     // decoration:
//     //     !deco ? null : deco1.copyWith(color: color ?? AppColor.formsColor),
//     child: Stack(
//       children: [
//         InternationalPhoneNumberInput(
//           locale: 'fr',
//           onInputChanged: (PhoneNumber number) {
//             final phone =
//                 "${number.dialCode} ${number.phoneNumber?.replaceAll("${number.dialCode}", "")}";
//             onchanged(phone);
//             // print("showInit ${userCtrl.phoneFieldCountryCode}");
//           },
//           onInputValidated: (bool value) {
//             print(value);
//           },
//           hintText: hintText ?? 'Numéro de téléphone',
//           errorMessage: "Numéro invalide",
//           searchBoxDecoration:
//               const InputDecoration(hintText: "Rechercher par nom ou par code"),
//           inputDecoration: InputDecoration(
//             filled: filled,
//             isDense: true,
//             fillColor: AppColor.white,
//             labelStyle: textBodyStyle(size: 14, color: AppColor.grey),
//             hintText: showLabel
//                 ? null
//                 : hintText ?? initialValue ?? "Numéro de téléphone",
//             labelText: showLabel
//                 ? hintText ?? initialValue ?? "Numéro de téléphone"
//                 : null,
//             alignLabelWithHint: true,
//             hintStyle: titleBodyStyle(
//                 color: AppColor.grey, fontWeight: FontWeight.w400),
//             enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12.0),
//               borderSide:
//                   BorderSide(color: unFocudBorderColor ?? AppColor.greyBorder),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12.0),
//               borderSide: BorderSide(
//                 color: focusedBorderColor ?? AppColor.grey,
//               ), // Highlight on focus
//             ),
//           ),
//           selectorConfig: SelectorConfig(
//               selectorType: dropDownSelector == null
//                   ? PhoneInputSelectorType.DIALOG
//                   : dropDownSelector
//                       ? PhoneInputSelectorType.DROPDOWN
//                       : PhoneInputSelectorType.BOTTOM_SHEET,
//               leadingPadding: 20,
//               // useEmoji: true,
//               // trailingSpace: false,
//               showFlags: false,
//               setSelectorButtonAsPrefixIcon: true),
//           ignoreBlank: false,
//           autoValidateMode: AutovalidateMode.disabled,
//           selectorTextStyle: titleBodyStyle(),
//           textStyle: titleBodyStyle(),
//           initialValue: PhoneNumber(phoneNumber: initialValue),
//           textFieldController: controller,
//           formatInput: true,
//           keyboardType: TextInputType.number,
//           // inputBorder: OutlineInputBorder(),
//           inputBorder: InputBorder.none,

//           onSaved: (PhoneNumber number) {
//             print('On Saved: ');
//           },
//         ),
//         const Positioned(
//           top: 0,
//           bottom: 0,
//           left: 0,
//           child: Icon(
//             Icons.arrow_drop_down,
//             color: AppColor.white,
//           ),
//         ),
//         if (showSurfix)
//           const Positioned(
//             top: 0,
//             bottom: 0,
//             right: 10,
//             child: Icon(
//               Icons.phone_android_outlined,
//               color: AppColor.white,
//             ),
//           )
//       ],
//     ),
//   );
// }
