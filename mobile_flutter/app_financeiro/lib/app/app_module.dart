import 'package:app_financeiro/app/app_controller.dart';
import 'package:app_financeiro/app/modules/movimentacoes/movimentacoes_module.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:app_financeiro/app/app_widget.dart';
import 'package:app_financeiro/app/modules/home/home_module.dart';
import 'package:app_financeiro/app/modules/login/login_module.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [
        Bind((i) => AppController()),
      ];

  @override
  List<Router> get routers => [
    Router(Modular.initialRoute, module: HomeModule()),
    Router('/login', module: LoginModule()),
    Router('/movimentacoes', module: MovimentacoesModule()),
  ];

  @override
  Widget get bootstrap => AppWidget();

  static Inject get to => Inject<AppModule>.of();
}

// slidy g m modules/login -c
// slidy run mobx_build