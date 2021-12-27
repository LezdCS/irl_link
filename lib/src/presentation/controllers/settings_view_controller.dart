import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:irllink/routes/app_routes.dart';
import 'package:irllink/src/presentation/events/settings_events.dart';

class SettingsViewController extends GetxController {
  SettingsViewController({required this.settingsEvents});

  final SettingsEvents settingsEvents;

  final box = GetStorage();

  RxDouble slideValueForTextSize = 20.0.obs;

  RxDouble slideValueForBadgesAndEmotesSize = 20.0.obs;

  RxBool isSwitchedForFFZAndBTTVEmotes = false.obs;

  RxBool isSwitchedForTimestamp = false.obs;

  RxBool isSwitchedForAlternateChannel = false.obs;

  @override
  void onInit() {
    // Here you can fetch you product from server
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    // Here, you can dispose your StreamControllers
    // you can cancel timers
    super.onClose();
  }

  void logout() {
    settingsEvents.logout().then(
          (value) => Get.offAllNamed(Routes.LOGIN),
        );
  }
}
