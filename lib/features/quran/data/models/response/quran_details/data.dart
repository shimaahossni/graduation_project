import 'edition.dart';
import 'surah.dart';

class Data {
  List<Surah>? surahs;
  Edition? edition;

  Data({this.surahs, this.edition});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        surahs: (json['surahs'] as List<dynamic>?)
            ?.map((e) => Surah.fromJson(e as Map<String, dynamic>))
            .toList(),
        edition: json['edition'] == null
            ? null
            : Edition.fromJson(json['edition'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'surahs': surahs?.map((e) => e.toJson()).toList(),
        'edition': edition?.toJson(),
      };
}
