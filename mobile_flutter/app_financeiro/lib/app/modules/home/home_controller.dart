import 'package:app_financeiro/app/mixins/loader.dart';
import 'package:app_financeiro/app/repository/usuario.dart';
import 'package:get/get.dart';
import 'package:mobx/mobx.dart';

part 'home_controller.g.dart';

class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store, LoaderMixin  {
  final UsuarioRepository _usuarioRepository;

  _HomeControllerBase(this._usuarioRepository);

  Future<void> verificaLogado() async {
    showLoader();
    if (await _usuarioRepository.checkLogged()) {
      hideLoader();
      Get.offAllNamed('/movimentacoes');
    } else {
      hideLoader();
      Get.offAllNamed('/login');
    }
  }
}
