part of 'products_bloc.dart';

abstract class ProductState {
  final Product? product;
  final List<Product> products;
  final String message;

  ProductState({required this.products, required this.message, this.product});
}

class ProductsInitialState extends ProductState {
  ProductsInitialState() : super(message: '', products: []);
}

// get product by id

class ProductByIdLoadingState extends ProductState {
  Product product;
  ProductByIdLoadingState({
    required this.product,
    required super.message,
    required super.products,
  });
}
class ProductByIdSuccessState extends ProductState {
  Product product;
  ProductByIdSuccessState({
    required this.product,
    required super.message,
    required super.products,
  });
}
class ProductByIdErrorState extends ProductState {
  Product product;
  ProductByIdErrorState({
    required this.product,
    required super.message,
    required super.products,
  });
}

// all products
class AllProductsSuccessState extends ProductState {
  AllProductsSuccessState({
    required super.products,
    required super.message,
  });
}

class AllProductsLoadingState extends ProductState {
  AllProductsLoadingState({
    required super.products,
    required super.message,
  });
}

class AllProductsErrorState extends ProductState {
  AllProductsErrorState({
    required super.products,
    required super.message,
  });
}

//add product
class AddProductLoadingState extends ProductState {
  AddProductLoadingState({
    required super.products,
    required super.message,
  });
}

class AddProductSuccessState extends ProductState {
  AddProductSuccessState({
    required super.products,
    required super.message,
  });
}

class AddProductErrorState extends ProductState {
  AddProductErrorState({
    required super.products,
    required super.message,
  });
}

//user products
class UserProductsLoadingState extends ProductState {
  UserProductsLoadingState({
    required super.products,
    required super.message,
  });
}

class UserProductsSuccessState extends ProductState {
  UserProductsSuccessState({
    required super.products,
    required super.message,
  });
}

class UserProductsErrorState extends ProductState {
  UserProductsErrorState({
    required super.products,
    required super.message,
  });
}

//delete product
class DeleteProductLoadingState extends ProductState {
  DeleteProductLoadingState({
    required super.products,
    required super.message,
  });
}

class DeleteProductSuccessState extends ProductState {
  DeleteProductSuccessState({
    required super.products,
    required super.message,
  });
}

class DeleteProductErrorState extends ProductState {
  DeleteProductErrorState({
    required super.products,
    required super.message,
  });
}

//update product
class UpdateProductLoadingState extends ProductState {
  UpdateProductLoadingState({
    required super.products,
    required super.message,
  });
}

class UpdateProductSuccessState extends ProductState {
  UpdateProductSuccessState({
    required super.products,
    required super.message,
  });
}

class UpdateProductErrorState extends ProductState {
  UpdateProductErrorState({
    required super.products,
    required super.message,
  });
}
