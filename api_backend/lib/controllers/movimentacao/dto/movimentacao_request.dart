import 'package:api_backend/api_backend.dart';

class SalvarMovimentacaoRequest extends Serializable{
  
  int categoria;
  DateTime dataMovimentacao;
  String descricao;
  double valor;

  @override
  Map<String, dynamic> asMap() {
    return {
      'categoria': categoria,
      'dataMovimentacao': dataMovimentacao,
      'descricao': descricao,
      'valor': valor
    };
  }

  @override
  void readFromMap(Map<String, dynamic> object) {
    categoria = object['categoria'] as int;
    descricao = object['descricao'] as String;
    final dataMovimentoStr = object['dataMovimentacao'] as String;
    dataMovimentacao = dataMovimentoStr != null ? DateTime.parse(dataMovimentoStr) : null;
    valor = object['valor'] as double;
  }

  Map<String,String> validate(){

    final Map<String,String> validateResult = {};

    if(categoria == null){
      validateResult['categoria'] = 'Categoria obrigatória';
    }
    
    if(descricao == null || descricao.isEmpty){
      validateResult['categoria'] = 'Descrição obrigatória';
    }

    if(valor == null){
      validateResult['valor'] = 'Valor não informado';
    }

    if(dataMovimentacao == null){
      validateResult['dataMovimentacao'] = 'Data de Movimentação não informada';
    }

    return validateResult;
  }
}