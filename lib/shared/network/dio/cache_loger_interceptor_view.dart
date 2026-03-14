import 'package:flutter/material.dart';
import 'package:flutterbasestructure/core/config/constant_colors.dart';
import 'package:flutterbasestructure/core/config/storage_key.dart';
import 'package:flutterbasestructure/core/config/style.dart';
import 'package:flutterbasestructure/core/services/secure_storage_service.dart';
import 'package:flutterbasestructure/shared/widgets/app_bottom_sheet.dart';
import 'package:flutterbasestructure/shared/widgets/forms/buttons.dart';
import 'package:get/get.dart';
import '../../../core/helper/util.dart';
import '../../../core/navigation/navigation.dart';
import '../../../features/application/controllers/user_controller.dart';
import '../../store/state_controller.dart';
import '../../widgets/core_widget_const.dart';
import '../../widgets/forms/input.dart';
import 'cache_loger_interceptor.dart';
import 'cache_loger_interceptor_controller.dart';
import 'package:intl/intl.dart';

class CacheLogerInterceptorView extends StatefulWidget {
  CacheLogerInterceptorView({super.key});

  @override
  State<CacheLogerInterceptorView> createState() =>
      _CacheLogerInterceptorViewState();
}

class _CacheLogerInterceptorViewState extends State<CacheLogerInterceptorView> {
  final ctrl = CacheLogerInterceptorController.instance;

  final userCtrl = UserController.instance;

  final store = StateController.instance;

  final editSearch = TextEditingController();
  final token = "".obs;
  final refreshToken = "".obs;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ctrl.searchHttpLog("");
    });
  }

  getTokens() async {
    final SecureStorageService storage = Get.find();
    final token = await storage.find(StorageKey.token);
    final refreshToken = await storage.find(StorageKey.refreshToken);
    this.token(token);
    this.refreshToken(refreshToken);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Inspecteur"),
        actions: [
          Obx(() => Switch(
                value: ctrl.enableLogin.value,
                onChanged: (value) {
                  ctrl.enableLogin(value);
                },
              )),
          IconButton(
              onPressed: () {
                showKeysBottomSheet();
              },
              icon: Icon(Icons.key)),
          IconButton(
              onPressed: () {
                ctrl.clearHttpLogs();
              },
              icon: Icon(Icons.delete_outline))
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Obx(() => Column(
                children: [
                  inputForm(
                      prefix: SizedBox(
                        width: 24,
                        child: Center(child: Icon(Icons.search)),
                      ),
                      hintText: "Rechercher",
                      controller: editSearch,
                      onChanged: (value) {
                        ctrl.searchHttpLog(value);
                      }),
                  space(10),
                  if (ctrl.httpLogs.isEmpty)
                    Column(
                      children: [
                        space(100),
                        Text(
                          "Aucune requette ",
                          style: titleStyle(),
                        ),
                        space(20),
                        Icon(Icons.hourglass_empty_rounded),
                        space(20),
                        Text("Aucune requette n'a été effectué pour le moment")
                      ],
                    )
                  else
                    Expanded(
                      child: ListView.builder(
                          itemCount: ctrl.httpLogs.length,
                          primary: false,
                          itemBuilder: (context, index) {
                            return LogItem(
                              log: ctrl.httpLogs[index],
                            );
                          }),
                    )
                ],
              )),
        ),
      ),
    );
  }

  showKeysBottomSheet() {
    AppBottomSheet.showCustumBottomSheet(
      context: Get.context!,
      child: SizedBox(
        height: Get.height * 0.7,
        child: Scrollbar(
          thumbVisibility: true,
          trackVisibility: true,
          interactive: true,
          child: Padding(
            padding: const EdgeInsets.only(right: 5),
            child: ListView(
              children: [
                Text("Clé", style: titleStyle()),
                copyItem("user id", userCtrl.currentUser().id ?? ""),
                copyItem("Token", token.value),
                copyItem("Refresh Token", refreshToken.value),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget copyItem(String title, String value, {int maxLines = 2}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          copyToClipboard(value, title: title);
        },
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: AppColor.greyText.withValues(alpha: 0.3),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    title,
                    style: textBodyStyle(color: AppColor.greyText),
                  ),
                  Spacer(),
                  Icon(Icons.copy, size: 10),
                ],
              ),
              Text(
                value,
                maxLines: maxLines,
                overflow: TextOverflow.ellipsis,
                style: textBodyStyle(color: AppColor.greyText),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LogItem extends StatelessWidget {
  const LogItem({super.key, required this.log});
  final HttpLog log;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          goTo(() => HttpLogerDetailView(log: log));
        },
        child: Container(
          width: Get.width,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: log.isOk
                  ? AppColor.darkGreen.withValues(alpha: 0.1)
                  : AppColor.red.withValues(alpha: 0.1),
              border: Border.all(
                  color: log.isOk
                      ? AppColor.darkGreen.withValues(alpha: 0.5)
                      : AppColor.red.withValues(alpha: 0.5))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat("dd MMM yyyy - HH:mm:ss", "Fr")
                    .format(DateTime.parse(log.date)),
                style: textBodyStyle(
                  color: AppColor.greyText,
                ),
              ),
              space(10),
              Text(
                "Method : ${log.method ?? "-"}",
                style: textBodyStyle(
                  color: AppColor.greyText,
                ),
              ),
              space(5),
              Text(
                "Url : ${log.url}",
                style: textBodyStyle(
                  color: AppColor.primary,
                ),
              ),
              space(5),
              Text(
                "Response status : ${log.statusCode}",
                style: textBodyStyle(
                    size: 14,
                    color: log.isOk ? AppColor.darkGreen : AppColor.red),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HttpLogerDetailView extends StatelessWidget {
  HttpLogerDetailView({super.key, required this.log});
  final HttpLog log;
  final showHeader = false.obs;
  final showResponse = true.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Log detail"),
      ),
      body: Padding(
        padding: horizontalPagePadding,
        child: ListView(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.blue.withValues(alpha: 0.2),
              ),
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    DateFormat("dd MMM yyyy - HH:mm:ss", "Fr")
                        .format(DateTime.parse(log.date)),
                    style: textBodyStyle(
                      color: AppColor.greyText,
                    ),
                  ),
                  space(10),
                  Text(
                    "Method : ${log.method ?? "-"}",
                    style: textBodyStyle(
                      color: AppColor.greyText,
                    ),
                  ),
                  space(10),
                  actionButton(
                    onTap: () {
                      copyToClipboard(log.url, title: "Url");
                    },
                    child: Text(
                      "Url : ${log.url}",
                      style: textBodyStyle(
                        color: AppColor.primary,
                      ),
                    ),
                  ),
                  if (log.requestBody != null &&
                      "${log.requestBody}".isNotEmpty) ...[
                    space(10),
                    actionButton(
                      onTap: () {
                        copyToClipboard(log.requestBody, title: "Request body");
                      },
                      child: Text(
                        "Request body : ${log.requestBody}",
                        style:
                            textBodyStyle(size: 14, color: AppColor.greyText),
                      ),
                    ),
                  ],
                  space(10),
                  Text(
                    "Response status : ${log.statusCode}",
                    style: textBodyStyle(
                        size: 14,
                        color: log.isOk ? AppColor.green : AppColor.red),
                  ),
                ],
              ),
            ),
            space(20),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.blue.withValues(alpha: 0.2),
              ),
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "Headers",
                        style: textBodyStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Spacer(),
                      Obx(() => IconButton(
                            onPressed: () {
                              showHeader(!showHeader.value);
                            },
                            icon: Icon(
                              showHeader.value
                                  ? Icons.keyboard_arrow_down
                                  : Icons.keyboard_arrow_up,
                            ),
                          ))
                    ],
                  ),
                  if (log.headers != null)
                    Obx(() => Visibility(
                          visible: showHeader.value,
                          child: Column(
                            children: [
                              for (var key in log.headers!.keys)
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 20),
                                  child: Row(
                                    children: [
                                      Container(
                                        constraints:
                                            BoxConstraints(minWidth: 120),
                                        child: actionButton(
                                          onTap: () {
                                            copyToClipboard(
                                              log.headers![key],
                                              title: key,
                                            );
                                          },
                                          child: Text(
                                            "$key",
                                            style: textBodyStyle(
                                              color: AppColor.primary,
                                            ),
                                          ),
                                        ),
                                      ),
                                      space(0, w: 10),
                                      Expanded(
                                        child: Text(
                                          "${log.headers![key]}",
                                          style: textBodyStyle(
                                            color: AppColor.greyText,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        )),
                ],
              ),
            ),
            space(20),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: log.isOk
                      ? Colors.green.withValues(alpha: 0.1)
                      : AppColor.red.withValues(alpha: 0.1),
                  border: Border.all(
                      color: log.isOk
                          ? AppColor.green.withValues(alpha: 0.5)
                          : AppColor.red.withValues(alpha: 0.5))),
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "Response (${log.getResponse().length})",
                        style: textBodyStyle(
                          color: log.isOk ? AppColor.green : AppColor.red,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Spacer(),
                      Obx(() => IconButton(
                            onPressed: () {
                              showResponse(!showResponse.value);
                            },
                            icon: Icon(
                              showResponse.value
                                  ? Icons.keyboard_arrow_down
                                  : Icons.keyboard_arrow_up,
                            ),
                          ))
                    ],
                  ),
                  if (log.responseBody != null)
                    Obx(() => Visibility(
                          visible: showResponse.value,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: actionButton(
                              onTap: () {
                                copyToClipboard(
                                  log.responseBody,
                                  title: "Response body",
                                );
                              },
                              child: Column(
                                children: [
                                  for (var item in log.getResponse())
                                    Container(
                                      decoration: BoxDecoration(
                                          border: Border(
                                        top: BorderSide(
                                          color: AppColor.greyText,
                                        ),
                                      )),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 25),
                                      child: Text(
                                        "${item}",
                                        style: textBodyStyle(
                                          color: AppColor.greyText,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
