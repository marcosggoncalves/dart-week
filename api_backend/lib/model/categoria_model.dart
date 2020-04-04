import '../api_backend.dart';
import 'movimentacao_model.dart';

class CategoriaModel extends ManagedObject<_CategoriaModel> implements _CategoriaModel {}

// Classes para valores fixos
enum TipoCategoria{
  receita,
  despesa
}

@Table(name: "categoria")
class _CategoriaModel {
  @Column(primaryKey: true, autoincrement: true)
  int id;

  @Column()
  String nome;

  @Column()
  TipoCategoria tipoCategoria;

   ManagedSet<MovimentacaoModel> movimentacoes; /// FK "Realcionamento 1 - N"
}