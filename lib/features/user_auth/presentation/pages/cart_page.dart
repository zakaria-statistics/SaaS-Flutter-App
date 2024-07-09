import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../bloc/cart_bloc/cart_bloc.dart';
import '../../../../bloc/routing_bloc.dart';
import '../backend/entities/cart_item.dart';
import 'checkout_page.dart';

class CartScreen extends StatelessWidget {
  final currencyFormatter = NumberFormat.currency(symbol: '\$');

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          _buildCartSummary(context),
          SizedBox(height: 10),
          _buildCartList(context),
        ],
      ),
    );
  }

  Widget _buildCartSummary(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(15),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () {
                BlocProvider.of<CartBloc>(context).add(ResetCart());
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: Text(
                'Reset cart',
                style: TextStyle(color: Colors.white),
              ),
            ),
            Spacer(),
            Text(
              'Total:',
              style: TextStyle(fontSize: 20),
            ),
            BlocBuilder<CartBloc, CartState>(
              builder: (ctx, cartState) => Chip(
                label: Text(
                  '\$${cartState.totalAmount.toStringAsFixed(2)}',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                backgroundColor: Colors.lightBlueAccent,
              ),
            ),
            TextButton(
              child: Text(
                'ORDER NOW',
                style: TextStyle(color: Colors.green),
              ),
                onPressed: () {
                  BlocProvider.of<RoutingBloc>(context).add(CheckoutEvent());
                },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCartList(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;
    return BlocBuilder<CartBloc, CartState>(
      builder: (ctx, cartState) {
        if (cartState.items.isEmpty) {
          return Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey, width: 1)),
            height: heightScreen * 0.78,
            width: widthScreen * 0.8,
            child: Center(
              child: Text(
                'Your cart is empty',
                style: TextStyle(fontSize: 20),
              ),
            ),
          );
        }
        return SizedBox(
          height: 800,
          width: 1000,
          child: ListView.builder(
            itemCount: cartState.items.length,
            itemBuilder: (ctx, i) {
              final cartItem = cartState.items.values.toList()[i];
              return _buildCartItem(context, cartItem);
            },
          ),
        );
      },
    );
  }

  Widget _buildCartItem(BuildContext context, CartItem cartItem) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Image.network(
              cartItem.image, // Replace with actual image URL
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cartItem.title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  currencyFormatter.format(cartItem.price),
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.remove),
                      onPressed: () {
                        BlocProvider.of<CartBloc>(context)
                            .add(RemoveItem(cartItem.id));
                      },
                    ),
                    Text('${cartItem.quantity}'),
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        BlocProvider.of<CartBloc>(context)
                            .add(AddItem(cartItem.product));
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          Text(
            currencyFormatter.format(cartItem.price * cartItem.quantity),
            style: TextStyle(fontSize: 16),
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              BlocProvider.of<CartBloc>(context)
                  .add(RemoveAllItems(productId: cartItem.id));
            },
            color: Colors.red,
          ),
        ],
      ),
    );
  }
}

class CartScreen3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    final currencyFormatter = NumberFormat.currency(symbol: '\$');
    return Column(
      children: [
        Card(
          margin: EdgeInsets.all(15),
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                    onPressed: () {
                      BlocProvider.of<CartBloc>(context).add(ResetCart());
                    },
                    style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(Colors.red)),
                    child: Text(
                      'Reset cart',
                      style: TextStyle(color: Colors.white),
                    )),
                Spacer(),
                Text(
                  'Total: ',
                  style: TextStyle(fontSize: 20),
                ),
                BlocBuilder<CartBloc, CartState>(
                  builder: (ctx, cartState) => Chip(
                    label: Text(
                      '\$${cartState.totalAmount.toStringAsFixed(2)}',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    backgroundColor: Colors.lightBlueAccent,
                  ),
                ),
                TextButton(
                  child: Text(
                    'ORDER NOW',
                    style: TextStyle(color: Colors.green),
                  ),
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
                  if (cartState.items.isEmpty) {
                    return Center(
                      child: Text(
                        'Your cart is empty',
                        style: TextStyle(fontSize: 20),
                      ),
                    );
                  }
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Image.network(
                            cartItem.image, // Replace with actual image URL
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                cartItem.title,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                currencyFormatter.format(cartItem.price),
                                style: TextStyle(fontSize: 16),
                              ),
                              SizedBox(height: 8),
                              Row(
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.remove),
                                    onPressed: () {
                                      // Decrement quantity logic
                                      BlocProvider.of<CartBloc>(context)
                                          .add(RemoveItem(cartItem.id));
                                    },
                                  ),
                                  Text('${cartItem.quantity}'),
                                  IconButton(
                                    icon: Icon(Icons.add),
                                    onPressed: () {
                                      BlocProvider.of<CartBloc>(context)
                                          .add(AddItem(cartItem.product));
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Text(
                          currencyFormatter
                              .format(cartItem.price * cartItem.quantity),
                          style: TextStyle(fontSize: 16),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            BlocProvider.of<CartBloc>(context)
                                .add(RemoveAllItems(productId: cartItem.id));
                          },
                          color: Colors.red,
                        ),
                      ],
                    ),
                  );
                },
              ),
            )),
      ],
    );
  }
}

class CartScreen2 extends StatelessWidget {
  final currencyFormatter = NumberFormat.currency(symbol: '\$');

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, cartState) {
        if (cartState.items.isEmpty) {
          return Center(
            child: Text(
              'Your cart is empty',
              style: TextStyle(fontSize: 20),
            ),
          );
        }
        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: cartState.items.length,
                itemBuilder: (ctx, i) {
                  final cartItem = cartState.items.values.toList()[i];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Image.network(
                            'https://via.placeholder.com/80',
                            // Replace with actual image URL
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                cartItem.title,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                currencyFormatter.format(cartItem.price),
                                style: TextStyle(fontSize: 16),
                              ),
                              SizedBox(height: 8),
                              Row(
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.remove),
                                    onPressed: () {
                                      // Decrement quantity logic
                                    },
                                  ),
                                  Text('${cartItem.quantity}'),
                                  IconButton(
                                    icon: Icon(Icons.add),
                                    onPressed: () {
                                      // Increment quantity logic
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Text(
                          currencyFormatter
                              .format(cartItem.price * cartItem.quantity),
                          style: TextStyle(fontSize: 16),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            BlocProvider.of<CartBloc>(context)
                                .add(RemoveItem(cartItem.id));
                          },
                          color: Colors.red,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Subtotal',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    currencyFormatter.format(cartState.totalAmount),
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    currencyFormatter.format(cartState.totalAmount),
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Navigate to checkout screen
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                backgroundColor: Colors.black, // Button color
              ),
              child: Text(
                'Proceed to checkout',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }
}

class CartScreen1 extends StatelessWidget {
  final currencyFormatter = NumberFormat.currency(symbol: '\$');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<CartBloc, CartState>(
          builder: (context, cartState) {
            if (cartState.items.isEmpty) {
              return Center(
                child: Text(
                  'Your cart is empty',
                  style: TextStyle(fontSize: 20),
                ),
              );
            }

            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartState.items.length,
                    itemBuilder: (ctx, i) {
                      final cartItem = cartState.items.values.toList()[i];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Image.network(
                                'https://via.placeholder.com/80',
                                // Replace with actual image URL
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    cartItem.title,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    currencyFormatter.format(cartItem.price),
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  SizedBox(height: 8),
                                  Row(
                                    children: [
                                      IconButton(
                                        icon: Icon(Icons.remove),
                                        onPressed: () {
                                          BlocProvider.of<CartBloc>(context)
                                              .add(RemoveItem(cartItem.id));
                                        },
                                      ),
                                      Text('${cartItem.quantity}'),
                                      IconButton(
                                        icon: Icon(Icons.add),
                                        onPressed: () {
                                          BlocProvider.of<CartBloc>(context)
                                              .add(AddItem(cartItem.product));
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              currencyFormatter
                                  .format(cartItem.price * cartItem.quantity),
                              style: TextStyle(fontSize: 16),
                            ),
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                BlocProvider.of<CartBloc>(context)
                                    .add(RemoveItem(cartItem.id));
                              },
                              color: Colors.red,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Divider(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Subtotal',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        currencyFormatter.format(cartState.totalAmount),
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        currencyFormatter.format(cartState.totalAmount),
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    // Navigate to checkout screen
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                    backgroundColor: Colors.black, // Button color
                  ),
                  child: Text(
                    'Proceed to checkout',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
