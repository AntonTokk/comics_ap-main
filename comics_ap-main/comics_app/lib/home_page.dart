import 'package:flutter/material.dart';
import 'comics_data.dart'; 
import 'comic_detail_page.dart'; 
import 'comic.dart'; 

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Comic> filteredComics = comics.where((comic) => comic != null).toList();
  String searchQuery = '';
  String sortBy = 'name'; 

  void _filterComics(String query) {
    setState(() {
      searchQuery = query;
      filteredComics = comics
          .where((comic) =>
              comic.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void _sortComics(String sortType) {
    setState(() {
      sortBy = sortType;
      if (sortType == 'name') {
        filteredComics.sort((a, b) => a.title.compareTo(b.title));
      } else if (sortType == 'price') {
        filteredComics.sort((a, b) => a.price.compareTo(b.price));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Главная'),
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: _filterComics,
                decoration: const InputDecoration(
                  labelText: 'Поиск',
                  prefixIcon: Icon(Icons.search),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownButton<String>(
                value: sortBy,
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    _sortComics(newValue);
                  }
                },
                items: <String>['name', 'price']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value == 'name' ? 'По названию' : 'По цене'),
                  );
                }).toList(),
              ),
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.75,
                ),
                itemCount: filteredComics.length,
                itemBuilder: (context, index) {
                  final comic = filteredComics[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ComicDetailPage(comic: comic),
                        ),
                      );
                    },
                    child: Card(
                      child: Column(
                        children: [
                          Expanded(
                            child: Image.network(
                              comic.imageUrl,
                              fit: BoxFit.cover,
                            ),
                          ),
                          ListTile(
                            title: Text(comic.title),
                            subtitle: Text('${comic.author} | ${comic.price} \$'),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              IconButton(
                                icon: Icon(
                                  comic.isFavorite
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: comic.isFavorite ? Colors.red : null,
                                ),
                                onPressed: () {
                                  setState(() {
                                    comic.isFavorite = !comic.isFavorite;
                                  });
                                },
                              ),
                              IconButton(
                                icon: Icon(
                                  comic.isInCart
                                      ? Icons.shopping_cart
                                      : Icons.add_shopping_cart,
                                  color: comic.isInCart ? Colors.green : null,
                                ),
                                onPressed: () {
                                  setState(() {
                                    comic.isInCart = !comic.isInCart;
                                  });
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}