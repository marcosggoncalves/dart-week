import 'dart:io';

import 'package:app_financeiro/app/core/store_state.dart';
import 'package:app_financeiro/app/modules/movimentacoes/components/painel_saldo/painel_saldo_controller.dart';
import 'package:app_financeiro/app/utils/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';
import 'package:sliding_sheet/sliding_sheet.dart';

class PainelSaldoWidget extends StatefulWidget {

  final double appBarHeight;

  const PainelSaldoWidget({Key key, this.appBarHeight}) : super(key: key);

  @override
  _PainelSaldoWidgetState createState() => _PainelSaldoWidgetState();
}

class _PainelSaldoWidgetState extends ModularState<PainelSaldoWidget, PainelSaldoController>{

  List<ReactionDisposer> disposers;
  

  @override
  void initState(){
    super.initState();
    disposers ??=[
      reaction((_)=> controller.data, (_)=> controller.buscarTotalDoMes())
    ];
    controller.buscarTotalDoMes();
  }

  @override
  void dispose() {
    super.dispose();
    disposers.forEach((d) => d());
  }

  Widget build(BuildContext context) {
    return Observer(
       builder : (_){
        return SlidingSheet(
          elevation: 4,
          cornerRadius: 30,
          snapSpec: SnapSpec(
            snap: true,
            snappings: [0.1, 0.8],
            positioning: SnapPositioning.relativeToAvailableSpace
          ),
          headerBuilder: (_, state) {
            return Container(
                width:60,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey, 
                  borderRadius: BorderRadius.circular(20)
              ),
            );
          },
           builder: (_, state) {
            return Observer(builder: (_) {
              switch (controller.totalState) {
                  case StoreState.initial:
                  case StoreState.loading:
                    return Container(
                      height: SizeUtils.heightScreen,
                      alignment: Alignment.topCenter,
                      child: Container(
                        margin: EdgeInsets.only(top: 30),
                        child: CircularProgressIndicator(),
                      ),
                    );
                  case StoreState.loaded:
                    return _makeContainer();
                  case StoreState.error:
                    return Text(controller.errorMessage);
                }
                return Container();
            });
          },
        );
       }
    );
  }
  Widget _makeContainer() {
    var model = controller.movimentacaoTotalModel;
    var numberFormat = NumberFormat('###.00','pt_BR');
    
    return Container(
      width: SizeUtils.widthScreen,
      height: SizeUtils.heightScreen * .4 - widget.appBarHeight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget> [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () => controller.previousMonth()
              ),
              Text(DateFormat.yMMMM('pt_BR').format(controller.data),
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: model.saldo >= 0 ? Colors.green : Colors.red
                )
              ),
              IconButton(
                icon: Icon(Icons.arrow_forward_ios), 
                onPressed: () => controller.nextMonth(),
              )
            ],
          ),
          SizedBox(height: Platform.isIOS ? 30 : 60),
          Column(
            children: <Widget>[
              Text("Saldo",
                style: TextStyle(
                  fontSize:14
                ),
              ),
              Text("R\$ ${model.saldo != null ? numberFormat.format(model.saldo) : '-'}",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: model.saldo >= 0 ? Colors.green : Colors.red
                )
              )
            ],
          ),
          Expanded(
            child: Container(),
          ),
          Container(
            margin: EdgeInsets.only(bottom:  Platform.isIOS ? 30 : 10),
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
               Row(
                 children: <Widget>[
                    Padding(
                      padding:  const EdgeInsets.only(right :0.8),
                      child: CircleAvatar(
                        backgroundColor: Color(0xff4bce97),
                        foregroundColor: Colors.white,
                        child: Icon(Icons.arrow_upward),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text("Receitas",
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xff4bce97)
                          )
                        ),
                        Text(
                          'R\$ ${model.saldo != null ? numberFormat.format(model.receitas.total) : '-'}',
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xff4bce97)
                          ),
                        )
                      ],
                    )
                 ],
               ),
              Row(
                 children: <Widget>[
                    Padding(
                      padding:  const EdgeInsets.only(right :0.8),
                      child: CircleAvatar(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        child: Icon(Icons.arrow_downward),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text("Despesas",
                          style: TextStyle(
                            fontSize: 14,
                            color:Colors.red
                          )
                        ),
                        Text(
                          'R\$ ${model.saldo != null ? numberFormat.format(model.despesas.total) : '-'}',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.red
                          ),
                        )
                      ],
                    )
                 ],
               )
              ],
            ),
          )
        ]
      )
    );
  }
}
  