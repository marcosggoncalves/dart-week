import 'package:app_financeiro/app/repository/usuario.dart';
import 'package:app_financeiro/app/utils/size_utils.dart';
import 'package:app_financeiro/app/utils/theme_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get/get.dart';
import 'home_controller.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key key, this.title = "Home"}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeController> {
  //use 'controller' variable to access controller

  @override
  Widget build(BuildContext context) {

    ThemeUtils.init(context);
    Future.delayed(Duration.zero, () async{
     final status = await Modular.get<UsuarioRepository>().checkLogged();
     final future = new Future.delayed(const Duration(milliseconds: 200));

      future.asStream()
      .listen((res) {
          if(status){
            Get.offAllNamed('/movimentacoes');
          }else{
            Get.offAllNamed('/login');
          }
      });
    });

     return Scaffold(
      body: Container(
        color:ThemeUtils.primaryColor,
        width: SizeUtils.widthScreen,
        height:SizeUtils.heightScreen,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
              top: 50,
              bottom: 50,
              child: Image.asset('assets/images/logo.png'),
            ),
          ],
        )
      )
    );
  }
}
