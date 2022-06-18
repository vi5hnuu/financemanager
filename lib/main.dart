import 'package:financemanager/widgets/chart.dart';
import 'package:financemanager/widgets/new_transaction.dart';
import 'package:financemanager/widgets/transaction_list.dart';
import 'package:flutter/material.dart';

import 'models/transaction.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expense',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        fontFamily: 'Quicksand',
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 20,
            fontWeight: FontWeight.bold
          )
        ),
        errorColor: Colors.red
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget{

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions=[

  ];

  void _addNewTransaction(String txtitle,double amt,DateTime dt){
    final newTx=Transaction(
        id: DateTime.now().toString(),
        title: txtitle,
        amount: amt, date: dt);

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _deleteNewTransaction(String id){
      setState(() {
        _userTransactions.removeWhere((element) => element.id==id);
      });
  }
  
  List<Transaction> get _recentTransaction{
    return _userTransactions.where((element){
      return element.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }
  
  void _startAddNewTransaction(BuildContext ctx){
    showModalBottomSheet(
        context: ctx,
        builder:(bCtx){
          return GestureDetector(
            child: NewTransaction(_addNewTransaction),
            behavior: HitTestBehavior.opaque,
          );
        });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Finance Manager',
        ),
        actions: <Widget>[
          IconButton(
              onPressed:()=>_startAddNewTransaction(context),
              icon: Icon(Icons.add),
              tooltip: 'Add new Transaction',
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Chart(_recentTransaction),
            TransactionList(transactions:_userTransactions,deleteItemFun:_deleteNewTransaction),
          ],
        ),
      ),
      floatingActionButtonLocation:FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: ()=>_startAddNewTransaction(context),
      ),
    );
  }
}
