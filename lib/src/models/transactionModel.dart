import 'package:cloud_firestore/cloud_firestore.dart';

class TransactionModel {
  String title;
  String category;
  String description;
  String type;
  double amount;
  DocumentReference reference;

  TransactionModel({this.title, this.category, this.type, this.description,
    this.amount});

  TransactionModel.fromMap(Map<String, dynamic> map, {this.reference}){
    title = map['title'];
    category = map['category'];
    description = map['description'];
    type = map['type'];
    amount = double.parse(map['amount'].toString());
  }

  toJson(){
    return {
      'title':title,
      'category':category,
      'type':type,
      'amount':amount,
      'description':description
    };
  }

  TransactionModel.fromSnapshot(DocumentSnapshot snapshot)
  :this.fromMap(snapshot.data, reference: snapshot.reference);
}