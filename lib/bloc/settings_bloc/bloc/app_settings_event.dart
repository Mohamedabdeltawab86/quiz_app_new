part of 'app_settings_bloc.dart';

@immutable
sealed class AppSettingsEvent {}

class AppSettingsStarted extends AppSettingsEvent {}

class ChangeAppTheme extends AppSettingsEvent {}

class ChangeAppLocal extends AppSettingsEvent {
  final Language local;

  ChangeAppLocal(this.local);
}
