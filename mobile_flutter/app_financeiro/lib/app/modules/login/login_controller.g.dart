// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$LoginController on _LoginControllerBase, Store {
  Computed<StoreState> _$stateComputed;

  @override
  StoreState get state =>
      (_$stateComputed ??= Computed<StoreState>(() => super.state)).value;

  final _$loginAtom = Atom(name: '_LoginControllerBase.login');

  @override
  String get login {
    _$loginAtom.context.enforceReadPolicy(_$loginAtom);
    _$loginAtom.reportObserved();
    return super.login;
  }

  @override
  set login(String value) {
    _$loginAtom.context.conditionallyRunInAction(() {
      super.login = value;
      _$loginAtom.reportChanged();
    }, _$loginAtom, name: '${_$loginAtom.name}_set');
  }

  final _$senhaAtom = Atom(name: '_LoginControllerBase.senha');

  @override
  String get senha {
    _$senhaAtom.context.enforceReadPolicy(_$senhaAtom);
    _$senhaAtom.reportObserved();
    return super.senha;
  }

  @override
  set senha(String value) {
    _$senhaAtom.context.conditionallyRunInAction(() {
      super.senha = value;
      _$senhaAtom.reportChanged();
    }, _$senhaAtom, name: '${_$senhaAtom.name}_set');
  }

  final _$_loginFutureAtom = Atom(name: '_LoginControllerBase._loginFuture');

  @override
  ObservableFuture<bool> get _loginFuture {
    _$_loginFutureAtom.context.enforceReadPolicy(_$_loginFutureAtom);
    _$_loginFutureAtom.reportObserved();
    return super._loginFuture;
  }

  @override
  set _loginFuture(ObservableFuture<bool> value) {
    _$_loginFutureAtom.context.conditionallyRunInAction(() {
      super._loginFuture = value;
      _$_loginFutureAtom.reportChanged();
    }, _$_loginFutureAtom, name: '${_$_loginFutureAtom.name}_set');
  }

  final _$errorMessageAtom = Atom(name: '_LoginControllerBase.errorMessage');

  @override
  String get errorMessage {
    _$errorMessageAtom.context.enforceReadPolicy(_$errorMessageAtom);
    _$errorMessageAtom.reportObserved();
    return super.errorMessage;
  }

  @override
  set errorMessage(String value) {
    _$errorMessageAtom.context.conditionallyRunInAction(() {
      super.errorMessage = value;
      _$errorMessageAtom.reportChanged();
    }, _$errorMessageAtom, name: '${_$errorMessageAtom.name}_set');
  }

  final _$loginSucessAtom = Atom(name: '_LoginControllerBase.loginSucess');

  @override
  bool get loginSucess {
    _$loginSucessAtom.context.enforceReadPolicy(_$loginSucessAtom);
    _$loginSucessAtom.reportObserved();
    return super.loginSucess;
  }

  @override
  set loginSucess(bool value) {
    _$loginSucessAtom.context.conditionallyRunInAction(() {
      super.loginSucess = value;
      _$loginSucessAtom.reportChanged();
    }, _$loginSucessAtom, name: '${_$loginSucessAtom.name}_set');
  }

  final _$requestLoginAsyncAction = AsyncAction('requestLogin');

  @override
  Future<void> requestLogin() {
    return _$requestLoginAsyncAction.run(() => super.requestLogin());
  }

  final _$_LoginControllerBaseActionController =
      ActionController(name: '_LoginControllerBase');

  @override
  dynamic changeLogin(String loginValue) {
    final _$actionInfo = _$_LoginControllerBaseActionController.startAction();
    try {
      return super.changeLogin(loginValue);
    } finally {
      _$_LoginControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic changeSenha(String senhaValue) {
    final _$actionInfo = _$_LoginControllerBaseActionController.startAction();
    try {
      return super.changeSenha(senhaValue);
    } finally {
      _$_LoginControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'login: ${login.toString()},senha: ${senha.toString()},errorMessage: ${errorMessage.toString()},loginSucess: ${loginSucess.toString()},state: ${state.toString()}';
    return '{$string}';
  }
}
