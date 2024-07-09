import '../entities/product_entity.dart';
import '../repository/product_repository.dart';

class ProductService {

  final ProductRepository productRepository = ProductRepository();

  /*Stream<List<Product>> streamProducts() {
    try {
      return productRepository.streamProducts();
    } on Exception catch (e) {
      return throw(e.toString());
    }
  }*/

  Future<List<Product>> getProducts() async {
    try {
      print('service exception try');
      return await productRepository.getProducts();
    } on Exception catch (e) {
      print('Error parsing product data service level: $e');
      return throw Exception(' service level exception catch $e');
    }
  }
  Future<List<Product>> getProductsByUserId(String userId) async {
    try {
      print('service exception user products try');
      print('userd id $userId');
      return await productRepository.getProductsByUserId(userId);
    } on Exception catch (e) {
      print('Error parsing product data service level: $e');
      return throw Exception(' service level exception catch $e');
    }
  }

  Future<Product> getProduct(String id) async{

    return await productRepository.getProduct(id);
  }

  Future<void> addProduct(Product product) {
    return productRepository.addProduct(product);
  }

  Future<void> updateProduct(String id, Product product) {
    return productRepository.updateProduct(id, product);
  }

  Future<void> deleteProduct(String productId, String userId) {
    return productRepository.deleteProduct(productId, userId);
  }
}
