import 'package:bloc/bloc.dart';

enum CrudEvent {increment}

class CrudBloc extends Bloc<CrudEvent, int> {
  CrudBloc() : super(0);

  @override
  Stream<int> mapEventToState(CrudEvent event) async* {
    switch (event) {
      case CrudEvent.increment:
        yield state + 1;
        break;
    }
  }
}