import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:my_web_app/bloc/routing_bloc.dart';
import 'package:my_web_app/features/user_auth/presentation/widgets/review.dart';
import '../../../../bloc/cart_bloc/cart_bloc.dart';
import '../../../../bloc/products_bloc.dart';
import '../backend/entities/product_entity.dart';
import 'package:web/web.dart' as web;

import 'cart_page.dart';

class ItemPage extends StatelessWidget {
  final String id;
  ItemPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    print('path tracking with Uri ${Uri.base.path}');
    print('path tracking with web ${web.window.location.href}');

    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        logState(state);

        if (state is ProductByIdLoadingState) {
          return _buildLoadingState();
        } else if (state is ProductByIdSuccessState) {
          return _buildSuccessState(context, screenWidth, screenHeight, state.product);
        } else if (state is ProductByIdErrorState) {
          return _buildErrorState(state.message);
        } else {
          return Container();
        }
      },
    );
  }

  void logState(ProductState state) {
    if (state is ProductByIdLoadingState) {
      print('Loading product details...');
    } else if (state is ProductByIdSuccessState) {
      print('Product loaded successfully: ${state.product.description}');
    } else if (state is ProductByIdErrorState) {
      print('Error loading product: ${state.message}');
    }
  }

  Widget _buildLoadingState() {
    return Center(
      child: CircularProgressIndicator(
        color: Colors.blue,
      ),
    );
  }

  Widget _buildSuccessState(BuildContext context, double screenWidth, double screenHeight, Product product) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildProductImages(screenWidth, screenHeight, product),
            SizedBox(width: screenWidth * 0.01),
            _buildProductDetails(context, screenWidth, screenHeight, product),
          ],
        ),
        _buildRelatedProducts(screenWidth, screenHeight, product),
      ],
    );
  }

  Widget _buildProductImages(double screenWidth, double screenHeight, Product product) {
    return Container(
      width: screenWidth * 0.4,
      height: screenHeight * 0.8,
      child: Column(
        children: [
          SizedBox(height: screenHeight * 0.05),
          Image(
            fit: BoxFit.fill,
            image: NetworkImage(product.imageUrl),
            height: screenHeight * 0.4,
            width: screenWidth * 0.32,
          ),
          SizedBox(height: screenHeight * 0.05),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: product.imageUrls!.map((url) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.005),
                child: Image(
                  fit: BoxFit.fill,
                  image: NetworkImage(url),
                  height: screenHeight * 0.18,
                  width: screenWidth * 0.1,
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildProductDetails(BuildContext context, double screenWidth, double screenHeight, Product product) {
    return Container(
      width: screenWidth * 0.4,
      height: screenHeight * 0.8,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: screenHeight * 0.04),
          Text(
            product.description,
            style: TextStyle(
              color: Colors.black87,
              fontSize: screenWidth * 0.015,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: screenHeight * 0.005),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                '${product.price} \$',
                style: TextStyle(
                  decoration: TextDecoration.lineThrough,
                  color: Colors.grey.shade600,
                  fontSize: screenWidth * 0.015,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: screenWidth * 0.01),
              Text(
                '${product.price * (1 - 20 / 100)} \$',
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: screenWidth * 0.015,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: screenHeight * 0.005),
          Row(
            children: List<Icon>.generate(
              4,
                  (i) => Icon(
                Icons.star,
                color: Colors.yellow,
                size: screenWidth * 0.015,
              ),
            ),
          ),
          SizedBox(height: screenHeight * 0.005),
          Text(
            'Key features',
            style: TextStyle(
              color: Colors.black87,
              fontSize: screenWidth * 0.01,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: screenHeight * 0.005),
          Padding(
            padding: EdgeInsets.only(left: screenWidth * 0.02),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('• Newest technology \n'
                    '• Best in class components \n'
                    '• Dimensions -69.5 x 75.0 x 169.0 \n'
                    '• Maintenance free \n'
                    '• 12 years warranty'),
              ],
            ),
          ),
          SizedBox(height: screenHeight * 0.01),
          _buildAddToCartSection(screenWidth, screenHeight, product, context),
          Divider(
            color: Colors.grey,
            height: screenHeight * 0.05,
          ),
          Row(
            children: [
              Text('Category: ', style: TextStyle(color: Colors.grey.shade600)),
              Text('Air conditioner', style: TextStyle(color: Colors.blue)),
            ],
          ),
          SizedBox(height: screenHeight * 0.05),
          ReviewPage(),
        ],
      ),
    );
  }

  Widget _buildAddToCartSection(double screenWidth, double screenHeight, Product product, BuildContext context) {
    return Row(
      children: [
        _buildQuantityControl(screenWidth, screenHeight, Icons.add, () {
          BlocProvider.of<CartBloc>(context).add(AddItem(product));
        }),
        Container(
          width: screenWidth * 0.02,
          height: screenHeight * 0.035,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 1),
          ),
          child: Center(child: Text('1', style: TextStyle(color: Colors.grey))),
        ),
        _buildQuantityControl(screenWidth, screenHeight, Icons.remove, () {
          BlocProvider.of<CartBloc>(context).add(RemoveItem(product.id!));
        }),
        SizedBox(width: screenWidth * 0.01),
        Container(
          width: screenWidth * 0.1,
          height: screenHeight * 0.035,
          decoration: BoxDecoration(
            color: Colors.black87,
            border: Border.all(color: Colors.grey, width: 1),
          ),
          child: TextButton(
            onPressed: () {},
            child: Text(
              'Add to cart',
              style: TextStyle(color: Colors.white, fontSize: screenWidth * 0.01),
            ),
          ),
        ),
        IconButton(
          icon: Icon(Icons.shopping_cart),
          onPressed: () {
            print('cart event');
            context.read<RoutingBloc>().add(CartEvent1());
          },
        ),
      ],
    );
  }

  Widget _buildQuantityControl(double screenWidth, double screenHeight, IconData icon, VoidCallback onPressed) {
    return Container(
      width: screenWidth * 0.02,
      height: screenHeight * 0.035,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 1),
      ),
      child: TextButton(
        onPressed: onPressed,
        child: Icon(icon, color: Colors.grey),
      ),
    );
  }

  Widget _buildRelatedProducts(double screenWidth, double screenHeight, Product product) {
    return Container(
      width: screenWidth * 0.81,
      height: screenHeight * 0.6,
      child: Padding(
        padding: EdgeInsets.only(left: screenWidth * 0.03),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Related products', style: TextStyle(fontSize: screenWidth * 0.02)),
            SizedBox(height: screenHeight * 0.02),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 5,  // Adjust the item count as needed
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.005),
                    child: Container(
                      height: screenHeight * 0.4,
                      width: screenWidth * 0.18,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Column(
                          children: [
                            Image(
                              fit: BoxFit.contain,
                              image: NetworkImage(product.imageUrl),
                              height: screenHeight * 0.2,
                              width: screenWidth * 0.2,
                            ),
                            Row(
                              children: List<Icon>.generate(
                                4,
                                    (i) => Icon(Icons.star, color: Colors.yellow),
                              ),
                            ),
                            Text(
                              product.description,
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: screenWidth * 0.008,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  '${product.price} \$',
                                  style: TextStyle(
                                    decoration: TextDecoration.lineThrough,
                                    color: Colors.grey.shade600,
                                    fontSize: screenWidth * 0.009,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(width: screenWidth * 0.01),
                                Text(
                                  '${product.price * (1 - 20 / 100)} \$',
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: screenWidth * 0.007,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
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

  Widget _buildErrorState(String message) {
    return Center(
      child: Text(message),
    );
  }
}
