import 'package:api_backend/api_backend.dart';
import 'package:api_backend/controllers/movimentacao/dto/movimentacao_request.dart';
import 'package:api_backend/model/categoria_model.dart';
import 'package:api_backend/model/movimentacao_model.dart';
import 'package:api_backend/model/usuario_model.dart';
import 'package:api_backend/repository/categoria_repository.dart';
import 'package:intl/intl.dart';

class MovimentacaoRepository{
  MovimentacaoRepository(this.context) : categoriaRepository = CategoriaRepository(context);
  
  final ManagedContext context;
  final CategoriaRepository categoriaRepository;

  Future<List<MovimentacaoModel>> buscarMovimentacoes(UsuarioModel usuario, String anoMes){
    final DateFormat format = DateFormat('yyyy_MM_DD');
    final inicio = format.parse('${anoMes.substring(0,4)}_${anoMes.substring(4)}_01');
    final fim = format.parse('${anoMes.substring(0,4)}_${anoMes.substring(4)}_31');

    final query = Query<MovimentacaoModel>(context)
      ..join(object: (movimentacao) => movimentacao.categoria)
      ..where((movimentacao) => movimentacao.usuario.id).equalTo(usuario.id)
      ..where((movimentacao) => movimentacao.dataMovimentacao).between(inicio, fim)
      ..sortBy((movimentacao) =>  movimentacao.dataMovimentacao, QuerySortOrder.ascending)
      ..sortBy((movimentacao) =>  movimentacao.dataMovimentacao, QuerySortOrder.ascending);

      return query.fetch();
  }
  
  Future<Map<String, dynamic>> recuperarTotalMesAno(UsuarioModel usuario , TipoCategoria tipoCategoria, String anoMes) async{  
    final DateFormat format = DateFormat('yyyy_MM_DD');
    final inicio = format.parse('${anoMes.substring(0,4)}_${anoMes.substring(4)}_01');
    final fim = format.parse('${anoMes.substring(0,4)}_${anoMes.substring(4)}_31');

    final query = Query<MovimentacaoModel>(context)
      ..join(object: (movimentacao) => movimentacao.categoria)
      ..where((movimentacao) => movimentacao.usuario.id).equalTo(usuario.id)
      ..where((movimentacao) => movimentacao.dataMovimentacao).between(inicio, fim)
      ..where((movimentacao) => movimentacao.categoria.tipoCategoria).equalTo(tipoCategoria);

    final List<MovimentacaoModel> resultado = await query.fetch();
    final num total  = resultado.fold(0.0, (total, movimentacao)=> total += movimentacao.valor);

    return {
      'tipo': tipoCategoria.toString(),
      'total': total
    };
  }

  Future<void> salvarMovimentacao(UsuarioModel usuario, SalvarMovimentacaoRequest request) async{
    final categoria = await categoriaRepository.buscarPorID(request.categoria);
    final model = MovimentacaoModel();

    model.categoria = categoria;
    model.dataMovimentacao = request.dataMovimentacao;
    model.descricao = request.descricao;
    model.usuario = usuario;
    model.valor = request.valor;


    await context.insertObject(model);

  }
}