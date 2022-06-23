import 'package:flutter/material.dart';
import 'package:flutter_app2/cdpurchases.dart';
import 'package:flutter_app2/graphbar.dart';
import 'package:intl/intl.dart';

class Graph extends StatelessWidget {
  late final List<CdPurchases> recentpurchases;
  Graph(this.recentpurchases);

  List<Map<String, Object>> get groupedTrans {
    return List.generate(7, (index) {
      final weekday = DateTime.now().subtract(Duration(days: index));
      double totalsum = 0;

      for (var i = 0; i < recentpurchases.length; i++) {
        if (recentpurchases[i].date.day == weekday.day &&
            recentpurchases[i].date.month == weekday.month &&
            recentpurchases[i].date.year == weekday.year) {
          totalsum += recentpurchases[i].amt;
        }
      }
      print(DateFormat.E().format(weekday));
      print(totalsum);
      return {
        'Day': DateFormat.E().format(weekday).substring(0, 1),
        'Amount': totalsum
      };
    });
  }

  double get totSpending {
    return groupedTrans.fold(0.0, (sum, item) {
      return sum + ((item['Amount']) as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    print(groupedTrans);
    return Card(
        elevation: 6,
        margin: EdgeInsets.all(20),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: groupedTrans
                .map((e) => Flexible(
                      fit: FlexFit.tight,
                      child: BarGraph(
                          (e['Day']) as String,
                          (e['Amount']) as double,
                          totSpending == 0
                              ? 0.0
                              : ((e['Amount']) as double) / totSpending),
                    ))
                .toList(),
          ),
        ));
  }
}
