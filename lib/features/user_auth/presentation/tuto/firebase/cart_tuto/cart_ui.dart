/*
// screens/product_list_screen.dart


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../bloc/cart_bloc/cart_bloc.dart';
import '../../../backend/entities/cart_item.dart';

class ProductListScreen extends StatelessWidget {
  final List<Product> products = [
    Product(id: 'p1', title: 'Product 1', price: 29.99),
    Product(id: 'p2', title: 'Product 2', price: 59.99),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
      ),
      body: Row(
        children: [
          SizedBox(
            width: 500,
            height: 500,
            child: ListView.builder(
              itemCount: products.length,
              itemBuilder: (ctx, i) => ListTile(
                title: Text(products[i].title),
                subtitle: Text('\$${products[i].price}'),
                trailing: TextButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(Colors.green)
                  ),
                  child: Text('Add ot cart', style: TextStyle(color: Colors.black),),
                  onPressed: () {
                    BlocProvider.of<CartBloc>(context).add(AddItem(products[i]));
                  },
                ),
              ),
            ),
          ),
          SizedBox(
            height: 500,
            width: 500,
            child: BlocBuilder<CartBloc, CartState>(
              builder: (ctx, cartState) => ListView.builder(
                itemCount: cartState.items.length,
                itemBuilder: (ctx, i) {
                  final cartItem = cartState.items.values.toList()[i];
                  return ListTile(
                    title: Text(cartItem.title),
                    subtitle: Text('Total: \$${(cartItem.price * cartItem.quantity).toStringAsFixed(2)}'),
                    trailing: Text('${cartItem.quantity} x'),
                    leading: TextButton(
                      child: Text('Remove from cart', style: TextStyle(
                          color: Colors.black
                      ),),
                      style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all(Colors.red)
                      ),
                      onPressed: () {
                        print('check id ${cartItem.id}');
                        BlocProvider.of<CartBloc>(context).add(RemoveItem(cartItem.id));
                      },
                    ),
                  );
                },
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (ctx) => CartScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}

// screens/cart_screen.dart


class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
      ),
      body: Column(
        children: [
          Card(
            margin: EdgeInsets.all(15),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total',
                    style: TextStyle(fontSize: 20),
                  ),
                  Spacer(),
                  BlocBuilder<CartBloc, CartState>(
                    builder: (ctx, cartState) => Chip(
                      label: Text(
                        '\$${cartState.totalAmount.toStringAsFixed(2)}',
                        style: TextStyle(
                          color: Theme.of(context).primaryTextTheme.bodyMedium?.color,
                        ),
                      ),
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                  ),
                  TextButton(
                    child: Text('ORDER NOW'),
                    onPressed: () {
                      // Add your order logic here
                    },
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          SizedBox(
            height: 500,
            width: 500,
            child: BlocBuilder<CartBloc, CartState>(
                builder: (ctx, cartState) => ListView.builder(
                  itemCount: cartState.items.length,
                  itemBuilder: (ctx, i) {
                    final cartItem = cartState.items.values.toList()[i];
                    return ListTile(
                      title: Text(cartItem.title),
                      subtitle: Text('Total: \$${(cartItem.price * cartItem.quantity).toStringAsFixed(2)}'),
                      trailing: Text('${cartItem.quantity} x'),
                      leading: TextButton(
                        child: Text('Remove from cart', style: TextStyle(
                          color: Colors.black
                        ),),
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all(Colors.red)
                        ),
                        onPressed: () {
                          BlocProvider.of<CartBloc>(context).add(RemoveItem(cartItem.id));
                        },
                      ),
                    );
                  },
                ),
              ),
          ),
        ],
      ),
    );
  }
}
*/
