import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';


class Product {
  final String id;
  String name;
  String category;
  int price;
  int perBox;
  bool inStock;

  Product({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.perBox,
    this.inStock = true,
  });
}

class MarketOrder {
  final String id;
  final String clientPoint;
  final String phone;
  final Map<Product, int> items;
  final int totalSum;
  final DateTime date;
  bool isCompleted;

  MarketOrder({
    required this.id,
    required this.clientPoint,
    required this.phone,
    required this.items,
    required this.totalSum,
    required this.date,
    this.isCompleted = false,
  });
}


class MyProjectOsh extends StatelessWidget {
 const MyProjectOsh({super.key});

 @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false,
    title: 'Фирменные соевые соусы и пищевые добавки',
    theme: ThemeData(
      primarySwatch: Colors.red,
      scaffoldBackgroundColor: Colors.grey[100], 
    ),
    home: const MyProjectOsh(),);

  }
}

class MyProjectOshPage extends StatefulWidget {

 const MyProjectOsh({super.key});
  
  @override
  State<MyProjectOshPage> createState() => _MyProjectOshPageState();
}


class _MyProjectOshPageState extends State<MyProjectOshPage> {
  final List<Product> products = [
    Product(
    id : '1',
    name:'Соевый соус Haday светлый 1.9л',
    category: 'Соевые соусы ',
    price: 230,
    perBox: 6,),

    Product(
      id: '2',
      name: 'Соевый соус Haday тёмный 1.9л',
      category: 'Соевые соусы',
      price: 260,
      perBox: 6,
    ),
    Product(
      id: '3',
      name: 'Острый соус Lao Gan Ma (с арахисом) 275г',
      category: 'Острые соусы',
      price: 185,
      perBox: 24,
    ),
    Product(
      id: '4',
      name: 'Устричный соус Lee Kum Kee 907г',
      category: 'Для вока и лагмана',
      price: 310,
      perBox: 12,
    ),
    Product(
      id: '5',
      name: 'Чёрный рисовый уксус 500мл',
      category: 'Уксусы и масла',
      price: 95,
      perBox: 12,
    ),
  ];
  final Map<String, int> cart = {};
  final List<MarketOrder> orders = [];
  int currentIndex = 0;
  bool isAdmin = false;
  final String adminPin = '1234';

  List<String> get categories {
    final set  = products.map((e) => e.category).toSet().toList();
    return ['Все', ...set];
  }

  void updateCart(String ProductId, int delta){
    setState(() {
      final currentQty = cart[productId] ?? 0;
      final newQty = currentQty + delta;
        if (newQty <= 0){
          cart.remove(ProductId);
        }else{
          cart[ProductId] = newQty;
        }
    });
  }
}
int get totalCartSum {
  int sum = 0;
  cart.forEach((id.qty){
   final product = product.firstWhere((p) => p.id == id,
   orElse: ()=> MyProjectOsh(id: '', name:'',  category:'', price: 0, perBox: 1),
   );
   sum += product.price *gty;
  });
  return sum;
}
int get totalCartItemsCount => cart.values.fold(0, (a, b) => a + b);
void showProductFormDialog({ 
  Product? existingProduct}) {
    final nameCtrl = TextEditingController(text: existingProduct?.name ?? '');
    final categoryCtrl = TextEditingController(text: existingProduct?.category ?? 'Соевые соусы');co
    final priceCtrl = TextEditingController(text: existingProduct?.price.toString() ?? '');
    final perBoxCtrl = TextEditingController(text: existingProduct?.perBox.toString() ?? '12');
    
    showDialog(context: context, 
    builder: (contex) => AlertDialog(
      title: Text(existingProduct == null ? 'Добавить новый товар' : 'Изменить товар'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameCtrl,
              decoration: const InputDecoration(labelText: 'Название и обьем'),
            ),
            TextField(
               controller: categoryCtrl,
               decoration: const InputDecoration(labelText: 'Категория'),
            ),
            TextField(
              controller: priceCtrl,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Цена за 1 штуку (сом)'),
              ),
            TextField(
              controller: perBoxCtrl,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Штук в коробке'),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(contex),
        child: const Text('Отмена'),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          onPressed: (){
            final name = nameCtrl.text.trim();
            final cat = categoryCtrl.text.trim();
            final price = int.tryParse(priceCtrl.text) ?? 0;
            final perBox = int.tryParse(perBoxCtrl.text) ?? 1;

            if (name.isEmpty || price <= 0) return;
             setState((){
              if (existingProduct == null){
                products.add(
                  Product(
                  id: DateTime.now().microsecondsSinceEpoch.toString(),
                  name: name,
                   category: cat.isEmpty ? 'Прочее' : cat,
                   price: price, 
                   perBox: perBox > 0 ? perBox : 1,
                   ),
                );
              }else{
                existingProduct.name = name;
                existingProduct.category= cat;
                existingProduct.price = price;
                existingProduct.perBox = perBox > 0 ? perBox : 1;
              }
             })
          }, child: const Text('Сохранить', style: TextStyle(color: Colors.white),
        ),),
      ],
     ),
    );
  }

  void showAdminLoginDialog() {
    final pinCtrl = TextEditingController();
    showDialog(context: context
    , builder: (contex) => AlertDialog(
      title:  const Text('Вход для торгового агента'),
      constraints: TextField(
        controller: pinCtrl,
        keyboardType: TextInputType.number,
        obscureText: true,
        decoration:  const InputDecoration(
          labelText: 'Введите ПИН-код ',
          border: OutlineInputBorder(),
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(contex), child: const Text('Отмена'),),
        ElevatedButton(onPressed: (){
          if (pinCtrl.text == adminPin){
            setState(() => isAdmin = true);
            Navigator.pop(contex);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Режим управления прайсом включён')),
              );
          }else{
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Неверный ПИН-код')),
            );

          }
        }, 
        child: Text('Войти'),),
      ],
    ),
    );
  }

  void showCheckoutDialog(){
    final pointCtrl = TextEditingController();
    final phoneCtrl = TextEditingController();

    showDialog(context: context,
     builder: (context) => AlertDialog(
      title: Text('Оформление заказа'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: pointCtrl,
            decoration: const InputDecoration(
              labelText: 'Точка / Контейнер / Базар *',
              hintText: 'Например: Ошский базар, ряд 1, конт. 1',
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: phoneCtrl,
            keyboardType: TextInputType.phone,
            decoration: const InputDecoration(
              labelText: 'Номер телефона *',
              hintText: '0706940640 || 0703415312',
            ),
          ),
          const SizedBox(height: 16),
          Text('К оплате: $totalCartSum сом',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,
          ),
          ),
        ],
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context),
        child: const Text('Отмена'),),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
          onPressed: (){
            if (pointCtrl.text.trim().isEmpty || phoneCtrl.text.trim().isEmpty)
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Укажите название точки и телефон'),),);
            return;
          }
          final Map<MyProjectOsh, int> orderedItems = {};
          cart.forEach((id,qty) {
            final prod = products.firstWhere((p) => p.id == id);
            orderedItems[prod] = qty;
          }),
           ),
      ],
     ),
     );
  }

class MyProjectOshPageState extends State<MyProjectOshPage> {
  final Map<String, List<Map<String, String>>> productByCategory = {
  }
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
    switch (category) {
      case 'Ноутбуки':
        return Icon(Icons.laptop, color: Colors.blue);
      case 'Смартфоны':
        return Icon(Icons.smartphone, color: Colors.green);
      case 'Аксессуары':
        return Icon(Icons.headphones, color: Colors.orange);
      case 'Мониторы':
        return Icon(Icons.monitor, color: Colors.purple);
      case 'Принтер':
        return Icon(Icons.print, color: Colors.teal);
      case 'Игровые устройства':
        return Icon(Icons.sports_esports, color: Colors.redAccent);
      default:
        return Icon(Icons.shopping_bag, color: Colors.amber);
    }
    /*if (category == 'Ноутбуки') {
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
    }*/
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
        return Padding(
          padding: EdgeInsets.all(4),
          child: ListTile(
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
