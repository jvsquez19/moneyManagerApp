import 'package:flutter/material.dart';
import '../blocs/addFormBloc.dart';

class AddTransaction extends StatelessWidget{

  final categories = ['Alimentación', 'Ropa', 'Comida', 'Combustible',
  'Electronicos', 'Hogar', 'Otros'];

  final types = ['gasto','ingreso'];

  @override
  Widget build(BuildContext context) {

    return Container(
      child: ListView(
        shrinkWrap: true,
        children: <Widget>[
          titleField(),
          descriptionField(),
          amountField(),
          Container(
            padding: EdgeInsets.all(15.0),
            child: typeField(),
          ),
          Container(
            padding: EdgeInsets.all(15.0),
            child: categoryField(),
          ),
          Container(
            padding: EdgeInsets.all(15.0),
            child: summitButton(),
          ),
        ],
      ),
    );
  }

  titleField(){
    return StreamBuilder(
      stream: addFormBloc.title,
      builder: (context, snapshot){
        return TextField(
          decoration: InputDecoration(
              errorText: snapshot.error,
              labelText: 'Title',
              hintText: '¿Que es esta transacción?'
          ),
          onChanged: (value){
            addFormBloc.changeTitle(value);
          },
        );
      },
    );
  }

  descriptionField(){
    return StreamBuilder(
      stream: addFormBloc.description,
      builder: (context, snapshot){
        return TextField(
          decoration: InputDecoration(
              errorText: snapshot.error,
              labelText: 'Description',
              hintText: '¿Dinos más sobre esta transacción'
          ),
          onChanged: (value){
            addFormBloc.changeDescription(value);
          },
        );
      },
    );
  }

  amountField(){
    return StreamBuilder(
      stream: addFormBloc.amount,
      builder: (context, snapshot){
        return TextField(
          keyboardType: TextInputType.numberWithOptions(),
          decoration: InputDecoration(
              errorText: snapshot.error,
              labelText: 'Amount',
              hintText: '¿Escribe el monto de la transacción'
          ),
          onChanged: (value){
            addFormBloc.changeAmount(double.parse(value));
          },
        );
      },
    );
  }

  categoryField(){
    return StreamBuilder(
      stream: addFormBloc.category,
      builder: (context, snapshot){
        return Column(
            children: <Widget>[
            Text('Categoria', style: TextStyle(fontWeight: FontWeight.bold)),
        Column(children: getCategories(categories, snapshot.data))
        ],
        );
      },
    );
  }

  typeField(){
    return StreamBuilder(
      stream: addFormBloc.type,
      builder: (context, snapshot){
        return Column(
          children: <Widget>[
            Text('Tipo', style: TextStyle(fontWeight: FontWeight.bold)),
            Column(children: getTypes(types, snapshot.data))
          ],
        );
      },
    );
  }

  getCategories(List<String> categories, current){
    return categories.map((String category){
      return CheckboxListTile(
        title: Text(category),
        value: category == current,
        onChanged: (bool foo){
          addFormBloc.changeCategory(category);
        },
      );
    }).toList();
  }


  getTypes(List<String> types, current){
    return types.map((String type){
      return CheckboxListTile(
        title: Text(type),
        value: type == current,
        onChanged: (bool foo){
          addFormBloc.changeType(type);
        },
      );
    }).toList();
  }

  summitButton(){
    return StreamBuilder(
      stream: addFormBloc.summitValid,
      builder:(context, snapshot){
        return RaisedButton(
          child: Text('Añadir Transacción'),
          color: Colors.green,
          onPressed: snapshot.hasData ? (){ addFormBloc.summit(context);}
          :null,
        );
      }
    );
  }


}



