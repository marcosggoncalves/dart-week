import 'package:app_financeiro/app/core/store_state.dart';
import 'package:app_financeiro/app/repository/usuario.dart';
import 'package:app_financeiro/app/utils/store_utils.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'cadastro_controller.g.dart';

class CadastroController = _CadastroControllerBase with _$CadastroController;

abstract class _CadastroControllerBase with Store {
  
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  final UsuarioRepository usuarioRepository;

  _CadastroControllerBase(this.usuarioRepository);

  @observable 
  String login;

  @observable
  String senha;

  @observable
  String confirmasenha;

  @action
  changeLogin(String loginValue) => login = loginValue;

  @action
  changeSenha(String senhaValue) => senha = senhaValue;

  @action
  changeConfirmSenha(String confimSenhaValue) => confirmasenha = confimSenhaValue;

  @observable
  ObservableFuture _cadastroFuture;

  @computed
  StoreState get state => StoreUtils.statusCheck(_cadastroFuture);

  @observable
  String errorMessage;

  @action
  Future<void> cadastrarUsuario() async{
    if(globalKey.currentState.validate()){
      try{        
         errorMessage = '';
        _cadastroFuture = ObservableFuture(usuarioRepository.cadastrarUsuario(login, senha));  
        await _cadastroFuture;
      }catch(e){
        errorMessage = 'Não foi possivel realizar o cadastro, tente novamente.';
      }
    }
  }
}
