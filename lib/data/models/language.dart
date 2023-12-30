import 'package:equatable/equatable.dart';

class Language extends Equatable {
  final int id;
  final String flag;
  final String name;
  final String languageCode;

  const Language(this.id, this.flag, this.name, this.languageCode);

  const Language.inital({this.id = 1 , this.flag = "🇺🇸", this.name = "English", this.languageCode = "en"});

  static List<Language> languageList() {
    return <Language>[
      const Language(1, "🇺🇸", "English", "en"),
      const Language(2, "🇪🇬", "العَرَبِيَّةُ", "ar"),
    ];
  }


  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'flag': flag,
      'name': name,
      'languageCode': languageCode,
    };
  }
  

  factory Language.fromJson(Map<String, dynamic> json) {
    return Language(
      json['id'] as int,
      json['flag'] as String,
      json['name'] as String,
      json['languageCode'] as String,
    );
  }
  
  @override
  List<Object?> get props => [id];

}
