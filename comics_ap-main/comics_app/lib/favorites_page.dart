import 'package:flutter/material.dart';
import 'comics_data.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  Widget build(BuildContext context) {
    final favoriteComics = comics.where((comic) => comic.isFavorite).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Избранное'),
      ),
      body: Container(
        color: Colors.white,
        child: ListView.builder(
          itemCount: favoriteComics.length,
          itemBuilder: (context, index) {
            final comic = favoriteComics[index];
            return ListTile(
              leading: Image.network(comic.imageUrl),
              title: Text(comic.title),
              subtitle: Text('${comic.author} | ${comic.price} \$'),
              trailing: IconButton(
                icon: const Icon(
                  Icons.favorite,
                  color: Colors.red,
                ),
                onPressed: () {
                  setState(() {
                    comic.isFavorite = false;
                  });
                },
              ),
            );
          },
        ),
      ),
    );
  }
}