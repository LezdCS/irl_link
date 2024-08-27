import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irllink/src/presentation/controllers/streamelements_view_controller.dart';
import 'package:irllink/src/presentation/widgets/stream_elements/se_activities_list.dart';
import 'package:irllink/src/presentation/widgets/stream_elements/se_overlays.dart';
import 'package:irllink/src/presentation/widgets/stream_elements/se_song_requests.dart';

class StreamelementsTabView extends GetView<StreamelementsViewController> {
  const StreamelementsTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.isSocketConnected.value
          ? Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 20, bottom: 10),
                  child: TabBar(
                    controller: controller.tabController,
                    isScrollable: true,
                    indicator: const BoxDecoration(
                      border: null,
                    ),
                    tabAlignment: TabAlignment.center,
                    tabs: const [
                      Text("Activities"),
                      Text("Song Requests"),
                      Text("Overlays"),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: context.theme.colorScheme.surface,
                    ),
                    child: TabBarView(
                      controller: controller.tabController,
                      children: const [
                        SeActivitiesList(),
                        SeSongRequests(),
                        SeOverlays(),
                      ],
                    ),
                  ),
                ),
              ],
            )
          : const Center(
              child: Text("Not connected to StreamElements"),
            ),
    );
  }
}
