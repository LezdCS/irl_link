import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irllink/routes/app_routes.dart';
import 'package:irllink/src/domain/entities/settings.dart';
import 'package:irllink/src/presentation/events/settings_events.dart';

class SettingsViewController extends GetxController {
  SettingsViewController({required this.settingsEvents});

  final SettingsEvents settingsEvents;

  late Rx<Settings> settings = Settings.defaultSettings().obs;

  late TextEditingController alternateChannelChatController;
  late TextEditingController obsWebsocketUrlFieldController;

  @override
  void onInit() {
    alternateChannelChatController = new TextEditingController();
    obsWebsocketUrlFieldController = new TextEditingController();
    super.onInit();
  }

  @override
  void onReady() {
    settingsEvents.getSettings().then((value) => {
          if (value.error == null)
            {
              settings.value = value.data!,
              alternateChannelChatController.text =
                  settings.value.alternateChannelName!,
              obsWebsocketUrlFieldController.text =
                  settings.value.obsWebsocketUrl!,
            }
        });
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void logout() {
    settingsEvents.logout().then(
          (value) => Get.offAllNamed(Routes.LOGIN),
        );
  }

  void saveSettings() {
    settingsEvents.setSettings(settings: settings.value);
  }
}
