import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../constants.dart';

class BannerAdWidget extends StatefulWidget {
  const BannerAdWidget({Key? key}) : super(key: key);

  @override
  State<BannerAdWidget> createState() => _BannerAdWidgetState();
}

class _BannerAdWidgetState extends State<BannerAdWidget> {
  @override
  void initState() {
    homeController.bannerAd?.dispose();
    homeController.bannerAd?.load();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => !homeController.bannerLoaded.value
          ? Container()
          : StatefulBuilder(
              builder: (context, setState) => Container(
                width: homeController.bannerAd!.size.width.toDouble(),
                height: homeController.bannerAd!.size.height.toDouble(),
                alignment: Alignment.center,
                child: AdWidget(ad: homeController.bannerAd!),
              ),
            ),
    );
  }
}
