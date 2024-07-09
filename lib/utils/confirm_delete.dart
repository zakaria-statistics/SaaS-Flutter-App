import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/products_bloc.dart';
import '../classes/language_constants.dart';

Future<void> confirmDelete({required BuildContext context, required String productId, required String userId}) async {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(translation(context).homeConfirmDeleteDialogTitle),
        content: SingleChildScrollView(
          child: ListBody(
            children: [
              Text(translation(context).homeConfirmDeleteDialogText),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              translation(context).addCancelButtonText,
              style: TextStyle(color: Colors.black87),
            ),
          ),
          TextButton(
            onPressed: () {
              context.read<ProductBloc>().add(DeleteProductEvent(id: productId, userId: userId));
              Navigator.of(context).pop();
            },
            child: Text(
              translation(context).homeDeleteButtonText,
              style: TextStyle(color: Colors.black87),
            ),
          ),
        ],
      );
    },
  );
}