import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/Transaction.dart';

class TList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deltx;
  TList(this.transactions, this.deltx);
  @override
  Widget build(BuildContext context) {
    return Container(
        child: transactions.isEmpty
            ? Column(
                children: <Widget>[
                  Text(
                    'No transactions added yet',
                    style: Theme.of(context).textTheme.title,
                  ),
                  Container(
                      height: 300,
                      child: Image.asset(
                        'assets/images/waiting.png',
                        fit: BoxFit.cover,
                      )),
                ],
              )
            : ListView.builder(
                itemBuilder: (cxt, index) {
                  return Card(
                    elevation: 5,
                    child: ListTile(
                      leading: CircleAvatar(
                          radius: 30,
                          child: Padding(
                              padding: EdgeInsets.all(6),
                              child: FittedBox(
                                child: Text(
                                  '\$${transactions[index].amount.toStringAsFixed(2)}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .title
                                      .copyWith(color: Colors.white),
                                ),
                              ))),
                      title: Text('${transactions[index].title}',
                          style: Theme.of(context).textTheme.title),
                      subtitle: Text(
                          '${DateFormat.yMMMd().format(transactions[index].date)}'),
                      trailing: IconButton(
                          icon: Icon(
                            Icons.delete,
                          ),
                          color: Theme.of(context).errorColor,
                          onPressed: () => deltx(transactions[index].id)),
                    ),
                  );
                },
                itemCount: transactions.length,
              ));
  }
}
