// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'dart:developer';

class MyBlocObserver extends BlocObserver {
  // @override
  // void onEvent(Bloc bloc, Object? event) {
  //   super.onEvent(bloc, event);
  // }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    log('Error: $error');
    log('StackTrace: $stackTrace');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    log(change.toString());
    super.onChange(bloc, change);
  }

  // @override
  // void onTransition(Bloc bloc, Transition transition) {
  //   super.onTransition(bloc, transition);
  // }
}
