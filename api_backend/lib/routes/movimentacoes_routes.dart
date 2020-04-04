import 'package:api_backend/api_backend.dart';
import 'package:api_backend/config/jwt_autentication.dart';
import 'package:api_backend/controllers/movimentacao/movimentacao_controller.dart';


class MovimentacaoRouter{
  static void configurar(Router router, ManagedContext context){
    router.route('movimentacoes/:anoMes')
    .link(()=> JwtAuthentication(context))
    .link(()=> MovimentacaoController(context));

    router.route('movimentacoes/total/:totalAnoMes')
    .link(()=> JwtAuthentication(context))
    .link(()=> MovimentacaoController(context));
    
    router.route('movimentacoes')
    .link(()=> JwtAuthentication(context))
    .link(()=> MovimentacaoController(context));
  }
}