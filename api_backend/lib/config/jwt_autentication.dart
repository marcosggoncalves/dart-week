import 'package:api_backend/api_backend.dart';
import 'package:api_backend/services/usuario_service.dart';
import 'package:api_backend/utils/jwt_utils.dart';
import 'package:jaguar_jwt/jaguar_jwt.dart';

class JwtAuthentication extends Controller{

  JwtAuthentication(this.context) : usuarioService = UsuarioService(context);

  final ManagedContext context;
  final UsuarioService usuarioService;
  
  @override
  FutureOr<RequestOrResponse> handle(Request request) async {
    final authHeader = request.raw.headers['authorization'] ;

    if(authHeader == null || authHeader.isEmpty){
      return Response.unauthorized();
    }

    final authHeaderContent = authHeader[0]?.split(" ");

    if(authHeaderContent.length != 2 || authHeaderContent[0] != "Bearer"){
      return Response.badRequest(body:{'message':'Token inválidao'});
    }

    try{
      final token = authHeaderContent[1];
      final JwtClaim claimSet =  JwtUtils.VerificarToken(token);
      final userId = int.tryParse(claimSet.toJson()['sub'].toString());

      if(userId == null){
        throw JwtException;
      }

      final dataAtual = DateTime.now().toUtc();

      if(dataAtual.isAfter(claimSet.expiry)){
        return Response.unauthorized();
      }

      final usuario = await usuarioService.buscarPorId(userId);
      request.attachments['user']  = usuario;

      return request;

    }on JwtException catch(e){
      print(e);
      return Response.unauthorized();
    }
  }
}