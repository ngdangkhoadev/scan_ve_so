import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'setting_event.dart';
part 'setting_state.dart';

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  SettingBloc() : super(SettingState()) {
    on<NotificationMienBac>(_onChangeHideBac);
    on<NotificationMienTrung>(_onChangeHideTrung);
    on<NotificationMienNam>(_onChangeHideNam);
    on<NotificationMega>(_onChangeHideMega);
    on<NotificationPower>(_onChangeHidePower);
    on<NotificationKeno>(_onChangeHideKeno);
  }

  void _onChangeHideBac(NotificationMienBac event, Emitter<SettingState> emit) {
    emit(state.copyWith(isSwitchedBac: !state.isSwitchedBac));
  }

  void _onChangeHideTrung(
      NotificationMienTrung event, Emitter<SettingState> emit) {
    emit(state.copyWith(isSwitchedTrung: !state.isSwitchedTrung));
  }

  void _onChangeHideNam(NotificationMienNam event, Emitter<SettingState> emit) {
    emit(state.copyWith(isSwitchedNam: !state.isSwitchedNam));
  }

  void _onChangeHideMega(NotificationMega event, Emitter<SettingState> emit) {
    emit(state.copyWith(isSwitchedMega: !state.isSwitchedMega));
  }

  void _onChangeHidePower(NotificationPower event, Emitter<SettingState> emit) {
    emit(state.copyWith(isSwitchedPower: !state.isSwitchedPower));
  }

  void _onChangeHideKeno(NotificationKeno event, Emitter<SettingState> emit) {
    emit(state.copyWith(isSwitchedKeno: !state.isSwitchedKeno));
  }
}
