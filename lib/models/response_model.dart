import 'data_model.dart';

class ResponseModel {
  final String status;
  final DataModel? result;
  const ResponseModel({required this.status, this.result});

  static ResponseModel fromJson(Map<String, dynamic> json) => ResponseModel(
        status: json['status'] as String,
        result: DataModel.fromJson(json['result']),
      );
}
