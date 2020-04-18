import 'package:app_financeiro/app/components/controleja_button.dart';
import 'package:app_financeiro/app/components/controleja_text_form_field.dart';
import 'package:app_financeiro/app/core/store_state.dart';
import 'package:app_financeiro/app/mixins/loader.dart';
import 'package:app_financeiro/app/utils/size_utils.dart';
import 'package:app_financeiro/app/utils/theme_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get/get.dart';
import 'package:mobx/mobx.dart';
import 'cadastro_controller.dart';

class CadastroPage extends StatefulWidget {
  final String title;
  const CadastroPage({Key key, this.title = "Cadastro"}) : super(key: key);

  @override
  _CadastroPageState createState() => _CadastroPageState();
}

class _CadastroPageState
    extends ModularState<CadastroPage, CadastroController> with LoaderMixin{
  //use 'controller' variable to access controller

  AppBar appBar = AppBar(
    elevation: 0,
  );

  List<ReactionDisposer> _disposer;

  @override
  void initState(){
    super.initState();

    _disposer??=[
      reaction((_)=> controller.state, (StoreState state){
        if(state == StoreState.loading){
          showLoader();
        }else if(state == StoreState.loaded){
          hideLoader();
          Get.snackbar('Cadastro realizado com sucesso', 'Seus dados foram registrado em nosso banco de dados',
            backgroundColor: Colors.white
          );
          Get.offAllNamed('/login');
        }
      }),
      reaction((_)=> controller.errorMessage, (String error){
        if(error.isNotEmpty){
          Get.snackbar('Erro: ', error,
            backgroundColor: Colors.white
          );
        }
      }),
      reaction((_)=> controller.errorMessage, (String errorMessage){
        if(errorMessage.isNotEmpty){
          hideLoader();

          Get.snackbar('Error ao realizar login', errorMessage,
            backgroundColor: Colors.white
          );
        }
      }),
    ];
  }

  @override
  Widget build(BuildContext context) {
    ThemeUtils.init(context);
    SizeUtils.init(context);

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _makeHeader(),
            SizedBox(
              height:30,
            ),
            _makeForm()
          ],
        ), 
      )
    );
  }
  Widget _makeHeader(){
    return Container(
      color:ThemeUtils.primaryColor,
      width: SizeUtils.widthScreen,
      height:(SizeUtils.heightScreen * .5) - (SizeUtils.statuBarHeight + appBar.preferredSize.height),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            bottom: 105,
            child: Image.asset('assets/images/logo.png'),
          )
        ],
      )
    );
  }

  Form _makeForm(){
    return Form(
      key: controller.globalKey,
      child:Padding(
        padding:  EdgeInsets.symmetric(horizontal:20),
        child: Column(
          children: <Widget>[
            ControlejatextFormField(
              label:'Usuário',
              icon: Icons.people,
              onChange: (String login) => controller.changeLogin(login),
              validator: (String login){
                if(login.isEmpty){
                  return 'Login é obrigatório';
                }
                return null;
              },
            ),
            SizedBox(
              height: 30
            ),
            ControlejatextFormField(
              label: 'Senha',
              icon: Icons.lock_open,
              onChange: (String senha) => controller.changeSenha(senha),
              validator: (String senha){
                if(senha.isEmpty){
                  return 'Senha é obrigatório';
                }
                return null;
              },
            ),
            SizedBox(height: 30),
             ControlejatextFormField(
               label: 'Confirmar senha',
               icon: Icons.lock_outline,
               onChange: (String senha) => controller.changeConfirmSenha(senha),
              validator: (String senha){
                if(senha.isNotEmpty){
                  if(senha != controller.senha){
                    return 'Senhas não conferem';
                  }
                  return null;
                }else{
                  return 'Confirmação de senha é obrigatório';
                }
              },
            ),
            SizedBox(height: 30),
            ControlejaButton(onPressed: () => controller.cadastrarUsuario() ,label: 'Cadastra-se'),
            SizedBox(
              height: 30
            ),
          ],
        )
      )
    );
  }
}
