import 'data.dart';

class QuranDetails {
  int? code;
  String? status;
  Data? data;

  QuranDetails({this.code, this.status, this.data});

  factory QuranDetails.fromJson(Map<String, dynamic> json) => QuranDetails(
        code: json['code'] as int?,
        status: json['status'] as String?,
        data: json['data'] == null
            ? null
            : Data.fromJson(json['data'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'code': code,
        'status': status,
        'data': data?.toJson(),
      };
}
