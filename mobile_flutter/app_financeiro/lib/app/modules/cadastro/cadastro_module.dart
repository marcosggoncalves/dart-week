import 'package:app_financeiro/app/modules/cadastro/cadastro_controller.dart';
import 'package:app_financeiro/app/modules/login/login_module.dart';
import 'package:app_financeiro/app/repository/usuario.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:app_financeiro/app/modules/cadastro/cadastro_page.dart';

class CadastroModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => CadastroController(i.get<UsuarioRepository>())),
      ];

  @override
  List<Router> get routers => [
        Router(Modular.initialRoute, child: (_, args) => CadastroPage()),
        // Router('/login', module: LoginModule()),
      ];

  static Inject get to => Inject<CadastroModule>.of();
}
