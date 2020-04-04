import 'package:app_financeiro/app/modules/movimentacoes/components/movimentacao_item.dart';
import 'package:app_financeiro/app/modules/movimentacoes/painel_saldo/painel_saldo_widget.dart';
import 'package:app_financeiro/app/utils/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'movimentacoes_controller.dart';

class MovimentacoesPage extends StatefulWidget {
  final String title;
  const MovimentacoesPage({Key key, this.title = "Movimentações"})
      : super(key: key);

  @override
  _MovimentacoesPageState createState() => _MovimentacoesPageState();
}

class _MovimentacoesPageState
    extends ModularState<MovimentacoesPage, MovimentacoesController> {
  //use 'controller' variable to access controlle

  @override
  Widget build(BuildContext context) {

    AppBar appBar  =  AppBar(
      centerTitle: true,
      title: Text(widget.title),
      actions: <Widget>[
        PopupMenuButton<String>(
          icon: Icon(Icons.add),
          itemBuilder: (_){
            return [
              PopupMenuItem<String>(
                value : 'Receita',
                child: Text('Receita')
              ),
              PopupMenuItem<String>(
                value : 'Despesas',
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
          onPressed: (){},
        )
      ],
    );

    return Scaffold(
      appBar: appBar,
      body: Container(
        height: SizeUtils.heightScreen,
        child: Stack(
          children: <Widget>[
            _makeContent(),
            PainelSaldoWidget(appBarHeight: appBar.preferredSize.height)
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
              itemBuilder: (_, index) => MovimentacaoItem(),
              separatorBuilder: (_, index) => Divider(color: Colors.black38), 
              itemCount: 10
            ) 
          )
      ] ,
    );
  }
}
