import 'package:app_financeiro/app/modules/home/home_controller.dart';
import 'package:app_financeiro/app/modules/login/login_module.dart';
import 'package:app_financeiro/app/modules/movimentacoes/movimentacoes_module.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:app_financeiro/app/modules/home/home_page.dart';

class HomeModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => HomeController()),
      ];

  @override
  List<Router> get routers => [
        Router(Modular.initialRoute, child: (_, args) => HomePage()),
        Router('/login', module: LoginModule()),
        Router('/movimentacoes', module: MovimentacoesModule()),
      ];

  static Inject get to => Inject<HomeModule>.of();
}
