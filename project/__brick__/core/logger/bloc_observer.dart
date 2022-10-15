import 'package:flutter_bloc/flutter_bloc.dart';

import 'logger.dart';

class AppBlocObserver extends BlocObserver {
  factory AppBlocObserver.instance() => _singleton ??= AppBlocObserver._();
  static AppBlocObserver? _singleton;

  AppBlocObserver._();

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    log.d(event.toString(), [
      bloc.toString(),
      LogTag.blocEvent,
    ]);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    log.d(error.toString(), [
      bloc.toString(),
      LogTag.blocError,
    ]);
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    final currentState = change.currentState.toString();
    final nextState = change.nextState.toString();
    log.d('''
$currentState 
\n=>=>=>=>=> =>=>=>=>=> =>=>=>=>=> =>=>=>=>=> =>=>=>=>=>\n
$nextState
    ''', [
      bloc.runtimeType.toString(),
      LogTag.blocChange,
    ]);
  }
}
