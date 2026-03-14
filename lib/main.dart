import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutterbasestructure/core/helper/util.dart';
import 'package:flutterbasestructure/shared/network/dio/service_locator.dart';
import 'package:flutterbasestructure/shared/widgets/404.dart';
import 'package:get/get.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'core/config/app_theme.dart';
import 'core/navigation/all_pages.dart';
import 'core/services/app_service.dart';
import 'shared/store/state_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await AppService.initServices();
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Key key = UniqueKey();

  void restartApp() {
    setState(() {
      key =
          UniqueKey(); // Créer une nouvelle clé, ce qui reconstruit l'application
    });
  }

  @override
  void initState() {
    super.initState();
    initBinding(() {
      StateController.instance.restartApp = restartApp;
    });
  }

  // This widget is the root of your application .
  @override
  Widget build(BuildContext context) {
    return _unFocusWrapper(
      GetMaterialApp(
        key: key,
        enableLog: true,
        title: 'Flutter base Project',
        unknownRoute:
            GetPage(name: '/notfound', page: () => UnknownRoutePage()),
        initialRoute: AppPages.initial,
        getPages: AppPages.pages,
        // home: StartedView(),
        theme: AppTheme.currentTheme(light: true),
        themeMode: ThemeMode.light,
        debugShowCheckedModeBanner: false,
        supportedLocales: const [Locale('fr', 'FR')],
        locale: const Locale('fr', 'FR'),
        fallbackLocale: const Locale('fr', 'FR'),
        localizationsDelegates: const [
          CountryLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
      ),
    );
  }
}

Widget _unFocusWrapper(Widget? child) {
  return GestureDetector(
    behavior: HitTestBehavior.opaque,
    onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
    child: child,
  );
}
