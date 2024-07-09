import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../bloc/cart_bloc/cart_bloc.dart';

class InvoiceSummaryScreen extends StatelessWidget {
  final Map<String, dynamic>? order; // Nullable

  InvoiceSummaryScreen({Key? key, this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        border: Border.all(color: Colors.white24, width: 1),
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow: [BoxShadow(color: Colors.grey.shade50, spreadRadius: 2)],
      ),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Align(
        alignment: Alignment(0, 0),
        child: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: 400.0, vertical: 50.0),
          child: Column(
            children: [
              Text('Invoice details'),
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                margin: EdgeInsets.all(15),
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Infos Summary',
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      Divider(thickness: 2, height: 32),
                      if (order != null) ...[
                        _buildOrderDetailRow(
                            'Full Name', order!['fullName'].toString()),
                        _buildOrderDetailRow(
                            'Address', order!['address'].toString()),
                        _buildOrderDetailRow('City', order!['city'].toString()),
                        _buildOrderDetailRow(
                            'Postal Code', order!['postalCode'].toString()),
                        /*_buildOrderDetailRow(
                            'Credit Card Number', order!['cardNumber'].toString()),
                        _buildOrderDetailRow(
                            'Expiration Date', order!['expirationDate'].toString()),
                        _buildOrderDetailRow('CVV', order!['cvv'].toString()),*/
                        Divider(thickness: 2, height: 32),
                        Text(
                          'Order Summary',
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        Divider(thickness: 2, height: 32),
                        BlocBuilder<CartBloc, CartState>(
                          builder: (context, state) {
                            return Column(
                              children: [
                                _buildOrderDetailRow(
                                  'order total items', '${state.items.length}'
                                ),
                                _buildOrderDetailRow(
                                  'order total amount', '\$${state.totalAmount.toStringAsFixed(2)}'
                                ),

                              ],
                            );
                          },
                        )
                      ] else ...[
                        Center(
                            child: Text('No order details available',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500))),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOrderDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(value),
        ],
      ),
    );
  }
}
