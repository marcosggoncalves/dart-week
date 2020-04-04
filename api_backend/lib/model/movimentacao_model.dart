import 'package:api_backend/model/categoria_model.dart';
import 'package:api_backend/model/usuario_model.dart';

import '../api_backend.dart';

class MovimentacaoModel extends ManagedObject<_MovimentacaoModel> implements _MovimentacaoModel {}

@Table(name:"movimentacao")
class _MovimentacaoModel {
  @Column(primaryKey: true, autoincrement: true)
  int id;

  @Column()
  DateTime dataMovimentacao;

  @Column()
  String descricao;

  @Column()
  double valor;

  @Relate(#movimentacoes)
  UsuarioModel usuario;

  @Relate(#movimentacoes)
  CategoriaModel categoria;
}