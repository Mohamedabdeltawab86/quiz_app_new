import 'package:equatable/equatable.dart';

import 'package:flutter/material.dart';

import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:quiz_app_new/data/models/language.dart';

import '../../../data/models/app_settings.dart';

part 'app_settings_event.dart';

part 'app_settings_state.dart';

class AppSettingsBloc extends HydratedBloc<AppSettingsEvent, AppSettingsState> {
  AppSettingsBloc() : super(const AppSettingsState()) {
    on<AppSettingsStarted>(_appSettingsStarted);

    on<ChangeAppTheme>(_changeAppTheme);

    on<ChangeAppLocal>(_changeAppLocal);
  }

  void _appSettingsStarted(
    AppSettingsStarted event,
    Emitter<AppSettingsState> emit,
  ) {
    if(state.status == Status.loaded) return;
    AppSettings appSettings = const AppSettings();

    emit(AppSettingsState(
      appSettings: appSettings,
      status: Status.loaded,
    ));
  }

  void _changeAppTheme(
    ChangeAppTheme event,
    Emitter<AppSettingsState> emit,
  ) {
    AppSettings appSettings = state.appSettings.copyWith(
      light: !state.appSettings.light,
    );

    emit(AppSettingsState(
      appSettings: appSettings,
      status: Status.loaded,
    ));
  }

  void _changeAppLocal(
    ChangeAppLocal event,
    Emitter<AppSettingsState> emit,
  ) {
    AppSettings appSettings = state.appSettings.copyWith(local: event.local);

    emit(AppSettingsState(
      appSettings: appSettings,
      status: Status.loaded,
    ));
  }

  @override
  AppSettingsState? fromJson(Map<String, dynamic> json) {
    return AppSettingsState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(AppSettingsState state) {
    return state.toJson();
  }
}
