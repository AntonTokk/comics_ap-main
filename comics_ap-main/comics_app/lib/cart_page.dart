import 'package:flutter/material.dart';
import 'comics_data.dart';
import 'checkout_page.dart';
import 'comic.dart'; 

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<Comic> cartComics = comics.where((comic) => comic.isInCart).toList();

  void onPurchaseComplete(List<Comic> purchasedComics) {
    setState(() {
      // Удаляем купленные комиксы из корзины
      cartComics.removeWhere((comic) => purchasedComics.contains(comic));
      // Обновляем состояние комиксов в основном списке
      for (var comic in purchasedComics) {
        comic.isInCart = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Корзина'),
      ),
      body: Container(
        color: Colors.white,
        child: ListView.builder(
          itemCount: cartComics.length,
          itemBuilder: (context, index) {
            final comic = cartComics[index];
            return ListTile(
              leading: Image.network(comic.imageUrl),
              title: Text(comic.title),
              subtitle: Text('${comic.author} | ${comic.price} ₽'),
              trailing: IconButton(
                icon: const Icon(Icons.remove_shopping_cart),
                onPressed: () {
                  setState(() {
                    comic.isInCart = false;
                    cartComics.remove(comic);
                  });
                },
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => CheckoutPage(
                cartComics: cartComics,
                onPurchaseComplete: onPurchaseComplete,
              ),
            ),
          );
        },
        child: const Icon(Icons.shopping_cart_checkout),
      ),
    );
  }
}