import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'initialization_event.dart';
part 'initialization_state.dart';
part 'initialization_bloc.freezed.dart';

class InitializationBloc
    extends Bloc<InitializationEvent, InitializationState> {
  InitializationBloc() : super(const _NotInitialized()) {
    on<_Initialize>(_onInitialize);
  }

  Future<void> _onInitialize(
    _Initialize event,
    Emitter<InitializationState> emit,
  ) async {
    emit(const InitializationState.initializing());
    try {
      // TODO: - Do all async operations before runapp

      emit(
        InitializationState.initialized(),
      );
    } catch (error, stackTrace) {
      emit(InitializationState.error(error: error, stackTrace: stackTrace));
    }
  }
}
