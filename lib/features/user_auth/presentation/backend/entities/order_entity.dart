import 'package:cloud_firestore/cloud_firestore.dart';

class MyOrder {
  final String id;
  final String userId;
  final List<String> products;
  final double totalAmount;
  final String status;
  final DateTime orderDate;

  MyOrder({
    required this.id,
    required this.userId,
    required this.products,
    required this.totalAmount,
    required this.status,
    required this.orderDate,
  });

  factory MyOrder.fromFirestore(Map<String, dynamic> data) {
    return MyOrder(
      id: data['id'],
      userId: data['userId'],
      products: List<String>.from(data['products']),
      totalAmount: data['totalAmount'],
      status: data['status'],
      orderDate: (data['orderDate'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'userId': userId,
      'products': products,
      'totalAmount': totalAmount,
      'status': status,
      'orderDate': orderDate,
    };
  }
}
