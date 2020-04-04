import 'package:api_backend/api_backend.dart';
import 'package:api_backend/controllers/login/login_controller.dart';
import 'package:api_backend/controllers/usuario/usuario_controller.dart';

class UsuarioRouter{
  static void configurar(Router router, ManagedContext context){
    
    router.route('/login').link(()=>LoginController(context));
    router.route('/usuario').link(()=> UsuarioController(context));
  }
}