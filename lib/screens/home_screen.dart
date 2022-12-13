import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neon/neon.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rive/rive.dart';

import '../constants.dart';
import '../widgets/banner_ad.dart';
import '../widgets/recording_animation.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.indigo.shade100,
        body: Stack(
          children: [
            Image.asset(
              'assets/images/bg1.jpg',
              fit: BoxFit.cover,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 75.0, bottom: 10),
                  child: Neon(
                    text: 'Muse',
                    color: Colors.indigo,
                    fontSize: 42,
                    font: NeonFont.Membra,
                    flickeringText: true,
                    glowingDuration: const Duration(milliseconds: 1000),
                    flickeringLetters: const [0, 2],
                  ),
                ),
                FittedBox(
                  child: Neon(
                    text: 'Detect Songs by listening..',
                    color: Colors.pink,
                    fontSize: 24,
                    font: NeonFont.Beon,
                    flickeringText: false,
                    glowingDuration: const Duration(milliseconds: 6000),
                  ),
                ),
                Expanded(
                  child: Obx(() => homeController.isRecording.value
                      ? recordAnimation()
                      : Center(
                          child: InkWell(
                              child: CircleAvatar(
                                radius: 70,
                                backgroundColor: Colors.indigo.shade100,
                                child: const CircleAvatar(
                                    radius: 60,
                                    backgroundImage:
                                        AssetImage('assets/images/play.webp')),
                              ),
                              onTap: () async {
                                // Check and request permission for storage
                                if (await Permission.storage
                                    .request()
                                    .isGranted) {
                                  // Check and request permission for mic
                                  if (await homeController.record
                                      .hasPermission()) {
                                    homeController.isRecording(true);
                                    homeController.nowPlaying =
                                        SimpleAnimation('playing');
                                    homeController.nowPlaying.isActive;
                                    await homeController.startRecording();
                                    Future.delayed(const Duration(seconds: 10),
                                        () async {
                                      await homeController.record
                                          .stop()
                                          .then((value) async {
                                        homeController.isRecording(false);
                                        Get.defaultDialog(
                                            backgroundColor: Colors.transparent,
                                            title: 'Loading..',
                                            titleStyle: TextStyle(
                                                color: Colors.indigo.shade100),
                                            content: Center(
                                              child: SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.25,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.8,
                                                child: RiveAnimation.asset(
                                                  'assets/rive/loading.riv',
                                                  controllers: [
                                                    homeController.loading
                                                  ],
                                                ),
                                              ),
                                            ));
                                        await resultController.postRequest();
                                      });
                                    });
                                  } else {
                                    // In case permission wasn't given try again..
                                    Get.defaultDialog(
                                        title: 'Sorry',
                                        middleText: "Can't reach the mic",
                                        actions: [
                                          InkWell(
                                            child: const Text('Retry'),
                                            onTap: () async {
                                              await homeController.record
                                                  .hasPermission();
                                            },
                                          )
                                        ]);
                                  }
                                } else {
                                  // Inform the user that storage permission wasn't granted
                                  Get.defaultDialog(
                                      title: 'Permission Error',
                                      middleText:
                                          "Storage permission wasn't granted",
                                      actions: [
                                        InkWell(
                                          child: const Text('Retry'),
                                          onTap: () async {
                                            await Permission.storage.request();
                                          },
                                        )
                                      ]);
                                }
                              }),
                        )),
                ),
                const BannerAdWidget(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
