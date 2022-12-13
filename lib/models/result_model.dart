class ResultModel {
  final String? title;
  final String? url;
  const ResultModel({this.title, this.url});
  static ResultModel fromJson(Map<String, dynamic> json) => ResultModel(
        title: json['title'] as String?,
        url: json['url'] as String?,
      );
}
