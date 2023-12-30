part of 'app_settings_bloc.dart';

enum Status { loading, loaded, error, intial }

class AppSettingsState extends Equatable {
  final AppSettings appSettings;
  final Status status;

  const AppSettingsState(
      {this.appSettings = const AppSettings(), this.status = Status.intial});

  factory AppSettingsState.fromJson(Map<String, dynamic> json) {
    return AppSettingsState(
      appSettings: AppSettings.fromJson(json['appSettings']),
      status: Status.values.firstWhere(
        (status) => status.name == json['status'],
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'appSettings': appSettings.toJson(),
      'status': status.name,
    };
  }

  @override
  List<Object?> get props => [appSettings, status];
}
