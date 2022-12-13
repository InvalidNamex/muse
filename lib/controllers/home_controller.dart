import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:record/record.dart';
import 'package:rive/rive.dart';

import '/admob/admob.dart';
import '/helpers/file_helper.dart';
import '../constants.dart';

class HomeController extends GetxController {
  static HomeController instance = Get.find();
  final record = Record();
  Rx<bool> isRecording = false.obs;
  late RiveAnimationController nowPlaying;
  late RiveAnimationController loading;
  BannerAd? bannerAd;
  RxBool bannerLoaded = false.obs;
  InterstitialAd? _interstitialAd;
  startRecording() async {
    // fetch local directory
    String path = await localPath;
    await record.start(
      path: '$path/clip.m4a',
      encoder: AudioEncoder.aacLc, // by default
      bitRate: 128000, // by default
      samplingRate: 44100, // by default
    );
    await record.isRecording();
  }

  _createBottomBannerAd() async {
    List data = await supabase.from('admobTable').select('bannerAd');
    String uid = data[0]['bannerAd'];
    bannerAd = BannerAd(
        size: AdSize.fullBanner,
        adUnitId: uid,
        listener: AdMobService.bannerListener,
        request: const AdRequest())
      ..load();
    bannerLoaded(true);
  }

  _createInterstitialAd() async {
    List data = await supabase.from('admobTable').select('interstitialAd');
    String uid = data[0]['interstitialAd'];
    InterstitialAd.load(
      adUnitId: uid,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) => _interstitialAd = ad,
        onAdFailedToLoad: (LoadAdError error) => _interstitialAd = null,
      ),
    );
  }

  showInterstitialAd() {
    if (_interstitialAd != null) {
      _interstitialAd!.fullScreenContentCallback =
          FullScreenContentCallback(onAdDismissedFullScreenContent: (ad) {
        ad.dispose();
        _createInterstitialAd();
      });
      _interstitialAd!.show().then((value) => Get.toNamed("/result"));
      _interstitialAd = null;
    }
  }

  @override
  void onInit() async {
    await _createBottomBannerAd();
    await _createInterstitialAd();
    bannerAd!.dispose();
    bannerAd!.load();
    loading = SimpleAnimation('v4');
    loading.isActive;
    super.onInit();
  }
}
