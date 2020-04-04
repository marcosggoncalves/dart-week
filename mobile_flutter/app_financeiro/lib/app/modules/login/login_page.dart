import 'package:app_financeiro/app/components/controleja_button.dart';
import 'package:app_financeiro/app/components/controleja_text_form_field.dart';
import 'package:app_financeiro/app/utils/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get/get.dart';
import 'login_controller.dart';
import 'package:app_financeiro/app/utils/theme_utils.dart';


class LoginPage extends StatefulWidget {
  final String title;
  const LoginPage({Key key, this.title = "Login"}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends ModularState<LoginPage, LoginController> {
  //use 'controller' variable to access controller

  @override
  Widget build(BuildContext context) {

  ThemeUtils.init(context);
  SizeUtils.init(context);

    return Scaffold(
      body: Column(
        children: <Widget>[
          _makeHeader(),
          SizedBox(
            height:30,
          ),  
          _makeForm()
        ],
      ),
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
      child:Padding(
        padding:  EdgeInsets.symmetric(horizontal:20),
        child: Column(
          children: <Widget>[
            ControlejatextFormField(label:'Login'),
            SizedBox(height: 30),
            ControlejatextFormField(label: 'Senha'),
            SizedBox(height: 30),
            ControlejaButton(onPressed: () => Get.toNamed('/movimentacoes'), label: 'Entrar'),
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