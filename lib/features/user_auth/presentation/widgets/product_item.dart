import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../bloc/products_bloc.dart';
import '../../../../bloc/routing_bloc.dart';
import '../../../../utils/path_util.dart';
import '../backend/entities/product_entity.dart';

Widget buildProductItem(BuildContext context, Product product) {
  double screenWidth = MediaQuery.of(context).size.width;
  double screenHeight = MediaQuery.of(context).size.height;

  return GestureDetector(
    onTap: () {
      context.read<RoutingBloc>().add(ItemEvent(productId: product.id!));
      context.read<ProductBloc>().add(ProductByIdEvent(productId: product.id!));
      updateUrl('/mainPage/products/${product.id}/item');
    },
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Image(
            fit: BoxFit.contain,
            image: NetworkImage(product.imageUrl),
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
            product.description,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
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
                    fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(width: screenWidth * 0.01),
              Text(
                '${product.price * (1 - 20 / 100)} \$',
                style: TextStyle(
                    color: Colors.black87,
                    fontSize: screenWidth * 0.007,
                    fontWeight: FontWeight.bold
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}