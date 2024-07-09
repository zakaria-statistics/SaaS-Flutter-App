import 'package:cloud_firestore/cloud_firestore.dart';
import '../entities/order_entity.dart';

class OrderRepository {
  final CollectionReference ordersCollection = FirebaseFirestore.instance.collection('Orders');

  Future<List<MyOrder>> getOrders() async {
    QuerySnapshot snapshot = await ordersCollection.get();
    return snapshot.docs.map((doc) => MyOrder.fromFirestore(doc.data() as Map<String, dynamic>)).toList();
  }

  Future<MyOrder> getOrder(String id) async {
    DocumentSnapshot doc = await ordersCollection.doc(id).get();
    return MyOrder.fromFirestore(doc.data() as Map<String, dynamic>);
  }

  Future<void> addOrder(MyOrder order) async {
    await ordersCollection.add(order.toFirestore());
  }

  Future<void> updateOrder(MyOrder order) async {
    await ordersCollection.doc(order.id).update(order.toFirestore());
  }

  Future<void> deleteOrder(String id) async {
    await ordersCollection.doc(id).delete();
  }
}
