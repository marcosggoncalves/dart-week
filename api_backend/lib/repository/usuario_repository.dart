import 'package:api_backend/api_backend.dart';
import 'package:api_backend/controllers/usuario/dto/cadastro_usuario.dart';
import 'package:api_backend/model/usuario_model.dart';
import 'package:api_backend/utils/criptografia_util.dart';

class UsuarioRepository{
  UsuarioRepository(this.context);
  final ManagedContext context;

  Future<UsuarioModel> recuperarUsuarioPorLoginESenha(String login, String senha){
    final query = Query<UsuarioModel>(context)
    ..where((usuario)=> usuario.login).equalTo(login)
    ..where((usuario)=> usuario.senha).equalTo(senha);
    return query.fetchOne();
  }

  Future<void> salvarUsuario(CadastrarUsuarioRequest request) async{
    final usuarioSave =  UsuarioModel()..read(request.asMap());
    usuarioSave.senha = CriptografiaUtils.criptografarSenha(request.senha) as String;
    await  context.insertObject(usuarioSave);
  }

  Future<UsuarioModel> buscarPorId(int id) async{
    final query = Query<UsuarioModel>(context)..where((usuario) => usuario.id).equalTo(id);
    return  await query.fetchOne();
  }

  Future<UsuarioModel> buscarUsuario(String nome) async{
    final query = Query<UsuarioModel>(context)..where((usuario) => usuario.login).equalTo(nome);
    return  await query.fetchOne();
  }
}