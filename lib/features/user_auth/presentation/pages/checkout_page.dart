import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../bloc/cart_bloc/cart_bloc.dart';
import '../../../../bloc/routing_bloc.dart';
import 'invoice_page.dart';

class CheckoutScreen extends StatelessWidget {
  final currencyFormatter = NumberFormat.currency(symbol: '\$');
  final _formKey = GlobalKey<FormState>();

  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController postalCodeController = TextEditingController();
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController expirationDateController = TextEditingController();
  final TextEditingController cvvController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        border: Border.all(
          color: Colors.white24,
          width: 1
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(10)
        ),
        boxShadow: [
          BoxShadow(
          color: Colors.grey.shade50,
          spreadRadius: 2
        )
        ]
      ),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
        child: Align(
          alignment: Alignment(0, 0),
          child: Column(
            children: [
              Text('please enter the invoice informations'),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 500.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildCartSummary(context),
                      SizedBox(height: 10),
                      _buildShippingForm(),
                      SizedBox(height: 10),
                      _buildPaymentForm(),
                      SizedBox(height: 20),
                      _buildPlaceOrderButton(context),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
  }

  Widget _buildCartSummary(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      margin: EdgeInsets.all(15),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Total:',
              style: TextStyle(fontSize: 20),
            ),
            BlocBuilder<CartBloc, CartState>(
              builder: (ctx, cartState) => Chip(
                label: Text(
                  '\$${cartState.totalAmount.toStringAsFixed(2)}',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                backgroundColor: Colors.lightBlueAccent,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShippingForm() {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      margin: EdgeInsets.all(15),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Shipping Information',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: fullNameController,
              decoration: InputDecoration(
                labelText: 'Full Name',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your full name';
                }
                return null;
              },
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: addressController,
              decoration: InputDecoration(
                labelText: 'Address',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your address';
                }
                return null;
              },
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: cityController,
              decoration: InputDecoration(
                labelText: 'City',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your city';
                }
                return null;
              },
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: postalCodeController,
              decoration: InputDecoration(
                labelText: 'Postal Code',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your postal code';
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentForm() {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      margin: EdgeInsets.all(15),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Payment Information',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: cardNumberController,
              decoration: InputDecoration(
                labelText: 'Credit Card Number',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your credit card number';
                }
                return null;
              },
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: expirationDateController,
              decoration: InputDecoration(
                labelText: 'Expiration Date',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the expiration date';
                }
                return null;
              },
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: cvvController,
              decoration: InputDecoration(
                labelText: 'CVV',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the CVV';
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlaceOrderButton(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 50,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(
            Colors.blue
          ),
        ),
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            final order = {
              'fullName': fullNameController.text,
              'address': addressController.text,
              'city': cityController.text,
              'postalCode': postalCodeController.text,
              'cardNumber': cardNumberController.text,
              'expirationDate': expirationDateController.text,
              'cvv': cvvController.text,
            };

            // Dispatch InvoiceEvent with order details
            BlocProvider.of<RoutingBloc>(context).add(InvoiceEvent(orderDetails: order));
          }
        },
        child: Text('Place Order'),
      ),
    );
  }

}
