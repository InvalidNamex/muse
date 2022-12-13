import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neon/neon.dart';
import 'package:rive/rive.dart';

import '/constants.dart';
import '../widgets/result_list.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          Get.toNamed('/home');
          return false;
        },
        child: SafeArea(
          child: Scaffold(
            backgroundColor: Colors.indigo.shade100,
            body: Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/bg2.webp'),
                      fit: BoxFit.fill)),
              child: Obx(
                () => resultController.isLoading.value
                    ? Center(
                        child: RiveAnimation.asset(
                          'assets/rive/loading.riv',
                          controllers: [homeController.loading],
                        ),
                      )
                    : Column(
                        children: [
                          Image.network(
                            resultController.img,
                            height: MediaQuery.of(context).size.height * 0.3,
                            width: MediaQuery.of(context).size.width,
                            fit: BoxFit.fill,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.6,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // title
                                      Text(
                                        'Song:   ${resultController.responseModel.result!.title.toString().trim()}',
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: Colors.indigo.shade900,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      // album
                                      Text(
                                        'album: ${resultController.responseModel.result!.album.toString().trim()}',
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: Colors.indigo.shade900,
                                            fontSize: 16),
                                      ),
                                      // artist
                                      Text(
                                        'artist:   ${resultController.responseModel.result!.artist.toString().trim()}',
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: Colors.indigo.shade900,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                ),
                                InkWell(
                                  onTap: () async {
                                    Get.toNamed('/lyrics');
                                  },
                                  child: FittedBox(
                                    child: Neon(
                                      text: 'Lyrics',
                                      color: Colors.indigo,
                                      fontSize: 32,
                                      font: NeonFont.Monoton,
                                      flickeringText: true,
                                      glowingDuration:
                                          const Duration(milliseconds: 1000),
                                      flickeringLetters: const [0, 1, 5],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          resultList(),
                        ],
                      ),
              ),
            ),
          ),
        ));
  }
}
