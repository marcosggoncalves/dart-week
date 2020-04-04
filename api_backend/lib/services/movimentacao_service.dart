import 'package:api_backend/api_backend.dart';
import 'package:api_backend/controllers/movimentacao/dto/movimentacao_request.dart';
import 'package:api_backend/model/categoria_model.dart';
import 'package:api_backend/model/movimentacao_model.dart';
import 'package:api_backend/model/usuario_model.dart';
import 'package:api_backend/repository/movimentacao_repository.dart';

class MovimentacaoService{
  MovimentacaoService(this.context) : movimentacaoRepository = MovimentacaoRepository(context);

  final ManagedContext context;
  final MovimentacaoRepository movimentacaoRepository;

  Future<List<MovimentacaoModel>> buscarMovimentacao(UsuarioModel usuario, String anoMes){
    return movimentacaoRepository.buscarMovimentacoes(usuario, anoMes);
  }

  Future<Map<String, dynamic>> recuperarTotalPorTipo(UsuarioModel usuario, String anoMes) async {
    final receitas = await movimentacaoRepository.recuperarTotalMesAno(usuario, TipoCategoria.receita, anoMes);
    final despesas = await movimentacaoRepository.recuperarTotalMesAno(usuario, TipoCategoria.despesa, anoMes);

    return {
      'receitas': receitas,
      'despesas': despesas,
      'total': (receitas['total'] ?? 0)  + (despesas['total'] ?? 0),
      'saldo': (receitas['total'] ?? 0)  + (despesas['total'] * -1 ?? 0)
    };
  }

  Future<void> salvarMovimentacao(UsuarioModel usuario, SalvarMovimentacaoRequest request) async{
    await movimentacaoRepository.salvarMovimentacao(usuario, request);
  }
}