import 'package:app_financeiro/app/components/controleja_button.dart';
import 'package:app_financeiro/app/components/controleja_text_form_field.dart';
import 'package:app_financeiro/app/core/store_state.dart';
import 'package:app_financeiro/app/mixins/loader.dart';
import 'package:app_financeiro/app/utils/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get/get.dart';
import 'package:mobx/mobx.dart';
import 'login_controller.dart';
import 'package:app_financeiro/app/utils/theme_utils.dart';


class LoginPage extends StatefulWidget {
  final String title;
  const LoginPage({Key key, this.title = "Login"}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends ModularState<LoginPage, LoginController> with  LoaderMixin {
  //use 'controller' variable to access controller

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
        }
      }),
      reaction((_)=> controller.loginSucess, (sucess){
        if(sucess != null){
          if(sucess){
            Get.offAllNamed('/movimentacoes');
          }else{
            Get.snackbar('Error ao realizar login', 'Login ou senha inválidos',
              backgroundColor: Colors.white
            );
          }
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
      body: SingleChildScrollView(
        child:  Column(
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
      height:(SizeUtils.heightScreen * .5) - SizeUtils.statuBarHeight,
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
              onChange: (String login) =>  controller.changeLogin(login),
              validator: (String login){
                if(login.isEmpty){
                  return 'Login é obrigatório';
                }
                return null;
              },
            ),
            SizedBox(height: 30),
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
            ControlejaButton(onPressed: () => controller.requestLogin(), label: 'Entrar'),
            SizedBox(
              height: 30
            ),
            FlatButton(
              onPressed: () => Get.toNamed('/login/cadastro'), // Redirecionar para rota cadastro
              child: Text("Cadastre-se",
                style: TextStyle(
                  color: ThemeUtils.primaryColor,
                  fontSize: 20
                )
              ),
            )
          ],
        )
      )
    );
  }
}

// slidy g m modules/cadastro -c