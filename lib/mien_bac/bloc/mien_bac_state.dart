part of 'mien_bac_bloc.dart';

sealed class MienBacState extends Equatable {
  const MienBacState();
  
  @override
  List<Object> get props => [];
}

final class MienBacInitial extends MienBacState {}
