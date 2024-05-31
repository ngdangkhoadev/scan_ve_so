part of 'setting_bloc.dart';

@immutable
sealed class SettingEvent extends Equatable {
  const SettingEvent();

  @override
  List<Object> get props => [];
}

class NotificationMienBac extends SettingEvent {
  const NotificationMienBac();
}

class NotificationMienTrung extends SettingEvent {
  const NotificationMienTrung();
}

class NotificationMienNam extends SettingEvent {
  const NotificationMienNam();
}

class NotificationMega extends SettingEvent {
  const NotificationMega();
}

class NotificationPower extends SettingEvent {
  const NotificationPower();
}

class NotificationKeno extends SettingEvent {
  const NotificationKeno();
}
