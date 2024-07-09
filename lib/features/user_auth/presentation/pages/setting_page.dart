import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../bloc/products_bloc.dart';
import '../backend/entities/product_entity.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  SettingsPageState createState() => SettingsPageState();
}

class SettingsPageState extends State<SettingPage> {

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      height: screenHeight,
      child: Column(
        children: [
          SizedBox(
            height: screenHeight * 0.02,
          ),
          Container(
            height: screenHeight * 0.8,
            width: screenWidth * 0.6,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey.shade400, width: 1)),
            child: BlocBuilder<ProductBloc, ProductState>(
              builder: (context, state) {
                List<Product> products = state.products;
                print('bloc invoked');

                if (state is AllProductsLoadingState) {
                  print('LoadingState...');
                  return LayoutBuilder(
                    builder: (context, constraints) {
                      return Container(
                        height: constraints.maxHeight * 0.2,
                        width: constraints.maxWidth * 0.2,
                        color: Colors.white,
                        child: Align(
                          alignment: Alignment.center,
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              return SizedBox(
                                width: constraints.maxWidth * 0.05,
                                height: constraints.maxHeight * 0.05,
                                child: CircularProgressIndicator(
                                  color: Colors.blue,
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    },
                  );
                } else if (state is AllProductsErrorState) {
                  print('ErrorState ui');
                  print(state.message);
                  return Center(
                    child: Text(state.message),
                  );
                } else if (state is AllProductsSuccessState) {
                  print('SuccessState');
                  return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      childAspectRatio: 11 / 12,
                    ),
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      print('holly molly it s moo');
                      Product product = products[index];
                      print('............!');
                      print(products[index].description);
                      print('............!');
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 50.0, vertical: 50.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Column(
                              children: [
                                Image(
                                  fit: BoxFit.contain,
                                  image: NetworkImage(
                                    product.imageUrl!,
                                  ),
                                  height: screenHeight * 0.18,
                                  width: screenWidth * 0.18,
                                ),
                                Row(
                                  children: List<Icon>.generate(
                                    4,
                                    (i) => const Icon(
                                      Icons.star,
                                      color: Colors.yellow,
                                    ),
                                  ),
                                ),
                                Text(
                                  product.description!,
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
                                          decoration:
                                              TextDecoration.lineThrough,
                                          color: Colors.grey.shade600,
                                          fontSize: screenWidth * 0.009,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      width: screenWidth * 0.01,
                                    ),
                                    Text(
                                      '${product.price! * (1 - 20 / 100)} \$',
                                      style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: screenWidth * 0.007,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return Container();
                }
              },
            ),
          ),
          SizedBox(
            height: screenHeight * 0.1,
          ),
        ],
      ),
    );
  }
}
