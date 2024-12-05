import 'package:flutter/material.dart';
import 'auth_service.dart';
import 'purchase_history_page.dart';
import 'comic.dart'; 

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final AuthService authService = AuthService();
  Map<String, dynamic>? userProfile;
  String? userEmail;
  List<Comic> purchaseHistory = [];

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
    _loadPurchaseHistory();
  }

  Future<void> _loadUserProfile() async {
    final user = await authService.getCurrentUser();
    if (user != null) {
      final profile = await authService.getUserProfile(user.id);
      setState(() {
        userProfile = profile;
        userEmail = user.email;
      });
    }
  }

  Future<void> _loadPurchaseHistory() async {
    final comics = [
      Comic(
        title: 'Spider-Man: Blue',
        author: 'Jeph Loeb',
        price: 14.99 * 70, 
        imageUrl: 'https://i.pinimg.com/736x/1d/a4/3d/1da43d8742b591be0dd6557410e701b7.jpg',
        category: 'Spider-Man',
        description: 'Это трогательная история о Питере Паркере и Гвен Стейси.',
        quantity: 5,
        isFavorite: false,
        isInCart: false,
      ),
      Comic(
        title: 'Spider-Man: Kraven\'s Last Hunt',
        author: 'J.M. DeMatteis',
        price: 17.99 * 70, 
        imageUrl: 'https://cdn1.ozone.ru/s3/multimedia-1-d/6933150625.jpg',
        category: 'Spider-Man',
        description: 'Последняя охота Кравена на Человека-паука.',
        quantity: 3,
        isFavorite: false,
        isInCart: false,
      ),
      
    ];

    setState(() {
      purchaseHistory = comics;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Профиль'),
      ),
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (userProfile != null)
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(userProfile!['avatar_url']),
                ),
              const SizedBox(height: 20),
              if (userProfile != null)
                Text(
                  userProfile!['full_name'],
                  style: const TextStyle(fontSize: 24),
                ),
              const SizedBox(height: 10),
              if (userEmail != null)
                Text(
                  userEmail!,
                  style: const TextStyle(fontSize: 18),
                ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  await authService.signOut();
                  Navigator.of(context).pushReplacementNamed('/');
                },
                child: const Text('Выйти'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => PurchaseHistoryPage(purchaseHistory: purchaseHistory),
                    ),
                  );
                },
                child: const Text('История покупок'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}