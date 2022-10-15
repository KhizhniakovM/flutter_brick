part of 'initialization_bloc.dart';

@freezed
class InitializationState with _$InitializationState {
  const factory InitializationState.notInitialized() = _NotInitialized;

  const factory InitializationState.initializing() = _Initializing;

  @Implements<InitializationData>()
  const factory InitializationState.initialized({
  }) = _Initialized;

  const factory InitializationState.error({
    required Object error,
    required StackTrace stackTrace,
  }) = _Error;
}