import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irllink/src/core/services/app_info_service.dart';
import 'package:irllink/src/core/services/settings_service.dart';
import 'package:irllink/src/core/services/store_service.dart';
import 'package:irllink/src/core/services/talker_service.dart';
import 'package:irllink/src/core/services/tts_service.dart';
import 'package:irllink/src/core/services/watch_service.dart';
import 'package:irllink/src/data/repositories/settings_repository_impl.dart';
import 'package:irllink/src/data/repositories/twitch_repository_impl.dart';
import 'package:irllink/src/domain/usecases/settings/get_settings_usecase.dart';
import 'package:irllink/src/domain/usecases/settings/set_settings_usecase.dart';
import 'package:irllink/src/domain/usecases/twitch/get_twitch_local_usecase.dart';

Future<void> initializeDependencies() async {
  await Get.putAsync(
    () => TalkerService().init(),
    permanent: true,
  );

  // Repositories
  SettingsRepositoryImpl settingsRepository = SettingsRepositoryImpl();
  TwitchRepositoryImpl twitchRepository = TwitchRepositoryImpl();

  // Use cases
  final getSettingsUseCase = GetSettingsUseCase(settingsRepository);
  final setSettingsUseCase = SetSettingsUseCase(settingsRepository);
  final getTwitchLocalUseCase = GetTwitchLocalUseCase(twitchRepository);

  final settingsService = await Get.putAsync(
    () => SettingsService(
      getSettingsUseCase: getSettingsUseCase,
      setSettingsUseCase: setSettingsUseCase,
    ).init(),
    permanent: true,
  );
  if (!settingsService.settings.value.generalSettings.isDarkMode) {
    Get.changeThemeMode(ThemeMode.light);
  }

  await Get.putAsync(
    () => StoreService(
      getTwitchLocalUseCase: getTwitchLocalUseCase,
      talker: Get.find<TalkerService>().talker,
    ).init(),
    permanent: true,
  );

  final ttsService = await Get.putAsync(
    () => TtsService().init(),
    permanent: true,
  );
  await ttsService.initTts(settingsService.settings.value);

  await Get.putAsync(() => WatchService().init(), permanent: true);

  await Get.putAsync(() => AppInfoService().init(), permanent: true);
}