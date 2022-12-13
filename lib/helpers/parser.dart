import 'package:html/dom.dart' as dom;
import 'package:http/http.dart' as http;

import '/models/result_model.dart';

Future<List<ResultModel>> parseUrl(String urlx) async {
  final url = Uri.parse(urlx);
  final response = await http.get(url);
  dom.Document html = dom.Document.html(response.body);

  final titles = html
      .querySelectorAll('#links > div > a')
      .map((element) => element.attributes['data-player'])
      .toList();

  final urls = html
      .querySelectorAll('#links > div > a')
      .map((element) => element.attributes['href'])
      .toList();
  return List.generate(titles.length,
      (index) => ResultModel(title: titles[index], url: urls[index]));
}
