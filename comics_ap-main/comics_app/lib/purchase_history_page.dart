import 'package:flutter/material.dart';
import 'comic.dart'; 

class PurchaseHistoryPage extends StatelessWidget {
  final List<Comic> purchaseHistory;

  const PurchaseHistoryPage({super.key, required this.purchaseHistory});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('История покупок'),
      ),
      body: ListView.builder(
        itemCount: purchaseHistory.length,
        itemBuilder: (context, index) {
          final comic = purchaseHistory[index];
          return ListTile(
            leading: Image.network(comic.imageUrl),
            title: Text(comic.title),
            subtitle: Text('Автор: ${comic.author}, Цена: \$${comic.price}'),
            trailing: Text('Количество: ${comic.quantity}'),
          );
        },
      ),
    );
  }
}