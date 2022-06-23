import 'package:flutter/material.dart';

class BarGraph extends StatelessWidget {
  final String label;
  final double spentamt;
  final double spentpercent;

  BarGraph(this.label, this.spentamt, this.spentpercent);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FittedBox(child: Text('₹${spentamt.toStringAsFixed(0)}')),
        SizedBox(
          height: 4,
        ),
        Container(
          height: 60,
          width: 10,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                      width: 1,
                    ),
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(10)),
              ),
              FractionallySizedBox(
                heightFactor: spentpercent,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10)),
                ),
              )
            ],
          ),
        ),
        Text(label),
      ],
    );
  }
}
