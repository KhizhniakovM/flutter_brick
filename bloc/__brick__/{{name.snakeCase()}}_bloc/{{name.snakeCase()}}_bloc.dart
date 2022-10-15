import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part '{{name.snakeCase()}}_event.dart';
part '{{name.snakeCase()}}_state.dart';

class {{name.pascalCase()}}Bloc extends Bloc<{{name.pascalCase()}}Event, {{name.pascalCase()}}State> {
  {{name.pascalCase()}}Bloc() : super(const _Initial()) {
    on<_Initial>(_onInitial);
  }
}

Future<void> _onInitial(
  _Initial event,
  Emitter<{{name.pascalCase()}}State> emit,
) async {
  // TODO: implement event handler
}