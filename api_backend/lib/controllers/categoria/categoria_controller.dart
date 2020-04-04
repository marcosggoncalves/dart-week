import 'package:api_backend/api_backend.dart';
import 'package:api_backend/model/categoria_model.dart';
import 'package:api_backend/services/categoria_service.dart';

class CategoriasController extends ResourceController {
    
    CategoriasController(this.context) : categoriaService = CategoriaService(context);

    final ManagedContext context;
    final CategoriaService categoriaService;

    @Operation.get('tipo')
    Future<Response> buscarCategoriaPorTipo() async{
      try{
        final tipo = request.path.variables['tipo'];
        final tipocategoria = TipoCategoria.values.firstWhere((t)=>t.toString().split('.').last == tipo);

        return categoriaService.buscarCategoriaPorTipo(tipocategoria)
              .then((res) => res.map((categoria) => {'id' : categoria.id,'nome': categoria.nome.toString()}).toList())
              .then((data) => Response.ok(data));
      }catch(e){
        print(e);
        return Response.serverError(body: {'message': e.toString()});
      }
    }
}