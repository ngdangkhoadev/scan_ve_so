import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'mien_bac_event.dart';
part 'mien_bac_state.dart';

class MienBacBloc extends Bloc<MienBacEvent, MienBacState> {
  MienBacBloc() : super(MienBacInitial()) {
    on<MienBacEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
