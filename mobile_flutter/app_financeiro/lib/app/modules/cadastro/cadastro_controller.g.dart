// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cadastro_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CadastroController on _CadastroControllerBase, Store {
  Computed<StoreState> _$stateComputed;

  @override
  StoreState get state =>
      (_$stateComputed ??= Computed<StoreState>(() => super.state)).value;

  final _$loginAtom = Atom(name: '_CadastroControllerBase.login');

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

  final _$senhaAtom = Atom(name: '_CadastroControllerBase.senha');

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

  final _$confirmasenhaAtom =
      Atom(name: '_CadastroControllerBase.confirmasenha');

  @override
  String get confirmasenha {
    _$confirmasenhaAtom.context.enforceReadPolicy(_$confirmasenhaAtom);
    _$confirmasenhaAtom.reportObserved();
    return super.confirmasenha;
  }

  @override
  set confirmasenha(String value) {
    _$confirmasenhaAtom.context.conditionallyRunInAction(() {
      super.confirmasenha = value;
      _$confirmasenhaAtom.reportChanged();
    }, _$confirmasenhaAtom, name: '${_$confirmasenhaAtom.name}_set');
  }

  final _$_cadastroFutureAtom =
      Atom(name: '_CadastroControllerBase._cadastroFuture');

  @override
  ObservableFuture<dynamic> get _cadastroFuture {
    _$_cadastroFutureAtom.context.enforceReadPolicy(_$_cadastroFutureAtom);
    _$_cadastroFutureAtom.reportObserved();
    return super._cadastroFuture;
  }

  @override
  set _cadastroFuture(ObservableFuture<dynamic> value) {
    _$_cadastroFutureAtom.context.conditionallyRunInAction(() {
      super._cadastroFuture = value;
      _$_cadastroFutureAtom.reportChanged();
    }, _$_cadastroFutureAtom, name: '${_$_cadastroFutureAtom.name}_set');
  }

  final _$errorMessageAtom = Atom(name: '_CadastroControllerBase.errorMessage');

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

  final _$cadastrarUsuarioAsyncAction = AsyncAction('cadastrarUsuario');

  @override
  Future<void> cadastrarUsuario() {
    return _$cadastrarUsuarioAsyncAction.run(() => super.cadastrarUsuario());
  }

  final _$_CadastroControllerBaseActionController =
      ActionController(name: '_CadastroControllerBase');

  @override
  dynamic changeLogin(String loginValue) {
    final _$actionInfo =
        _$_CadastroControllerBaseActionController.startAction();
    try {
      return super.changeLogin(loginValue);
    } finally {
      _$_CadastroControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic changeSenha(String senhaValue) {
    final _$actionInfo =
        _$_CadastroControllerBaseActionController.startAction();
    try {
      return super.changeSenha(senhaValue);
    } finally {
      _$_CadastroControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic changeConfirmSenha(String confimSenhaValue) {
    final _$actionInfo =
        _$_CadastroControllerBaseActionController.startAction();
    try {
      return super.changeConfirmSenha(confimSenhaValue);
    } finally {
      _$_CadastroControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'login: ${login.toString()},senha: ${senha.toString()},confirmasenha: ${confirmasenha.toString()},errorMessage: ${errorMessage.toString()},state: ${state.toString()}';
    return '{$string}';
  }
}
