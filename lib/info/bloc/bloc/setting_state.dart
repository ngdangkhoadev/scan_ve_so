part of 'setting_bloc.dart';

final class SettingState extends Equatable {
  const SettingState({
    this.isSwitchedBac = false,
    this.isSwitchedTrung = false,
    this.isSwitchedNam = false,
    this.isSwitchedMega = false,
    this.isSwitchedPower = false,
    this.isSwitchedKeno = false,
  });

  final bool isSwitchedBac;
  final bool isSwitchedTrung;
  final bool isSwitchedNam;
  final bool isSwitchedMega;
  final bool isSwitchedPower;
  final bool isSwitchedKeno;

  SettingState copyWith({
    bool? isSwitchedBac,
    bool? isSwitchedTrung,
    bool? isSwitchedNam,
    bool? isSwitchedMega,
    bool? isSwitchedPower,
    bool? isSwitchedKeno,
  }) {
    return SettingState(
      isSwitchedBac: isSwitchedBac ?? this.isSwitchedBac,
      isSwitchedTrung: isSwitchedTrung ?? this.isSwitchedTrung,
      isSwitchedNam: isSwitchedNam ?? this.isSwitchedNam,
      isSwitchedMega: isSwitchedMega ?? this.isSwitchedMega,
      isSwitchedPower: isSwitchedPower ?? this.isSwitchedPower,
      isSwitchedKeno: isSwitchedKeno ?? this.isSwitchedKeno,
    );
  }

  @override
  List<Object> get props => [
        isSwitchedBac,
        isSwitchedTrung,
        isSwitchedNam,
        isSwitchedMega,
        isSwitchedPower,
        isSwitchedKeno
      ];
}
