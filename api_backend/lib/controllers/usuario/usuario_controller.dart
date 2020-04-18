import 'package:api_backend/api_backend.dart';
import 'package:api_backend/services/usuario_service.dart';

import 'dto/cadastro_usuario.dart';

class UsuarioController extends ResourceController{
  
  UsuarioController(this.context) : usuarioService = UsuarioService(context);

  final ManagedContext context;
  final UsuarioService usuarioService;  

  @Operation.post()
  Future<Response> salvar(@Bind.body() CadastrarUsuarioRequest request) async{
    final  validate = request.validate();
    
    if(validate.isNotEmpty){
      return Response.badRequest(body:validate);
    }

    try{
      await usuarioService.salvarUsuario(request);
      
      return Response.ok({
        'message': 'Usuário cadastrado com sucesso'
      });
    }catch(e){
      return  Response.serverError(body:{'message': 'Não foi possivel efetuar o cadastro, verifique usuário ou senha'});
    }
  }
}