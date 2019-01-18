import 'package:flutter/material.dart';
import '../blocs/transactionBloc.dart';
import '../models/transactionModel.dart';


class TransactionsScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    return StreamBuilder(
      stream: transactionBloc.transactions,
      builder: (context, snapshot){
        if(!snapshot.hasData){
          return LinearProgressIndicator();
        }
        else{
          return _buildList(context, snapshot.data);
        }
      },

    );
  }

  _buildList(BuildContext context, List<TransactionModel> data ){
    return ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index){
          TransactionModel current = data[index];
          return _buildItem(current);
        });
  }




  _buildItem(TransactionModel item){
    return Card(
      color: item.type == 'gasto' ? Colors.orange : Colors.green,
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text(item.title),
            subtitle: Text(item.amount.toString()),
            trailing: Column(
              children: <Widget>[
                Text(item.description),
                Text(item.category, style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          )
        ],
      ),
    );
  }
}