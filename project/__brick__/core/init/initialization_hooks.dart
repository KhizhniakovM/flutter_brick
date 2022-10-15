import 'package:flutter/material.dart';

abstract class InitializationHooks {
  const InitializationHooks();

  @mustCallSuper
  void onStarted() {}

  @mustCallSuper
  void onProgress() {}

  @mustCallSuper
  void onInitialized() {}

  @mustCallSuper
  void onFailed(
    Object error,
    StackTrace stackTrace,
  ) {}
}