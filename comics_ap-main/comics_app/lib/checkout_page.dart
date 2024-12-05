import 'package:flutter/material.dart';
import 'comic.dart'; 
import 'auth_service.dart';

class CheckoutPage extends StatefulWidget {
  final List<Comic> cartComics;
  final Function(List<Comic>) onPurchaseComplete;

  const CheckoutPage({super.key, required this.cartComics, required this.onPurchaseComplete});

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final AuthService authService = AuthService();

  double get totalPrice {
    return widget.cartComics.fold(0, (sum, comic) => sum + comic.price);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Оформление заказа'),
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: widget.cartComics.length,
                itemBuilder: (context, index) {
                  final comic = widget.cartComics[index];
                  return ListTile(
                    leading: Image.network(comic.imageUrl),
                    title: Text(comic.title),
                    subtitle: Text('${comic.author} | ${comic.price} ₽'),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    'Итого: ${totalPrice.toStringAsFixed(2)} ₽',
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      await authService.purchaseComics(widget.cartComics);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Заказ оформлен!')),
                      );
                      widget.onPurchaseComplete(widget.cartComics);
                      Navigator.of(context).pop();
                    },
                    child: const Text('Подтвердить заказ'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}