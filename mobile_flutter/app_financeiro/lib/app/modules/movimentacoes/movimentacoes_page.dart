import 'package:app_financeiro/app/core/store_state.dart';
import 'package:app_financeiro/app/mixins/loader.dart';
import 'package:app_financeiro/app/modules/movimentacoes/components/movimentacao_item.dart';
import 'package:app_financeiro/app/repository/usuario.dart';
import 'package:app_financeiro/app/utils/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get/get.dart';
import 'package:mobx/mobx.dart';
import 'components/cadastrar_movimentacao/cadastrar_movimentacao_controller.dart';
import 'components/cadastrar_movimentacao/cadastrar_movimentacao_widget.dart';
import 'components/painel_saldo/painel_saldo_widget.dart';
import 'movimentacoes_controller.dart';

class MovimentacoesPage extends StatefulWidget {
  final String title;
  const MovimentacoesPage({Key key, this.title = "Movimentações"})
      : super(key: key);

  @override
  _MovimentacoesPageState createState() => _MovimentacoesPageState();
}

class _MovimentacoesPageState
    extends ModularState<MovimentacoesPage, MovimentacoesController> with LoaderMixin {
  //use 'controller' variable to access controlle

  List<ReactionDisposer> disposers;
  CadastrarMovimentacaoController cadastrarController = Modular.get<CadastrarMovimentacaoController>();

  @override
  void initState(){
    super.initState();
    disposers ??= [
      reaction((_) => controller.painelSaldoController.data,(_) => controller.buscarMovimentacoes()),
      reaction((_) => cadastrarController.salvarMovimentacaoStatus, (_) {
        switch (_) {
          case StoreState.loading:
            showLoader();
            break;
          case StoreState.error:
            hideLoader();
            Get.snackbar('Erro', 'Erro ao salvar movimentação');
            break;
          case StoreState.loaded:
            hideLoader();
            Get.back();
            controller.buscarMovimentacoes();
            controller.painelSaldoController.buscarTotalDoMes();
            break;
        }
       }),
        reaction((_) => cadastrarController.categoriasStatus, (categoriaStatus) {
          switch(categoriaStatus) {
            case StoreState.loading:
              showLoader();
              break;
            case StoreState.loaded:
              hideLoader();
              _showInsertModal();
              break;
          }
        })
    ];  
    
    controller.buscarMovimentacoes();
    // hideLoader();
  }

  @override
  void dispose() {
    super.dispose();
    disposers.forEach((d) => d());
  }

  @override
  Widget build(BuildContext context) {

    AppBar appBar  =  AppBar(
      centerTitle: true,
      title: Text(widget.title),
      actions: <Widget>[
        PopupMenuButton<String>(
          icon: Icon(Icons.add),
          onSelected: (item){
           cadastrarController.buscarCategorias(item);
          },
          itemBuilder: (_){
            return [
              PopupMenuItem<String>(
                value : 'receita',
                child: Text('Receita')
              ),
              PopupMenuItem<String>(
                value : 'despesa',
                child: Text('Despesas')
              )
            ];
          },
        ),
        IconButton(
          icon: Icon(
            Icons.exit_to_app,
            color: Colors.white
          ),
          onPressed: () {
            Modular.get<UsuarioRepository>().logout();
            Get.offAllNamed('/login');
          },  
        )
      ],
    );

    return Scaffold(
      appBar: appBar,
      body: Container(
        height: SizeUtils.heightScreen,
        child: Stack(
          children: <Widget>[
            Observer(builder: (_){
              switch (controller.movimentacoesState) {
                case StoreState.initial:
                case StoreState.loading:
                  return  Container(
                    height: SizeUtils.heightScreen,
                    alignment: Alignment.topCenter,
                    child: Container(
                      margin: EdgeInsets.only(top: 30),
                      child: CircularProgressIndicator(),
                    ),
                  );
                case StoreState.loaded:
                  return _makeContent();
                case StoreState.error:
                  Get.snackbar('Erro ao buscar dados', controller.errorMessage);
                  return Container();
              }
            }),
            PainelSaldoWidget(
              appBarHeight: appBar.preferredSize.height,
            )
          ],
        )
      )
    );
  }
  Widget _makeContent(){
    return Column(
      children: <Widget>[
        Expanded(
            child: 
            ListView.separated(
              itemBuilder: (_, index) => MovimentacaoItem(item: controller.movimentacoes[index]),
              separatorBuilder: (_, index) => Divider(color: Colors.black38), 
              itemCount: controller.movimentacoes?.length ?? 0
            ) 
          ),
          SizedBox(
          height: SizeUtils.heightScreen * 0.09,
        )
      ] ,
    );
  }

  _showInsertModal() { 
    cadastrarController.resetForm();
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
        title: Text('Adicionar'),
        content: CadastrarMovimentacaoWidget(),
        actions: <Widget>[
           FlatButton(
            onPressed: () => Get.offAllNamed('/movimentacoes'),
            child: const Text("CANCELAR"),
          ),
          FlatButton(
            onPressed: () => cadastrarController.salvarMovimento(),
            child: const Text("SALVAR"),
          )
        ],
      )
      );
  }
}
