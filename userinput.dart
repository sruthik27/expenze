import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UserEntry extends StatefulWidget {
  final Function adding;
  UserEntry(this.adding);

  @override
  _UserEntryState createState() => _UserEntryState();
}

class _UserEntryState extends State<UserEntry> {
  final namecontroller = TextEditingController();
  final pricecontroller = TextEditingController();
  DateTime? selectedDate;

  void PresentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(
              2021,
            ),
            lastDate: DateTime.now())
        .then((value) {
      if (value == null) {
        return;
      }
      setState(() {
        selectedDate = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              cursorColor: Colors.green,
              decoration: InputDecoration(labelText: 'GAME NAME'),
              controller: namecontroller,
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'GAME PRICE',
              ),
              controller: pricecontroller,
              keyboardType: TextInputType.number,
              onSubmitted: (_) {
                widget.adding(
                  namecontroller.text,
                  double.parse(pricecontroller.text),
                  selectedDate,
                );
              },
            ),
            Container(
              height: 70,
              child: Row(
                children: [
                  Expanded(
                    child: Text(selectedDate == null
                        ? 'No Date Chosen'
                        : 'Date: ${DateFormat.yMd().format(selectedDate!)}'),
                  ),
                  FlatButton(
                      onPressed: PresentDatePicker,
                      child: Text(
                        'choose date',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ))
                ],
              ),
            ),
            TextButton(
              onPressed: () {
                if (double.parse(pricecontroller.text) > 0) {
                  widget.adding(
                    namecontroller.text,
                    double.parse(pricecontroller.text),
                    selectedDate,
                  );
                }
                Navigator.of(context).pop();
              },
              child: Text('Add to list'),
              style: TextButton.styleFrom(primary: Colors.deepPurple),
            ),
          ],
        ),
      ),
    );
  }
}
