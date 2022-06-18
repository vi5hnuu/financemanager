import 'package:financemanager/models/transaction.dart';
import 'package:financemanager/widgets/chart_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget{

  final List<Transaction> recentTransactions;
  Chart(this.recentTransactions);

  List<Map<String,Object>> get groupedTransactionsValues{
    return List.generate(7, (index){
      final weekDay=DateTime.now().subtract(Duration(days: index));
      double totalSum=0;
      for(int i=0;i<recentTransactions.length;i++){
        final tx=recentTransactions[i];
        if(tx.date.day==weekDay.day &&
            tx.date.month==weekDay.month &&
            tx.date.year==weekDay.year){
            totalSum+=tx.amount;
        }
      }
      return {'day':DateFormat.E().format(weekDay).substring(0,2),'amount':totalSum};
    }).reversed.toList();
  }

  double get totalSpending{
    return groupedTransactionsValues.fold(0.0, (previousValue, element) => previousValue+=element['amount'] as double);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children:
          groupedTransactionsValues.map((data){
            return Expanded(child: ChartBar(label: data['day'] as String, spendingAmount: data['amount'] as double, spendingPctOfTotal: totalSpending==0 ? 0.0 :(data['amount'] as double)/totalSpending));
          }).toList(),
        ),
      ),
    );
  }
}