import 'package:flutter/material.dart';
import 'screens/transactionsScreen.dart';
import 'screens/addTransactionScreen.dart';
import 'screens/reportsScreen.dart';


class App extends StatelessWidget{

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'MoneyApp',
      theme: ThemeData(
        primarySwatch: Colors.green
      ),
      home: DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: AppBar(
              title: Text('Mis Finanzas'),
              bottom: TabBar(tabs: 
              <Widget>[
                Tab(child: Icon(Icons.toc),),
                Tab(child: Icon(Icons.monetization_on)),
                Tab(child: Icon(Icons.add)),
              ]),
            ),
            body: TabBarView(children:
            <Widget>[
              TransactionsScreen(),
              ReportScreen(),
              AddTransaction(),
            ]),
          )),
    );
  }
}