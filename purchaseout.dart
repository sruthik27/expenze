import 'package:flutter/material.dart';
import 'package:flutter_app2/cdpurchases.dart';
import 'package:intl/intl.dart';

class EntryRegister extends StatelessWidget {
  final List<CdPurchases> cdprs;
  final Function deleting;
  EntryRegister(this.cdprs, this.deleting);
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 525,
        child: cdprs.isEmpty
            ? Column(
                children: [
                  Text('No purchases'),
                  Image.network(
                      'https://upload.wikimedia.org/wikipedia/commons/8/84/Nothing_silhouette.jpg'),
                ],
              )
            : ListView.builder(
                itemBuilder: (ctx, index) {
                  return Card(
                    shadowColor: Colors.red,
                    shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: Colors.pink,
                          width: 3,
                        ),
                        borderRadius: BorderRadius.circular(22)),
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(
                            vertical: 20,
                            horizontal: 15,
                          ),
                          decoration: BoxDecoration(
                              border: Border.all(
                            color: Theme.of(context).primaryColor,
                            width: 3,
                          )),
                          child: Text(
                            '₹${cdprs[index].amt.toStringAsFixed(2)}',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Theme.of(context).primaryColor),
                          ),
                          padding: EdgeInsets.all(10),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                cdprs[index].title,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17.5,
                                ),
                              ),
                              Text(
                                DateFormat('dd MMMM yyyy')
                                    .format(cdprs[index].date),
                                style: TextStyle(
                                    fontSize: 15, color: Colors.blueGrey),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                            onPressed: () => deleting(cdprs[index].id),
                            icon: Icon(
                              Icons.delete,
                              color: Colors.red,
                            ))
                      ],
                    ),
                  );
                },
                itemCount: cdprs.length));
  }
}
