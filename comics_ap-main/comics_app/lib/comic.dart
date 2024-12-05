class Comic {
  final String title;
  final String author;
  final double price;
  final String imageUrl;
  final String category;
  final String description;
  final int quantity;
  bool isFavorite;
  bool isInCart;

  Comic({
    required this.title,
    required this.author,
    required this.price,
    required this.imageUrl,
    required this.category,
    required this.description,
    required this.quantity,
    this.isFavorite = false,
    this.isInCart = false,
  });
}