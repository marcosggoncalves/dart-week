import 'package:api_backend/model/usuario_model.dart';
import 'package:jaguar_jwt/jaguar_jwt.dart';

class JwtUtils{

  static const String _jwtChavePrivada = "2wkjdjh23yte2763r37etwdgcghvsghvxghsaghcasfghfdghASFGHDFDSGHFDHGSFDHSFDHS";

  static String gerarTokenJwt(UsuarioModel usuario){
    final claimSet = JwtClaim(
      issuer: 'http://localhost',
      subject: usuario.id.toString(),
      otherClaims: <String, dynamic>{},
      maxAge: Duration(days: 1)
    );

    final token = 'Bearer ${issueJwtHS256(claimSet, _jwtChavePrivada)}';

    return token;
  }

  static JwtClaim VerificarToken(String token){
    return verifyJwtHS256Signature(token, _jwtChavePrivada);
  }
}