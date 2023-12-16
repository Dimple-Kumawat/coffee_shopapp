import 'package:flutter/material.dart';

class CoffeeProduct {
  final String name;
  final String imageUrl;
  final double price;
  final String category;

  CoffeeProduct({
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.category,
  });
}

class CoffeeScreen extends StatefulWidget {
  @override
  _CoffeeScreenState createState() => _CoffeeScreenState();
}

class _CoffeeScreenState extends State<CoffeeScreen> {
  final List<CoffeeProduct> coffeeProducts = [
    CoffeeProduct(
        name: 'Espresso',
        imageUrl: 'assets/images/esp.jpg',
        price: 2.99,
        category: 'Hot'),
    CoffeeProduct(
        name: 'Cappuccino',
        imageUrl: 'assets/images/Cappuccino.jpg',
        price: 4.99,
        category: 'Hot'),
    CoffeeProduct(
        name: 'Latte',
        imageUrl: 'assets/images/Latte.jpg',
        price: 3.99,
        category: 'Hot'),
    CoffeeProduct(
        name: 'Iced Coffee',
        imageUrl: 'assets/images/Iced.jpg',
        price: 3.49,
        category: 'Cold'),
    CoffeeProduct(
        name: 'Cold Brew',
        imageUrl: 'assets/images/Cold.jpg',
        price: 4.49,
        category: 'Cold'),
  ];

  List<CoffeeProduct> filteredProducts = [];

  String selectedCategory = 'All';

  @override
  void initState() {
    super.initState();
    filteredProducts = coffeeProducts;
  }

  void _filterProducts(String query) {
    setState(() {
      filteredProducts = coffeeProducts
          .where((product) =>
              product.name.toLowerCase().contains(query.toLowerCase()) &&
              (selectedCategory == 'All' ||
                  product.category == selectedCategory))
          .toList();
    });
  }

  void _changeCategory(String category) {
    setState(() {
      selectedCategory = category;
      _filterProducts('');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Coffee Shop'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: _filterProducts,
              decoration: InputDecoration(
                labelText: 'Search for coffee products',
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildCategoryFilter('All'),
              _buildCategoryFilter('Hot'),
              _buildCategoryFilter('Cold'),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredProducts.length,
              itemBuilder: (context, index) {
                return CoffeeProductCard(
                    coffeeProduct: filteredProducts[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryFilter(String category) {
    return ElevatedButton(
      onPressed: () => _changeCategory(category),
      style: ElevatedButton.styleFrom(
        primary: selectedCategory == category ? Colors.blue : null,
      ),
      child: Text(category),
    );
  }
}

class CoffeeProductCard extends StatelessWidget {
  final CoffeeProduct coffeeProduct;

  CoffeeProductCard({required this.coffeeProduct});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.asset(
            coffeeProduct.imageUrl,
            height: 200.0,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  coffeeProduct.name,
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8.0),
                Text(
                  '\$${coffeeProduct.price.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 16.0, color: Colors.green),
                ),
                SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Add to cart logic
                      },
                      child: Text('Add to Cart'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Buy now logic
                      },
                      child: Text('Buy Now'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
