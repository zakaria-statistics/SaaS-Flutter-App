import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../../classes/language_constants.dart';
import '../backend/entities/user_entity.dart';

class MyDataSource extends DataTableSource {
  final List<UserEntity> _users;
  final BuildContext context;
  List<UserEntity> _filteredUsers;

  MyDataSource(this._users, this.context)
      : _filteredUsers = List.from(_users);

  void sort<T>(Comparable<T> Function(UserEntity user) getField, bool ascending) {
    _filteredUsers.sort((a, b) {
      if (!ascending) {
        final UserEntity temp = a;
        a = b;
        b = temp;
      }
      final Comparable<T> aValue = getField(a);
      final Comparable<T> bValue = getField(b);
      return Comparable.compare(aValue, bValue);
    });
    notifyListeners();
  }

  void filter(String searchText) {
    _filteredUsers = _users.where((user) {
      return user.username!.toLowerCase().contains(searchText.toLowerCase());
    }).toList();
    notifyListeners();
  }

  @override
  DataRow? getRow(int index) {
    if (index >= _filteredUsers.length) return null;
    final user = _filteredUsers[index];
    return DataRow(
      cells: [
        _buildDataCell(user.username ?? 'Unknown'),
        _buildActionCell(user),
      ],
    );
  }

  DataCell _buildDataCell(String text) {
    return DataCell(
      Text(
        text,
        textAlign: TextAlign.center,
      ),
    );
  }

  DataCell _buildActionCell(UserEntity user) {
    return DataCell(
      Center(
        child: Row(
          children: [
            _buildIconButton(
                Icons.delete,
                Colors.redAccent,
                    () => _confirmDelete(user.id!),
                translation(context).homeDeleteButtonText),
            const SizedBox(width: 8),
            _buildIconButton(Icons.edit, Colors.black45, () => _editUser(user),
                translation(context).updateButtonText),
          ],
        ),
      ),
    );
  }

  Widget _buildIconButton(
      IconData icon,
      Color color,
      void Function() onPressed,
      String tooltip,
      ) {
    return Tooltip(
      message: tooltip,
      child: IconButton(
        icon: Icon(icon, color: color),
        onPressed: onPressed,
      ),
    );
  }

  Future<void> _confirmDelete(String id) async {
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
              child: Text(translation(context).addCancelButtonText),
            ),
            TextButton(
              onPressed: () {
                _deleteData(id);
                Navigator.of(context).pop();
              },
              child: Text(translation(context).homeDeleteButtonText),
            ),
          ],
        );
      },
    );
  }

  void _deleteData(String id) {
    FirebaseFirestore.instance.collection('users').doc(id).delete();
  }

  void _editUser(UserEntity user) {
    Navigator.pushNamed(
      context,
      '/update',
      arguments: {'data': user},
    );
  }

  @override
  int get rowCount => _filteredUsers.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
}