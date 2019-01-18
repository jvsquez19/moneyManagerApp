
import 'package:flutter/material.dart';
import '../blocs/transactionBloc.dart';
import 'dart:math';

class ReportScreen extends StatelessWidget{

  double round(double val, double places){
    double mod = pow(10.0, places);
    if(val != null)
      return ((val * mod).round().toDouble() / mod);
    return null;
  }

  final titleStyle = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 20.0
  );

  @override
  Widget build(BuildContext context) {

    return ListView(
      children: <Widget>[
        Text('Ingreso', style: titleStyle,),

        StreamBuilder(
          stream: transactionBloc.income,
          builder: (context, snapshot){
            return Text(round(snapshot.data,2).toString(), style: titleStyle,);
          }
        ),
        Text('Gastos', style: titleStyle,),

        StreamBuilder(
            stream: transactionBloc.outgoings,
            builder: (context, snapshot){
              return Text(round(snapshot.data,2).toString(), style: titleStyle,);
            }
        ),
        Text('Disponible', style: titleStyle,),

        StreamBuilder(
            stream: transactionBloc.available,
            builder: (context, snapshot){
              return Text(round(snapshot.data,2).toString(), style: titleStyle,);
            }
        )
      ],
    );
  }

}