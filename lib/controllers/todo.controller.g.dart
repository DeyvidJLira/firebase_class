// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo.controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$TodoController on TodoControllerBase, Store {
  late final _$_isLoadingAtom =
      Atom(name: 'TodoControllerBase._isLoading', context: context);

  bool get isLoading {
    _$_isLoadingAtom.reportRead();
    return super._isLoading;
  }

  @override
  bool get _isLoading => isLoading;

  @override
  set _isLoading(bool value) {
    _$_isLoadingAtom.reportWrite(value, super._isLoading, () {
      super._isLoading = value;
    });
  }

  late final _$_taskDescriptionAtom =
      Atom(name: 'TodoControllerBase._taskDescription', context: context);

  String get taskDescription {
    _$_taskDescriptionAtom.reportRead();
    return super._taskDescription;
  }

  @override
  String get _taskDescription => taskDescription;

  @override
  set _taskDescription(String value) {
    _$_taskDescriptionAtom.reportWrite(value, super._taskDescription, () {
      super._taskDescription = value;
    });
  }

  late final _$addAsyncAction =
      AsyncAction('TodoControllerBase.add', context: context);

  @override
  Future<APIResponse<Todo>> add() {
    return _$addAsyncAction.run(() => super.add());
  }

  late final _$getAllAsyncAction =
      AsyncAction('TodoControllerBase.getAll', context: context);

  @override
  Future<APIResponse<List<Todo>>> getAll() {
    return _$getAllAsyncAction.run(() => super.getAll());
  }

  late final _$updateAsyncAction =
      AsyncAction('TodoControllerBase.update', context: context);

  @override
  Future<APIResponse<bool>> update(int index, Todo todo) {
    return _$updateAsyncAction.run(() => super.update(index, todo));
  }

  late final _$deleteAsyncAction =
      AsyncAction('TodoControllerBase.delete', context: context);

  @override
  Future<APIResponse<bool>> delete(Todo todo) {
    return _$deleteAsyncAction.run(() => super.delete(todo));
  }

  late final _$TodoControllerBaseActionController =
      ActionController(name: 'TodoControllerBase', context: context);

  @override
  dynamic changeTaskDescription(String value) {
    final _$actionInfo = _$TodoControllerBaseActionController.startAction(
        name: 'TodoControllerBase.changeTaskDescription');
    try {
      return super.changeTaskDescription(value);
    } finally {
      _$TodoControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
