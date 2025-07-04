import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/item.dart';
import 'package:intl/intl.dart';

class Total extends StatelessWidget {
  final String name;
  final String email;
  final DateTime date;
  final List<ArticleItem> articles;

  const Total({
    super.key,
    required this.name,
    required this.email,
    required this.date,
    required this.articles,
  });

  double get totalHT => articles.fold(0, (sum, item) => sum + item.total);
  double get tva => totalHT * 0.20;
  double get totalTTC => totalHT + tva;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Aperçu de la facture", style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Num de client: $name", style: TextStyle(fontSize: 16)),
            Text("Email:  $email", style: TextStyle(fontSize: 16)),
            Text("Date: ${DateFormat.yMMMMd('en_US').format(date)}", style: TextStyle(fontSize: 16)),
            Divider(thickness: 2),

            SizedBox(height: 10),
            Text("Articles: ", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            SizedBox(height: 8),

            Table(
              border: TableBorder.all(),
              columnWidths: const {
                0: FlexColumnWidth(3),
                1: FlexColumnWidth(2),
                2: FlexColumnWidth(2),
                3: FlexColumnWidth(2),
              },
              children: [
                TableRow(
                  decoration: BoxDecoration(color: Colors.grey[300]),
                  children: const [
                    Padding(padding: EdgeInsets.all(8), child: Text("Description", textAlign: TextAlign.center)),
                    Padding(padding: EdgeInsets.all(8), child: Text("Quantite", textAlign: TextAlign.center)),
                    Padding(padding: EdgeInsets.all(8), child: Text("Prix", textAlign: TextAlign.center)),
                    Padding(padding: EdgeInsets.all(8), child: Text("Total", textAlign: TextAlign.center)),
                  ],
                ),
                ...articles.map((item) => TableRow(
                  children: [
                    Padding(padding: EdgeInsets.all(8), child: Text(item.description)),
                    Padding(padding: EdgeInsets.all(8), child: Text("${item.quantity}")),
                    Padding(padding: EdgeInsets.all(8), child: Text("${item.price.toStringAsFixed(2)} DH")),
                    Padding(padding: EdgeInsets.all(8), child: Text("${item.total.toStringAsFixed(2)} DH")),
                  ],
                )),
              ],
            ),

            SizedBox(height: 20),
            Divider(),
            SizedBox(height: 20),

            Card(
              child: ListTile(
                title: Text("Total HT"),
                trailing: Text('${totalHT.toStringAsFixed(2)} DH'),
              ),
            ),
            SizedBox(height: 20),

            Card(
              child: ListTile(
                title: Text("TVA (20%)"),
                trailing: Text('${tva.toStringAsFixed(2)} DH'),
              ),
            ),
            SizedBox(height: 20),
            Card(
              child: ListTile(
                title: Text("Total TTC"),
                trailing: Text('${totalTTC.toStringAsFixed(2)} DH'),
              ),
            ),
           
          ],
        ),
      ),
    );
  }
}
