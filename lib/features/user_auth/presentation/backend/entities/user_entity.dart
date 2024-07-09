import 'package:cloud_firestore/cloud_firestore.dart';

class UserEntity{

  final String? id;
  final String? username;
  final String? email;
  final int? joined;
  final double? review;
  final int? sales;
  final String? desc;
  final String? role;
  final String? photo;
  final List<String>? postList;


  UserEntity({this.postList, this.id, this.username, this.email, this.role, this.photo, this.desc, this.sales, this.review, this.joined});

  Map<String, dynamic> toJson() {
    return {
      "username": username,
      "email": email,
      'role': role,
      'photo': photo,
      'desc' : desc,
      'joined': joined,
      'review': review,
      'sales': sales
    };
  }


  factory UserEntity.fromJson(Map<String, dynamic> json) {
    return UserEntity(
      id: json['id'],
      email: json['email'],
      username: json['username'],
      photo: json['photo'],
    );
  }

  @override
  String toString() {
    return 'UserEntity(id: $id, username: $username, email: $email, '
        'desc: $desc, ''role: $role, photo: $photo, '
        'joined: $joined, review: $review, sales: $sales)';
  }

  factory UserEntity.fromSnapshot(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return UserEntity(
      id: doc.id,
      username: data['username'],
      email: data['email'],
      role: data['role'],
      photo: data['photo'],
      desc: data['desc'],
      review: data['review'],
      joined: data['joined'],
      sales: data['sales']
    );
  }

}