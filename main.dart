import 'package:flutter/material.dart';
import 'package:flutter_app2/graph.dart';
import 'package:flutter_app2/userinput.dart';
import 'purchaseout.dart';
import 'cdpurchases.dart';
// import 'press_app/TrainApp.dart';

// void main() => runApp(NewApp());
void main() => runApp(ExpensesApp());

class ExpensesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Video Game Records',
      home: HomePage(),
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<CdPurchases> _cdpr = [];

  List<CdPurchases> get _recentCdprs {
    return _cdpr.where((element) {
      return element.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void addNewEntry(String newName, double newPrice, DateTime chosenDate) {
    final newEntry = CdPurchases(
      id: DateTime.now().toString(),
      title: newName,
      amt: newPrice,
      date: chosenDate,
    );

    setState(() {
      _cdpr.add(newEntry);
    });
  }


  void deleteEntry(String id) {
    setState(() {
      _cdpr.removeWhere((element) => (element.id == id));
    });
  }

  void popup(BuildContext primaryCtx) {
    showModalBottomSheet(
        context: primaryCtx,
        builder: (builderCtx) {
          return UserEntry(addNewEntry);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Exps App'),
        actions: [
          IconButton(
              onPressed: () => popup(context),
              icon: Icon(Icons.add_circle_rounded))
        ],
      ),
      body: ListView(
        children: [
          Graph(_recentCdprs),
          EntryRegister(_cdpr, deleteEntry),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => popup(context),
        child: Icon(Icons.add_circle_rounded),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
