import '../entities/order_entity.dart';
import '../entities/product_entity.dart';
import '../repository/order_repository.dart';
import '../repository/product_repository.dart';

class OrderService {
  final ProductRepository productRepository;
  final OrderRepository orderRepository;

  OrderService({required this.productRepository, required this.orderRepository});


  Future<List<MyOrder>> getOrders() {
    return orderRepository.getOrders();
  }

  Future<MyOrder> getOrder(String id) {
    return orderRepository.getOrder(id);
  }

  Future<void> addOrder(MyOrder order) {
    return orderRepository.addOrder(order);
  }

  Future<void> updateOrder(MyOrder order) {
    return orderRepository.updateOrder(order);
  }

  Future<void> deleteOrder(String id) {
    return orderRepository.deleteOrder(id);
  }


  /*Future<void> placeOrder(MyOrder order) async {

    double totalAmount = 0;

    // Calculate total amount and check stock
    for (String productId in order.products) {
      Product product = await productRepository.getProduct(productId);
      if (product.stock! < 1) {
        throw Exception('Product $productId is out of stock');
      }
      totalAmount += product.price!;
    }

    // Create the order
    await orderRepository.addOrder(order);

    // Update the stock of products
    for (String productId in order.products) {
      Product product = await productRepository.getProduct(productId);
      await productRepository.updateProductStock(product.id!, product.stock! - 1);
    }

    // (Optional) Send confirmation email
    //await emailService.sendOrderConfirmation(order);
  }*/
}
