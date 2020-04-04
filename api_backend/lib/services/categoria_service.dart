import 'package:api_backend/api_backend.dart';
import 'package:api_backend/model/categoria_model.dart';
import 'package:api_backend/repository/categoria_repository.dart';

class CategoriaService{
  CategoriaService(this.context) : categoriaRepository = CategoriaRepository(context);
  
  final ManagedContext context;
  final CategoriaRepository categoriaRepository;

  Future<List<CategoriaModel>> buscarCategoriaPorTipo(TipoCategoria tipo){
    return categoriaRepository.buscarCategoriaPorTipo(tipo);
  }
}