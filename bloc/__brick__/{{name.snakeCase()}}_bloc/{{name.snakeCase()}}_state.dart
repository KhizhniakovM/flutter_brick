part of '{{name.snakeCase()}}_bloc.dart';

@freezed
class {{name.pascalCase()}}State with _${{name.pascalCase()}}State {

  const {{name.pascalCase()}}State._();

  const factory {{name.pascalCase()}}State.idle() = _Idle;
  const factory {{name.pascalCase()}}State.loading() = _Loading;
  const factory {{name.pascalCase()}}State.error() = _Error;
}
