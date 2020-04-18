import 'package:app_financeiro/app/core/custom_core.dart';
import 'package:app_financeiro/app/model/categorias.dart';

class CategoriaRepository{
  
  Future<List<CategoriaModel>>getCategorias(String tipo){
    final dio = CustomDio.withAuthentication().instance;
    return dio.get('/categorias/$tipo') // 1:27:2
    .then((res) => res.data.map<CategoriaModel>((categoria) => CategoriaModel.fromMap(categoria)).toList());
  }
}