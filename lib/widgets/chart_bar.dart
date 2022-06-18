import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget{
  final String label;
  final double spendingAmount;
  final double spendingPctOfTotal;
  ChartBar({required this.label,required this.spendingAmount,required this.spendingPctOfTotal});
  @override
  Widget build(BuildContext context) {
    return Row(
        children: [
          SizedBox(
            height: 120,
            child: RotatedBox(
              quarterTurns: -1,
              child:Text(
                  '\$${spendingAmount.toStringAsFixed(2)}',
              textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          Column(
            children: [
              Container(
                height: 130,
                width: 20,
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey,width: 1),
                          color: Color.fromRGBO(220, 220, 220, 1),
                          borderRadius: BorderRadius.circular(10)
                      ),
                    ),
                    FractionallySizedBox(
                      heightFactor: spendingPctOfTotal,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(10)
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 4,
              ),
              Text(label)
            ],
          )

        ],
    );
  }
}