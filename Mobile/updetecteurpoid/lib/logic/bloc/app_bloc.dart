import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:updetecteurpoid/logic/bloc/app_state.dart';

class Appbloc extends Bloc<AppEvent, AppState> {
  Appbloc() : super(InitialState());

  @override
  Stream<AppState> mapEventToState(
    AppEvent event,
  ) async* {
    try {
      yield LoadingState();
      yield* event.applyAnsyc(curentState: state, bloc: this);
    } catch (e) {
      yield const ErrorState();
    }
  }
}

abstract class AppEvent {
  Stream<AppState> applyAnsyc({
    AppState curentState,
    Appbloc bloc,
  });
}

abstract class AppState extends Equatable {
  const AppState();

  @override
  List<Object> get props => [];
}
