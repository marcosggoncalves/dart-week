import 'package:app_financeiro/app/core/store_state.dart';
import 'package:app_financeiro/app/model/movimentacao_total.dart';
import 'package:app_financeiro/app/repository/movimentacoes.dart';
import 'package:app_financeiro/app/utils/store_utils.dart';
import 'package:mobx/mobx.dart';
import 'package:intl/intl.dart';
part 'painel_saldo_controller.g.dart';

class PainelSaldoController = _PainelSaldoControllerBase with _$PainelSaldoController;

abstract class _PainelSaldoControllerBase with Store {

  final MovimentacoesRepository movimentacoesRepository;
  _PainelSaldoControllerBase(this.movimentacoesRepository);

  @observable
  DateTime  data = DateTime.now();

  @computed
  String get anoMes => DateFormat("yyyyMM").format(data);

  @action
  nextMonth(){
    data = DateTime(data.year, data.month +1, 1);
  }

  @action
  previousMonth(){
    data = DateTime(data.year, data.month-1, 1);
  }
  
  @observable
  String errorMessage;

  @observable
  ObservableFuture <MovimentacaoTotalModel>  _totalMovimentacao;

  @computed
  StoreState get totalState => StoreUtils.statusCheck(_totalMovimentacao);

  @observable
  MovimentacaoTotalModel movimentacaoTotalModel;

  
  @action
  buscarTotalDoMes() async {
    try{
      errorMessage = '';
      _totalMovimentacao = ObservableFuture(movimentacoesRepository.getTotalMes(anoMes));
      movimentacaoTotalModel = await _totalMovimentacao;
    }catch(e){
      errorMessage  = 'Erro ao buscar totalizadores';
      print(e);
    }
  }
}
