import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Observer implements BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    debugPrint(
      'CHANGE: ${bloc.runtimeType} from ${change.currentState.runtimeType} to ${change.nextState.runtimeType}',
    );
  }

  @override
  void onClose(BlocBase bloc) {
    debugPrint('CLOSED: ${bloc.runtimeType}');
  }

  @override
  void onCreate(BlocBase bloc) {
    debugPrint('CREATED: ${bloc.runtimeType}');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    debugPrint('ERROR: $bloc with $error');
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    debugPrint('EVENT: $bloc with $event');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    debugPrint('TRANSITION: $bloc with $transition');
  }
}