import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'init/initialization_bloc/initialization_bloc.dart';
import 'init/initialization_data.dart';
import 'init/initialization_hooks.dart';
import 'logger/bloc_observer.dart';
import 'logger/logger.dart';

typedef AppBuilder = Widget Function(InitializationData);

mixin MainRunner {
  static void _runApp(
    AppBuilder appBuilder,
    InitializationHooks hooks,
  ) {
    final initializationBloc = InitializationBloc()
      ..add(const InitializationEvent.initialize());

    StreamSubscription<InitializationState>? initializationSubscription;

    void terminate() {
      initializationSubscription?.cancel();
      initializationBloc.close();
    }

    void processInitializationState(InitializationState state) {
      state.map(
        notInitialized: (_) => hooks.onStarted(),
        initializing: (_) => hooks.onProgress(),
        initialized: (initializationData) async {
          terminate();
          hooks.onInitialized();
          runApp(appBuilder(initializationData));
          await _showAppInfo();
        },
        error: (state) {
          terminate();
          hooks.onFailed(state.error, state.stackTrace);
        },
      );
    }

    initializationBloc.stream.listen(processInitializationState);
  }

  static void run({
    required AppBuilder appBuilder,
    required InitializationHooks hooks,
  }) {
    log.capture(() async {
      // TODO: - Uncomment to use flutter native splash
      // final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
      // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

      _amendBlocObserver();
      _amendFlutterError();
      _debugFlags();
      _runApp(appBuilder, hooks);
      // FlutterNativeSplash.remove();
    });
  }

  static void _amendBlocObserver() {
    Bloc.observer = AppBlocObserver.instance();
  }

  static void _amendFlutterError() {
    FlutterError.onError = (details) => log.e(
          details.exceptionAsString(),
          details.stack,
        );
  }

  static Future<void> _showAppInfo() async {
    final info = await PackageInfo.fromPlatform();

    Log.i(
      '''
AppName: ${info.appName}
BuildNumber: ${info.buildNumber}
BuildSignature: ${info.buildSignature}
PackageName: ${info.packageName}
Version: ${info.version}
''',
      [LogTag.app],
    );
  }

  static void _debugFlags() {
    // https://medium.com/@louagejulien/flutter-debugging-ui-cheat-sheet-18a7b09dd468
    // debugPaintSizeEnabled = true;
    // debugPaintBaselinesEnabled = true;
    // debugPaintLayerBordersEnabled = true;
    // debugPaintPointersEnabled = true;
    // debugRepaintRainbowEnabled = true;
    // debugRepaintTextRainbowEnabled = true;
    // debugDisableClipLayers = true;
    // debugDisablePhysicalShapeLayers = true;
    // debugDisableOpacityLayers = true;
  }
}
