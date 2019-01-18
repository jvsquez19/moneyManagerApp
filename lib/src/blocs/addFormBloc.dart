import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:rxdart/rxdart.dart';
import '../models/transactionModel.dart';

class AddFormBloc {

  final _title = BehaviorSubject<String>();
  final _category = BehaviorSubject<String>();
  final _description= BehaviorSubject<String>();
  final _type = BehaviorSubject<String>();
  final _amount = BehaviorSubject<double>();

  Stream<String> get title => _title.stream;
  Stream<String> get category => _category.stream;
  Stream<String> get description => _description.stream;
  Stream<String> get type => _type.stream;
  Stream<double> get amount => _amount.stream;

  Function(String) get changeTitle => _title.sink.add;
  Function(String) get changeCategory => _category.sink.add;
  Function(String) get changeDescription => _description.sink.add;
  Function(String) get changeType => _type.sink.add;
  Function(double) get changeAmount => _amount.sink.add;

  Stream<bool> get summitValid => Observable.combineLatest5(
      title,
      category,
      description,
      type,
      amount, (a,b,c,d,e)=> true).asBroadcastStream();


  summit(BuildContext context){
    final newTransaction = TransactionModel(
      title: _title.value,
      description: _description.value,
      type: _type.value,
      amount: _amount.value,
      category: _category.value
    );

    Firestore.instance.collection('transactions').document()
    .setData(newTransaction.toJson()).then(
            (onValue){
      showDialog(context: context,
      builder: (context)=> AlertDialog(
        title: Text('Agregado Correctamente'),
        content: Text('La transaccion se ha agregado correctamente'),
      ));
    },

        onError:(error){showDialog(context: context,
        builder: (context)=> AlertDialog(
          title: Text('Ha ocurrido un error'),
          content: Text('Ha ocurrido un error al agregar la transacción'),
        ));});
  }


}

final addFormBloc = AddFormBloc();


