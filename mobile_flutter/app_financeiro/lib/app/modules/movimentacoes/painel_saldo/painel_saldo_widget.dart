import 'package:app_financeiro/app/modules/movimentacoes/painel_saldo/painel_saldo_controller.dart';
import 'package:app_financeiro/app/utils/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sliding_sheet/sliding_sheet.dart';

class PainelSaldoWidget extends StatefulWidget {

  final double appBarHeight;

  const PainelSaldoWidget({Key key, this.appBarHeight}) : super(key: key);

  @override
  _PainelSaldoWidgetState createState() => _PainelSaldoWidgetState();
}

class _PainelSaldoWidgetState extends ModularState<PainelSaldoWidget, PainelSaldoController>{
  Widget build(BuildContext context) {
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
        return _makeContainer();
      }
    );
  }
  Widget _makeContainer() {
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
                onPressed: (){}
              ),
              Text("Janeiro/2020",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.green
                )
              ),
              IconButton(
                icon: Icon(Icons.arrow_forward_ios), 
                onPressed: (){},
              )
            ],
          ),
          SizedBox(height: 60),
          Column(
            children: <Widget>[
              Text("Saldo",
                style: TextStyle(
                  fontSize:14
                ),
              ),
              Text("R\$ 300",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.green
                )
              )
            ],
          ),
          Expanded(
            child: Container(),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 30),
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
                          'R\$ 200',
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
                          'R\$ 210',
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
  