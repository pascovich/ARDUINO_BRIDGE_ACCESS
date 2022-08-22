import 'package:updetecteurpoid/logic/bloc/app_bloc.dart';
import 'package:updetecteurpoid/logic/models/historic.dart';

class InitialState extends AppState {}

class LoadingState extends AppState {}

class ErrorState extends AppState {
  final String? message;
  const ErrorState({this.message});
}

class HistoricFound extends AppState {
  final List<Historic>? historics;

  const HistoricFound({this.historics});
}

class ParameterSet extends AppState {}
