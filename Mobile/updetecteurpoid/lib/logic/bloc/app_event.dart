import 'package:updetecteurpoid/logic/bloc/app_bloc.dart';
import 'package:updetecteurpoid/logic/bloc/app_state.dart';
import 'package:updetecteurpoid/logic/models/historic.dart';
import 'package:updetecteurpoid/logic/repository.dart';

class GetHistoric extends AppEvent {
  late Repository repository;
  GetHistoric() : repository = Repository();
  @override
  Stream<AppState> applyAnsyc({AppState? curentState, Appbloc? bloc}) async* {
    var response = await repository.getAllHistoric();

    if (response.statusCode == 200) {
      ResultHistoric resultHistoric = ResultHistoric.fromJson(response.data);
      yield HistoricFound(
        historics: resultHistoric.historics,
      );
    } else {
      yield const ErrorState(
        message: "Une erreur s'est produite",
      );
    }
  }
}

class SetParameter extends AppEvent {
  final double? weight;
  late Repository repository;
  SetParameter({this.weight}) : repository = Repository();
  @override
  Stream<AppState> applyAnsyc({AppState? curentState, Appbloc? bloc}) async* {
    var response = await repository.setParameter(
      weight: weight,
    );
    if (response.statusCode == 200) {
      yield ParameterSet();
    } else {
      yield const ErrorState(
        message: "Une erreur s'est produite",
      );
    }
  }
}
