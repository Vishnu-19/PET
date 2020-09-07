import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTrans extends StatefulWidget {
  Function addNew;

  NewTrans(this.addNew);

  @override
  _NewTransState createState() => _NewTransState();
}

class _NewTransState extends State<NewTrans> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();
  DateTime selectedDate;

  void submitData(String txntitle, double txnamount, DateTime seldate) {
    if (txntitle.isEmpty || txnamount <= 0) {
      return;
    }
    if (seldate == null) {
      seldate = DateTime.now();
    }
    widget.addNew(txntitle, txnamount, seldate);
    Navigator.of(context).pop();
  }

  void pickDate() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Container(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
          TextField(
            decoration: InputDecoration(labelText: 'Title'),
            controller: titleController,
          ),
          TextField(
            decoration: InputDecoration(labelText: 'Amount'),
            controller: amountController,
            keyboardType: TextInputType.number,
          ),
          Container(
            height: 70,
            child: Row(
              children: <Widget>[
                Text(selectedDate == null
                    ? 'No Date Chosen!'
                    : 'Picked Date: ${DateFormat.yMMMd().format(selectedDate)}'),
                FlatButton(
                  child: Text('Choose Date',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  textColor: Theme.of(context).primaryColor,
                  onPressed: pickDate,
                ),
              ],
            ),
          ),
          RaisedButton(
              child: Text("Add Transaction"),
              color: Theme.of(context).primaryColor,
              textColor: Theme.of(context).textTheme.button.color,
              onPressed: () => submitData(titleController.text,
                  double.parse(amountController.text), selectedDate)),
        ])));
  }
}
