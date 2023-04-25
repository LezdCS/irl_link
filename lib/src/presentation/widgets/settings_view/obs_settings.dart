import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../controllers/settings_view_controller.dart';


class ObsSettings extends StatelessWidget {
  final SettingsViewController controller;

  const ObsSettings({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 7,
              child: TextFormField(
                controller:
                controller.obsWebsocketUrlFieldController,
                obscureText:
                !controller.obsWebsocketUrlShow.value,
                onChanged: (value) {
                  controller.settings.value = controller
                      .settings.value
                      .copyWith(obsWebsocketUrl: value);
                  controller.saveSettings();
                },
                style: TextStyle(
                  color: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .color,
                ),
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(
                      horizontal: 8, vertical: 7),
                  hintText: 'url',
                  labelText: 'Websocket Url',
                  labelStyle: TextStyle(
                    color:
                    Theme.of(context).colorScheme.tertiary,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                        controller.obsWebsocketUrlShow.value
                            ? Icons.visibility
                            : Icons.visibility_off),
                    color: Theme.of(context)
                        .primaryIconTheme
                        .color,
                    onPressed: () {
                      controller.obsWebsocketUrlShow.value =
                      !controller.obsWebsocketUrlShow.value;
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: TextFormField(
                controller: controller
                    .obsWebsocketPasswordFieldController,
                obscureText:
                !controller.obsWebsocketPasswordShow.value,
                onChanged: (value) {
                  controller.settings.value = controller
                      .settings.value
                      .copyWith(obsWebsocketPassword: value);
                  controller.saveSettings();
                },
                style: TextStyle(
                  color: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .color,
                ),
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(
                      horizontal: 8, vertical: 7),
                  hintText: 'password',
                  labelText: 'Websocket Password',
                  labelStyle: TextStyle(
                    color:
                    Theme.of(context).colorScheme.tertiary,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(controller
                        .obsWebsocketPasswordShow.value
                        ? Icons.visibility
                        : Icons.visibility_off),
                    color: Theme.of(context)
                        .primaryIconTheme
                        .color,
                    onPressed: () {
                      controller
                          .obsWebsocketPasswordShow.value =
                      !controller
                          .obsWebsocketPasswordShow.value;
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 6),
        Row(
          children: [
            Expanded(
              child: TextButton(
                style: TextButton.styleFrom(
                  textStyle: TextStyle(fontSize: 12),
                  backgroundColor:
                  Theme.of(context).colorScheme.tertiary,
                  fixedSize: Size(50, 20),
                ),
                onPressed: () {
                  MobileScannerController cameraController =
                  MobileScannerController();

                  Get.dialog(_qrPasswordScanner(
                      cameraController, controller, context));

                  FocusManager.instance.primaryFocus?.unfocus();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'scan_qr'.tr,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 10),
                    Icon(Icons.qr_code, color: Colors.white),
                  ],
                ),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: TextButton(
                style: TextButton.styleFrom(
                  textStyle: TextStyle(fontSize: 12),
                  backgroundColor: Theme.of(context)
                      .colorScheme
                      .tertiaryContainer,
                  fixedSize: Size(50, 20),
                ),
                onPressed: () {
                  Get.defaultDialog(
                    title: "History",
                    cancelTextColor: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .color,
                    textCancel: "cancel".tr,
                    backgroundColor: Theme.of(context)
                        .colorScheme
                        .background,
                    content: _obsHistory(controller),
                  );
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'history'.tr,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 10),
                    Icon(Icons.history, color: Colors.white),
                  ],
                ),
              ),
            ),
          ],
        ),
        InkWell(
          onTap: () {
            launchUrlString(
              "https://www.irllink.com/wiki/obs-websocket",
              mode: LaunchMode.externalApplication,
            );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.open_in_browser,
                color: Colors.blue,
              ),
              Text(
                "how_can_i".tr,
                style: TextStyle(
                  color: Colors.blue,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _qrPasswordScanner(MobileScannerController controllerCamera,
      SettingsViewController controller, BuildContext context) {
    final scanWindow = Rect.fromCenter(
      center: MediaQuery.of(context).size.center(Offset.zero),
      width: 250,
      height: 250,
    );
    return Stack(
      fit: StackFit.expand,
      children: [
        MobileScanner(
          controller: controllerCamera,
          scanWindow: scanWindow,
          onDetect: (capture) {
            if (capture.barcodes.isEmpty) {
            } else {
              final String code = capture.barcodes.first.rawValue!;
              String password = code.split("/").last;
              String url = code.split("/")[2];
              controller.obsWebsocketPasswordFieldController.text = password;
              controller.obsWebsocketUrlFieldController.text = url;

              controller.settings.value =
                  controller.settings.value.copyWith(obsWebsocketUrl: url);

              controller.settings.value = controller.settings.value
                  .copyWith(obsWebsocketPassword: password);

              controller.saveSettings();
              Get.back();
            }
          },
        ),
        CustomPaint(
          painter: ScannerOverlay(scanWindow),
        ),
        Positioned(
          width: MediaQuery.of(context).size.width,
          bottom: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 100,
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                  ),
                  onPressed: () {
                    Get.back();
                  },
                  child: Text(
                    "close".tr,
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          width: MediaQuery.of(context).size.width,
          top: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Scan your OBS QR code",
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    decoration: TextDecoration.none),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _obsHistory(SettingsViewController controller) {
    return Container(
      child: Container(
        height: 200,
        child: ListView.builder(
          itemCount: controller.settings.value.obsConnectionsHistory!.length,
          itemBuilder: (context, index) {
            String url =
            controller.settings.value.obsConnectionsHistory![index]['url']!;
            String password = controller
                .settings.value.obsConnectionsHistory![index]['password']!;

            return ListTile(
              title: Text(url),
              onTap: () {
                controller.obsWebsocketUrlFieldController.text = url;
                controller.obsWebsocketPasswordFieldController.text = password;
                controller.settings.value = controller.settings.value.copyWith(
                    obsWebsocketUrl: url, obsWebsocketPassword: password);
                controller.saveSettings();
                Get.back();
              },
            );
          },
        ),
      ),
    );
  }
}


class ScannerOverlay extends CustomPainter {
  ScannerOverlay(this.scanWindow);

  final Rect scanWindow;

  @override
  void paint(Canvas canvas, Size size) {
    final backgroundPath = Path()..addRect(Rect.largest);
    final cutoutPath = Path()..addRect(scanWindow);

    final backgroundPaint = Paint()
      ..color = Colors.black.withOpacity(0.7)
      ..style = PaintingStyle.fill
      ..blendMode = BlendMode.dstOut;

    final backgroundWithCutout = Path.combine(
      PathOperation.difference,
      backgroundPath,
      cutoutPath,
    );
    canvas.drawPath(backgroundWithCutout, backgroundPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}