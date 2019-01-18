import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/transactionModel.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:async';

class TransactionBloc{

  final _mapData = StreamTransformer<QuerySnapshot, List<TransactionModel>>
      .fromHandlers(
      handleData: (QuerySnapshot querySnapshot, sink) async{
        final list = querySnapshot.documents;
        final List<TransactionModel> transactions =
        await list.map((value) => TransactionModel.fromSnapshot(value))
      .toList();
        sink.add(transactions);
      }
      );

  final _calculateIncome = StreamTransformer<List<TransactionModel>,double>
      .fromHandlers(
      handleData: (List<TransactionModel> transactions, sink) async{
        var result = 0.0;
        transactions.map((transaction){
          if(transaction.type == 'ingreso'){
           result += transaction.amount;
          }
        }).toList();
        sink.add(result);
      }
      );

  final _calculateOutgoings = StreamTransformer<List<TransactionModel>,double>
      .fromHandlers(
  handleData: (List<TransactionModel> transactions, sink) async{
  var result = 0.0;
  transactions.map((transaction){
  if(transaction.type == 'gasto'){
  result += transaction.amount;
  }
  }).toList();
  sink.add(result);
  }
  );

  Stream<List<TransactionModel>> get transactions => Firestore.instance.collection('transactions')
      .snapshots().transform(_mapData);

  Stream<double> get income => transactions.transform(_calculateIncome);

  Stream<double> get outgoings => transactions.transform(_calculateOutgoings);

  Stream<double> get available => Observable.combineLatest2(income, outgoings, (income,outgoings)=> (income - outgoings));
}

final transactionBloc = TransactionBloc();