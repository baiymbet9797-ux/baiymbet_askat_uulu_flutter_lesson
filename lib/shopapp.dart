import 'package:flutter/material.dart';

class ShopApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CatalogListPage(),
    );
  }
}

class CatalogListPage extends StatefulWidget {
  @override
  State<CatalogListPage> createState() => _CatalogListPage();
}

class _CatalogListPage extends State<CatalogListPage> {
  final List<Map<String, String>> products = List.generate(
    20,
    (i) => {
      'title': 'Товар ${i + 1}',
      'desc': 'Товар ${i + 1}',
      'image': 'https://picsum.photos/seed/item$i/200/140',
    },
  );

  List<String> selectedProducts = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Список товаров'),
        backgroundColor: Colors.amber,
        actions: [
          if (selectedProducts.isNotEmpty)
            TextButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => OrderPage(productTitle: selectedProducts),
                  ),
                );
              },
              icon: Icon(Icons.shopping_cart, color: Colors.black,),
              label: Text(
                'Купить (${selectedProducts.length})',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                
              ),
            ),
        ],
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final item = products[index];
          final title = item['title'];
          final isSelected = selectedProducts.contains(title);
          return Card(
            child: ListTile(
              leading: Image.network(
                item['image']!,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
              title: Text(item['title']!),
              trailing: IconButton(
                icon: Icon(
                  isSelected
                      ? Icons.shopping_cart_checkout
                      : Icons.add_shopping_cart,
                  color: isSelected ? Colors.green : Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    if (isSelected) {
                      selectedProducts.remove(title);
                    } else {
                      selectedProducts.add(title!);
                    }
                  });
                },
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ProductDetailPage(
                      title: item['title']!,
                      desc: item['desc']!,
                      imageUrl: item['image']!,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class ProductDetailPage extends StatelessWidget {
  final String title;
  final String desc;
  final String imageUrl;

  ProductDetailPage({
    required this.title,
    required this.desc,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title), backgroundColor: Colors.amber),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(imageUrl, height: 200, fit: BoxFit.cover),
            SizedBox(height: 12),

            Text(desc),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => OrderPage(productTitle: [title]),
                    ),
                  );
                },
                child: Text(
                  'Купить',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OrderPage extends StatelessWidget {
  final List<String> productTitle;

  OrderPage({required this.productTitle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Заказ и оплата'),
        backgroundColor: Colors.amber,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Ваш заказ',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),

            Text(productTitle.join('\n')),

            SizedBox(height: 24),
            Text(
              'Способ оплаты',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 16),

            ListTile(
              leading: Icon(Icons.credit_card),
              title: Text('Банковская карта'),
            ),
            ListTile(
              leading: Icon(Icons.account_balance_wallet_outlined),
              title: Text('Электронный кошелек'),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OrderConfirmation(
                        productTitle: productTitle.join('\n'),
                      ),
                    ),
                  );
                },
                child: Text(
                  'Оплатить',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OrderConfirmation extends StatelessWidget {
  final String productTitle;
  OrderConfirmation({required this.productTitle});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Подтверждение заказа'),
        backgroundColor: Colors.amber,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.check_circle, size: 80, color: Colors.green),
            SizedBox(height: 12),
            Text(
              textAlign: TextAlign.center,
              'Заказ успешно оформлен !',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 12),

            Text(
              textAlign: TextAlign.center,
              productTitle,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.popUntil(context, (rout) => rout.isFirst);
                },
                child: Text(
                  'Вернуться в каталог',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
