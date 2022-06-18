import 'package:financemanager/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget{
  final List<Transaction> transactions;
  final Function deleteItemFun;
  TransactionList({required this.transactions,required this.deleteItemFun});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      child:transactions.isEmpty ? Column(
        children: [
          Text(
              'No Transactions added yet',
            style: Theme.of(context).appBarTheme.titleTextStyle,
          ),
          SizedBox(height: 50,),
          Container(
              height: 200,
              child: Image.asset('assets/images/waiting.png',fit: BoxFit.cover,))
        ],
      )  : ListView.builder(
        itemBuilder: (ctx,index){
          return Card(
            margin: EdgeInsets.symmetric(vertical: 8,horizontal: 5),
            elevation: 5,
            child: ListTile(
              leading: CircleAvatar(
                radius: 40,
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: FittedBox(
                    child: Text(
                      '\$${transactions[index].amount.toStringAsFixed(2)}',
                    ),
                  ),
                ),
              ),
              title: Text(
                transactions[index].title,
                style: Theme.of(context).appBarTheme.titleTextStyle!.copyWith(
                    fontSize: 18
                ),
              ),
              subtitle: Text(
                DateFormat.yMMMd().format(transactions[index].date),
                style: TextStyle(
                    color: Colors.grey
                ),
              ),
              trailing: IconButton(
                icon: Icon(Icons.delete_forever,color: Theme.of(context).errorColor,),
                onPressed: (){deleteItemFun(transactions[index].id);},
              ),
            ),
          );
        },
        itemCount: transactions.length,
      ),
    );
  }
}