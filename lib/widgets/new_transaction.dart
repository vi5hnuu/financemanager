
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget{
  final Function addTx;
  NewTransaction(this.addTx);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController=TextEditingController();
  final _amountController=TextEditingController();
  DateTime? _selectedDate;
  void _submitData(){
    if(_amountController.text.isEmpty)
        return;
    final enteredTiTle=_titleController.text;
    final enteredAmount=double.parse(_amountController.text);
    if(enteredTiTle.isEmpty || enteredAmount<=0 || _selectedDate==null)
      return;

    widget.addTx(enteredTiTle,enteredAmount,_selectedDate);
    Navigator.of(context).pop();
    }

    void _presentDatePicker(){
      showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2019),
          lastDate: DateTime.now()).then((pickedDate){
            if(pickedDate==null)
              return;
            setState(() {
                _selectedDate=pickedDate;
            });
      });
    }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child:Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Title',
              ),
              controller: _titleController,
              onSubmitted:(_)=>_submitData(),
            ),
            TextField(
              decoration: InputDecoration(
                  labelText: 'Amount',
              ),
              controller: _amountController,
              keyboardType: TextInputType.number,
              onSubmitted:(_) =>_submitData(),
            ),
            Container(
              height: 70,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(_selectedDate!=null? 'Picked Date : ${DateFormat.yMd().format(_selectedDate!)}':'No Date Chosen!'),
                  ElevatedButton(
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.all(3.0),
                    backgroundColor: MaterialStateProperty.all(Colors.black38),
                    shape:MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  )
            )
                    ),
                      onPressed:_presentDatePicker,
                      child: Text(
                          'Choose Date',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ))
                ],
              ),
            ),
            ElevatedButton(
                style: ButtonStyle(
                  elevation: MaterialStateProperty.all(5),
                  backgroundColor: MaterialStateProperty.all(Colors.black38),
                ),
                onPressed: _submitData,
                child:Text(''
                    'Add Transaction',
                  style: TextStyle(
                      color: Colors.white
                  ),
                )
            )
          ],
        ),
      ),
    );
  }
}