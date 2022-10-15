import 'dart:async';
import 'dart:developer';

import 'package:stack_trace/stack_trace.dart';

part 'tags.dart';

const log = _Log();

class _Log {
  const _Log();

  void capture<R extends Object?>(R Function() body) =>
      runZonedGuarded(body, _error);

  void e(
    String message, [
    StackTrace? stackTrace,
    List<String>? tags,
  ]) =>
      _log(
        message,
        tags,
        _WarningLevel.error,
        stackTrace: stackTrace,
      );

  void w(String message, [List<String>? tags]) => _log(
        message,
        tags,
        _WarningLevel.warning,
      );

  void i(String message, [List<String>? tags]) => _log(
        message,
        tags,
        _WarningLevel.info,
      );

  void d(String message, [List<String>? tags]) => _log(
        message,
        tags,
        _WarningLevel.debug,
      );

  Future<void> _error(Object message, StackTrace stackTrace) async {
    // TODO: - Add analytics services
    e(message.toString(), stackTrace, [LogTag.root]);
  }

  void _log(
    String message,
    List<String>? tags,
    _WarningLevel level, {
    StackTrace? stackTrace,
  }) {
    final buffer = StringBuffer();
    final now = DateTime.now();

    switch (level) {
      case _WarningLevel.error:
        buffer.write(_WarningColor.red.code);
        break;
      case _WarningLevel.warning:
        buffer.write(_WarningColor.yellow.code);
        break;
      case _WarningLevel.info:
        buffer.write(_WarningColor.green.code);
        break;
      case _WarningLevel.debug:
        buffer.write(_WarningColor.white.code);
        break;
    }

    buffer
      ..write('[${now.formatted}]')
      ..write(' ' + level.value);
    if (tags != null && tags.isNotEmpty) {
      for (final tag in tags) {
        buffer
          ..write(' ')
          ..write('[$tag]');
      }
    }

    buffer.write(': \n\n' + message);

    if (stackTrace != null) {
      buffer
        ..write('\n')
        ..write(Trace.format(stackTrace));
    }

    buffer
      ..write(_WarningColor.end.code)
      ..write('\n');

    log(buffer.toString());
  }

  static const _timeLength = 2;
  static String _timeFormat(int input) =>
      input.toString().padLeft(_timeLength, '0');
}

enum _WarningLevel {
  error('[ERROR]'),
  warning('[WARNING]'),
  info('[INFO]'),
  debug('[DEBUG]');

  final String value;

  const _WarningLevel(this.value);
}

enum _WarningColor {
  end('\x1B[0m'),
  red('\x1B[31m'),
  yellow('\x1B[33m'),
  green('\x1B[32m'),
  white('\x1B[37m');

  final String code;

  const _WarningColor(this.code);
}

extension on DateTime {
  String get formatted => [hour, minute, second].map(_Log._timeFormat).join(':');
}
