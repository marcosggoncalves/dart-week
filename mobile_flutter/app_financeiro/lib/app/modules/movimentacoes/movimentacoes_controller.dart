import 'package:app_financeiro/app/core/store_state.dart';
import 'package:app_financeiro/app/model/movimentacao.dart';
import 'package:app_financeiro/app/repository/movimentacoes.dart';
import 'package:app_financeiro/app/utils/store_utils.dart';
import 'package:mobx/mobx.dart';

import 'components/painel_saldo/painel_saldo_controller.dart';

part 'movimentacoes_controller.g.dart';

class MovimentacoesController = _MovimentacoesControllerBase with _$MovimentacoesController;

abstract class _MovimentacoesControllerBase with Store {
  final MovimentacoesRepository movimentacoesRepository;
  final PainelSaldoController painelSaldoController;

  _MovimentacoesControllerBase(this.movimentacoesRepository, this.painelSaldoController);

  @observable
  String errorMessage;

  @observable
  ObservableFuture<List<MovimentacaoModel>> _movimentacoesFuture;

  @observable
  ObservableList<MovimentacaoModel> movimentacoes;

  @computed
  StoreState get movimentacoesState => StoreUtils.statusCheck(_movimentacoesFuture);

  @action
  Future<void> buscarMovimentacoes() async{
    try{
      _movimentacoesFuture = ObservableFuture(movimentacoesRepository.getMovimentacoes(painelSaldoController.anoMes));
      List<MovimentacaoModel> movimentacoesResultado = await _movimentacoesFuture;
      movimentacoes = movimentacoesResultado.asObservable();
    }catch(e){
      errorMessage = "Não foi possivel listar movimentações de conta";
      print(e);
    }
  }
}
