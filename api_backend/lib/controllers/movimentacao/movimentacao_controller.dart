import 'package:api_backend/controllers/movimentacao/dto/movimentacao_request.dart';
import 'package:api_backend/model/usuario_model.dart';
import 'package:api_backend/services/movimentacao_service.dart';
import 'package:intl/intl.dart';

import '../../api_backend.dart';

class MovimentacaoController extends ResourceController {
  
  MovimentacaoController(this.context) : movimentacaoService = MovimentacaoService(context);

  final ManagedContext context;
  final MovimentacaoService movimentacaoService;
  
  @Operation.get('anoMes')
  Future<Response> buscarTodasMovimentacoes(){
    final anoMes = request.path.variables['anoMes'];
    final DateFormat  dateformat = DateFormat('yyyy-MM-dd');
    final UsuarioModel usuario =  request.attachments['user'] as UsuarioModel;

    return 
      movimentacaoService.buscarMovimentacao(usuario, anoMes)
      .then((data){
         return data.map((movimentacao) =>{
          'id': movimentacao.id,
          'dataMovimentacao': dateformat.format(movimentacao.dataMovimentacao),
          'descricao': movimentacao.descricao,
          'valor': movimentacao.valor,
          'categoria': {
            'id':  movimentacao.categoria.id,
            'nome':  movimentacao.categoria.nome,
            'tipo': movimentacao.categoria.tipoCategoria.toString()
          }
        }).toList();
      }).then((lista) => Response.ok(lista)); 
    } 
    
    @Operation.get('totalAnoMes')
    Future<Response> recuperarTotalMesAno(@Bind.path('totalAnoMes') String mesAno) async{
      final usuario = request.attachments['user'] as UsuarioModel;
      final resultado = await movimentacaoService.recuperarTotalPorTipo(usuario, mesAno);

      return Response.ok(resultado);
    }

    @Operation.post()
    Future<Response> salvarMovimento(@Bind.body() SalvarMovimentacaoRequest requestSalvar) async{
      
      try{
        final validate = requestSalvar.validate();

        if(validate.isNotEmpty){
          return Response.badRequest(body: validate);
        }
        final usuario = request.attachments['user'] as UsuarioModel;
        await movimentacaoService.salvarMovimentacao(usuario, requestSalvar);
        return Response.ok({
          'message': 'Movimentação salva com sucesso'
        });
      }catch(e){
        return Response.serverError(body: {"message": "Erro ao salvar movimentação"});
      }
    }
}