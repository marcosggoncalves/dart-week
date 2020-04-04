import 'package:api_backend/api_backend.dart';
import 'package:api_backend/config/jwt_autentication.dart';
import 'package:api_backend/controllers/categoria/categoria_controller.dart';

class CategoriaRouter{
  static void configurar(Router router, ManagedContext context){
   router.route('/categorias/:tipo')
   .link(()=> JwtAuthentication(context))
   .link(()=> CategoriasController(context));
  }
}