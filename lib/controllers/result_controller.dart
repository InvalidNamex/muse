import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';

import '/constants.dart';
import '/helpers/parser.dart';
import '/models/result_model.dart';
import '../helpers/file_helper.dart';
import '../models/response_model.dart';

class ResultController extends GetxController {
  static ResultController instance = Get.find();
  late ResponseModel responseModel;
  late final String apiKey;
  String img = '';
  RxBool isLoading = true.obs;
  late List<ResultModel> results;
  Future postRequest() async {
    String path = await localPath;

    // refer to audd to understand the parameters we passed here..
    var formData = dio.FormData.fromMap({
      "api_token": apiKey,
      // 'url': 'https://audd.tech/example.mp3',
      'file': await dio.MultipartFile.fromFile('$path/clip.m4a',
          filename: 'clip.m4a'),
      'return': 'spotify,lyrics',
    });
    // post request and load the response in a ResponseModel
    dio.Response response =
        await dio.Dio().post('https://api.audd.io/', data: formData);
    if (response.data['status'] == 'success' &&
        response.data['result'] != null) {
      responseModel = ResponseModel.fromJson(response.data);
      results = await parseUrl(responseModel.result!.songLink.toString());
      try {
        img = await responseModel.result?.spotify?['album']['images'][0]['url'];
      } catch (e) {
        img = "https://i.ibb.co/xLJKz6d/Png-Item-81341.png";
      }
      isLoading(false);
      homeController.showInterstitialAd();
    } else if (response.data['status'] == 'success' &&
        response.data['result'] == null) {
      Get.toNamed('/Confound');
    } else {
      Get.defaultDialog(
          title: 'Technical Difficulties',
          middleText:
              "We couldn't record the mic \n Please make sure mic permission is granted and mic is working");
    }
  }

  @override
  void onInit() async {
    List data = await supabase.from('apiTable').select('api_key');
    apiKey = data[0]['api_key'];
    super.onInit();
  }
}
