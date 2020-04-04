import 'package:api_backend/api_backend.dart';
import 'package:api_backend/model/categoria_model.dart';

class CategoriaRepository{
  CategoriaRepository(this.context);
  final ManagedContext context;

  Future<List<CategoriaModel>> buscarCategoriaPorTipo(TipoCategoria tipoCategoria){
    final query = Query<CategoriaModel>(context)
    ..where((categoria) => categoria.tipoCategoria).equalTo(tipoCategoria);
    return query.fetch();
  }

  Future<CategoriaModel> buscarPorID(int id){
    final query = Query<CategoriaModel>(context)
    ..where((categoria) => categoria.id).equalTo(id);
    return query.fetchOne();
  }


}