import 'package:flutter/material.dart';

class MarketApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: MarketPage());
  }
}

class MarketPage extends StatefulWidget {
  @override
  State<MarketPage> createState() => MarketPageState();
}

class MarketPageState extends State<MarketPage> {
  final Map<String, List<Map<String, String>>> productByCategory = {
   'Ноутбуки': [
      {'name': 'Ноутбук Lenovo', 'price': '72 000 сом', 'category': 'Ноутбуки'},
      {'name': 'Ноутбук Asus', 'price': '83 000 сом', 'category': 'Ноутбуки'},
      {'name': 'Ноутбук HP', 'price': '76 000 сом', 'category': 'Ноутбуки'},
    ],
    'Смартфоны': [
      {'name': 'IPhone 18 Pro', 'price': '125 000 сом', 'category': 'Смартфоны'},
      {'name': 'Samsung Galaxy', 'price': '35 000 сом', 'category': 'Смартфоны'},
      {'name': 'Xiaomi Redmi', 'price': '23 000 сом', 'category': 'Смартфоны'},
    ],
    'Аксессуары': [
      {'name': 'Наушники JBL', 'price': '13 500 сом', 'category': 'Аксессуары'},
      {'name': 'Клавиатура Razer', 'price': '8700 сом', 'category': 'Аксессуары'},
      {'name': 'Мышь Logitech', 'price': '3600 сом', 'category': 'Аксессуары'},
    ],
    'Мониторы': [
      {'name': 'LG', 'price': '12 000 сом', 'category': 'Мониторы'},
      {'name': 'Samsung', 'price': '14 000 сом', 'category': 'Мониторы'},
      {'name': 'Acer', 'price': '9000 сом', 'category': 'Мониторы'},
    ],
    'Принтеры': [
      {'name': 'Epson', 'price': '14 700 сом', 'category': 'Принтеры'},
      {'name': 'Canon', 'price': '15 000 сом', 'category': 'Принтеры'},
      {'name': 'Xerox', 'price': '8900 сом', 'category': 'Принтеры'},
    ],
    'Игровые устройства': [
      {'name': 'PSP', 'price': '12 000 сом', 'category': 'Игровые устройства'},
      {'name': 'Nintendo', 'price': '32 000 сом', 'category': 'Игровые устройства'},
      {'name': 'Xbox', 'price': '48 000 сом', 'category': 'Игровые устройства'},
    ],
  };
  Set<String> favorites = {};
  int currentIndex = 0;

  void toggleFavorite(String product) {
    setState(() {
      if (favorites.contains(product)) {
        favorites.remove(product);
      } else {
        favorites.add(product);
      }
    });
  }

 Icon getCategoryIcon(String category) {
    if (category == 'Ноутбуки') {
      return Icon(Icons.laptop, color: Colors.blue);
    } else if (category == 'Смартфоны') {
      return Icon(Icons.smartphone, color: Colors.green);
    } else if (category == 'Аксессуары') {
      return Icon(Icons.headphones, color: Colors.orange);
    } else if (category == 'Мониторы') {
      return Icon(Icons.monitor, color: Colors.purple);
    } else if (category == 'Принтеры') {
      return Icon(Icons.print, color: Colors.teal);
    } else if (category == 'Игровые устройства') {
      return Icon(Icons.sports_esports, color: Colors.redAccent);
    } else {
      return Icon(Icons.shopping_bag, color: Colors.amber);
    }
  }
 List<Map<String, String>> getFavoriteProducts() {
    List<Map<String, String>> result = [];
    for (var list in productByCategory.values) {
      for (var item in list) {
        if (favorites.contains(item['name'])) {
          result.add(item);
        }
      }
    }
    return result;
  }


  Widget buildProductList(List<Map<String, String>> products) {
    if (products.isEmpty) {
      return Center(child: Text('Список пуст'));
    }
    return ListView.separated(
      itemCount: products.length,
      itemBuilder: (context, index) {
       Map<String, String> product = products[index];
        String name = product['name'] ?? '';
        String price = product['price'] ?? '';
        String category = product['category'] ?? '';
        bool isFavorite = favorites.contains(name);
        return Padding(padding: EdgeInsets.all(4),
       child:  ListTile(
          leading: getCategoryIcon(category),
          title: Text(name, style: TextStyle(fontSize: 16)),
          subtitle: Text('Цена: $price\nТовар есть в наличии'),
          trailing: IconButton(
            onPressed: () {
              toggleFavorite(name);
            },
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? Colors.red : Colors.grey,
            ),
          ),
        ),
        );
      },
      separatorBuilder: (context, index) {
        return Divider();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 7,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber,
          title: Text(
            currentIndex == 0
                ? 'Каталог товаров'
                : currentIndex == 1
                ? 'Избранное'
                : 'Профиль',
          ),
          bottom: currentIndex == 0
              ? TabBar(
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.black54,
                  indicatorColor: Colors.blue,
                  indicatorWeight: 4,
                  isScrollable: true,
                  tabs: [
                    Tab(text: 'Ноутбуки'),
                    Tab(text: 'Смартфоны'),
                    Tab(text: 'Аксессуары'),
                    Tab(text: 'Мониторы'),
                    Tab(text: 'Принтеры'),
                    Tab(text: 'Игровые устройства'),
                    Tab(text: 'Все товары'),
                  ],
                )
              : null,
        ),
        body: currentIndex == 0
            ? TabBarView(
                children: [
                  buildProductList(productByCategory['Ноутбуки'] ?? []),
                  buildProductList(productByCategory['Смартфоны'] ?? []),
                  buildProductList(productByCategory['Аксессуары'] ?? []),
                  buildProductList(productByCategory['Мониторы'] ?? []),
                  buildProductList(productByCategory['Принтеры'] ?? []),
                  buildProductList(
                    productByCategory['Игровые устройства'] ?? [],
                  ),
                  buildProductList(
                    productByCategory.values
                        .expand((products) => products)
                        .toList(),
                  ),
                ],
              )
            : currentIndex == 1
            ? buildProductList(getFavoriteProducts())
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.person, size: 80, color: Colors.amber),
                    SizedBox(height: 16),
                    Text(
                      'Профиль пользователя',
                      style: TextStyle(fontSize: 24),
                    ),
                  ],
                ),
              ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.black54,
          backgroundColor: Colors.amber,
          iconSize: 24,
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Главная'),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Избранное',
            ),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Профиль'),
          ],
        ),
      ),
    );
  }
}
