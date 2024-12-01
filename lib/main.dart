import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:irllink/firebase_options.dart';
import 'package:irllink/routes/app_pages.dart';
import 'package:irllink/src/bindings/login_bindings.dart';
import 'package:irllink/src/core/background/tasks_handlers/realtime_irl_task_handler.dart';
import 'package:irllink/src/core/depedency_injection.dart';
import 'package:irllink/src/core/resources/app_translations.dart';
import 'package:irllink/src/core/resources/themes.dart';
import 'package:irllink/src/core/services/talker_service.dart';
import 'package:irllink/src/core/utils/talker_custom_logs.dart';
import 'package:irllink/src/presentation/views/login_view.dart';
import 'package:kick_chat/kick_chat.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await GetStorage.init();
  await WakelockPlus.enable();
  await KickChat.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  AppTranslations.initLanguages();
  FlutterForegroundTask.initCommunicationPort();

  await initializeDependencies();

  runApp(const Main());
}

// The callback function should always be a top-level function.
@pragma('vm:entry-point')
void startCallback() {
  // The setTaskHandler function must be called to handle the task
  //in the background.
  FlutterForegroundTask.setTaskHandler(RealtimeIrlTaskHandler());
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    final talkerService = Get.find<TalkerService>();

    return GetMaterialApp(
      home: const LoginView(),
      theme: Themes().lightTheme,
      darkTheme: Themes().darkTheme,
      themeMode: ThemeMode.dark,
      initialRoute: AppPages.initial,
      initialBinding: LoginBindings(),
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
      translations: AppTranslations(),
      locale: Get.deviceLocale,
      fallbackLocale: const Locale('en', 'US'),
      navigatorObservers: [
        TalkerRouteObserver(talkerService.talker),
      ],
      logWriterCallback: localLogWriter,
    );
  }

  void localLogWriter(String text, {bool isError = false}) {
    final talkerService = Get.find<TalkerService>();
    if (isError) {
      talkerService.talker.error(text);
    } else {
      if (text.startsWith('Instance')) {
        talkerService.talker
            .logTyped(GetxInstanceLog(text, isDeleteAction: false));
        return;
      }
      if (text.endsWith('onDelete() called') ||
          text.endsWith('deleted from memory')) {
        talkerService.talker
            .logTyped(GetxInstanceLog(text, isDeleteAction: true));
        return;
      }
      if (text.contains('GOING TO ROUTE') || text.contains('CLOSE TO ROUTE')) {
        return;
      }
      if (text.startsWith('REMOVING ROUTE')) {
        talkerService.talker.logTyped(RouterLog(text));
        return;
      }
      talkerService.talker.log(text);
    }
  }
}
