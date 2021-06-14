import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'homepage_event.dart';
part 'homepage_state.dart';

class HomepageBloc extends Bloc<HomepageEvent, HomepageState> {
  HomepageBloc() : super(HomepageInitial());

  @override
  Stream<HomepageState> mapEventToState(
    HomepageEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
