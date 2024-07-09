import 'package:bloc/bloc.dart';
import '../features/user_auth/presentation/backend/entities/product_entity.dart';
import '../features/user_auth/presentation/backend/services/product_service.dart';
import '../utils/logs.dart';
part 'products_event.dart';
part 'products_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductService productService = ProductService();

  ProductBloc() : super(ProductsInitialState()) {

    //get product by id
    on((ProductByIdEvent event, emit) async {
      log('event item triggering');
      Product product = Product(name: '', description: '', price: 0, imageUrl: '', category: '', stock: 0);
      emit(
        ProductByIdLoadingState(products: [], message: 'product loading....', product: product)
      );
      try {
        product = await productService.getProduct(event.productId);
        print('product data! ${product.toString()}');
        emit(
          ProductByIdSuccessState(products: [], message: 'product loaded', product: product)
        );
      } catch (e) {
        emit(
            ProductByIdErrorState(products: [], message: 'error occurred loading the product', product: product)
        );
      }
    });
    //all products
    on((AllProductsEvent event, emit) async {
      emit(
        AllProductsLoadingState(
            products: [], message: 'Loading products in progress...'),
      );
      try {
        List<Product> products = await productService.getProducts();
        emit(
          AllProductsSuccessState(
              products: products, message: 'Loading products succeeded'),
        );
      } on Exception catch (e) {
        emit(AllProductsErrorState(
            products: [], message: 'error occurred getting products'));
        print('bloc level getting products error: $e');
      }
    });
    //user products
    on((UserProductsEvent event, emit) async{
      emit(
        UserProductsLoadingState(products: [], message: 'Loading products in progress...'),
      );
      try {
        List<Product> products = await productService.getProductsByUserId(event.userId);
        emit(
            UserProductsSuccessState(products: products, message: 'Loading products succeeded')
        );
      } catch(e) {
        emit(
            UserProductsErrorState(products: [], message: 'error occurred fetching products')
        );
      }
    });
    //add product
    on((AddProductEvent event, emit) async {
      emit(AddProductLoadingState(
          products: [], message: 'Loading adding product...'));
      try {
        await productService.addProduct(event.product);
        emit(AddProductSuccessState(
            products: [], message: 'Adding product succeeded'));
        if (event.userId != null) {
          add(UserProductsEvent(userId: event.userId!));
        }

      } catch (e) {
        emit(AddProductErrorState(
            products: [], message: 'error occurred adding product'));
        print('bloc level adding product error: $e');
      }
    });
    //delete product
    on((DeleteProductEvent event, emit) async{
      emit(
        DeleteProductLoadingState(products: [], message: 'delete is processing...')
      );
      try {
        await productService.deleteProduct(event.id, event.userId!);
        emit(
          DeleteProductSuccessState(products: [], message: 'product deleted')
        );
        if (event.userId != null) {
          add(UserProductsEvent(userId: event.userId!));
        }
      } catch (e) {
        emit(
          DeleteProductErrorState(products: [], message: 'error occurred while deleting product')
        );
      }
    });
    //update product
    on((UpdateProductEvent event, emit) async{
      emit(
        UpdateProductLoadingState(products: [], message: 'updating is processing...')
      );
      try {
        await productService.updateProduct(event.id, event.product);
        emit(
            UpdateProductSuccessState(products: [], message: 'updating product succeeded')
        );
        if (event.userId != null) {
          add(UserProductsEvent(userId: event.userId!));
        }
      } catch (e) {
        emit(
          UpdateProductErrorState(products: [], message: 'error occurred while updating product!')
        );
      }
    });
  }
}
