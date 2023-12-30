import 'package:equatable/equatable.dart';
import 'package:quiz_app_new/data/models/language.dart';

class AppSettings extends Equatable {
  final Language local;
  final bool light;
  const AppSettings({this.local = const Language.inital(), this.light = true});

  AppSettings copyWith({Language? local, bool? light}) {
    return AppSettings(
      light: light ?? this.light,
      local: local ?? this.local,
    );
  }

  factory AppSettings.fromJson(Map<String, dynamic> json) {
    return AppSettings(
      light: json['light'],
      local: Language.fromJson(json['local']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'light': light,
      'local': local.toJson(),
    };
  }

  @override
  List<Object?> get props => [local, light];
}
