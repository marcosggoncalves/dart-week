import 'package:api_backend/controllers/usuario/dto/cadastro_usuario.dart';
import 'package:api_backend/model/usuario_model.dart';
import 'package:api_backend/utils/criptografia_util.dart';
import 'package:api_backend/utils/jwt_utils.dart';

import 'package:api_backend/api_backend.dart';
import 'package:api_backend/controllers/login/dto/login_request.dart';
import 'package:api_backend/repository/usuario_repository.dart';

class UsuarioService{
  UsuarioService(this.context) : usuarioRepository = UsuarioRepository(context);
  
  final ManagedContext context;
  final UsuarioRepository usuarioRepository;

  Future<dynamic> login(LoginRequest request) async {

    final String login = request.login;
    final String senha = request.senha;
    ///
    final String senhaCriptografada = CriptografiaUtils.criptografarSenha(senha) as String;
    // print(senhaCriptografada);
    final  usuario = await usuarioRepository.recuperarUsuarioPorLoginESenha(login, senhaCriptografada);
    
    if(usuario != null){
      return {
        'autenticado': true,
        'usuario': 'Seja bem vindo ${usuario.login}, Ao sistema financeiro controle já !',
        'token': JwtUtils.gerarTokenJwt(usuario)
      };
    }
    return {
      'autenticado': true,
      'token': null,
      'usuario': null
    };
  }

  Future<void> salvarUsuario(CadastrarUsuarioRequest request) async {
    await usuarioRepository.salvarUsuario(request);
  }

  Future<UsuarioModel> buscarPorId(int id) async{
    return await usuarioRepository.buscarPorId(id); 
  }

   Future<UsuarioModel> buscarUsuario(String usuario) async{
    return await usuarioRepository.buscarUsuario(usuario); 
  }
}