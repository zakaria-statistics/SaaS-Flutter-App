import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../entities/product_entity.dart';

class ProductRepository {
  final CollectionReference productsCollection =
      FirebaseFirestore.instance.collection('Products');
  final usersCollection = FirebaseFirestore.instance.collection("Users");
  final currentUser = FirebaseAuth.instance.currentUser!;

  Future<bool> isConnected() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    return connectivityResult != ConnectivityResult.none;
  }

  Future<List<Product>> getProducts() async {
    try {
      bool online = await isConnected();
      GetOptions getOptions = GetOptions(
        source: online ? Source.server : Source.cache,
      );

      QuerySnapshot snapshot = await productsCollection.get(getOptions);

      print('snapshot');
      print(
          'Number of documents in Products collection: ${snapshot.docs.length}');
      print('snapshot');

      if (snapshot.docs.isEmpty) {
        print('No documents found in the Products collection.');
        return [];
      }

      return snapshot.docs.map((doc) {
        try {
          return Product.fromFirestore(doc.data() as Map<String, dynamic>, doc.id);
        } catch (e) {
          print('Error parsing product data: ${e.toString()}');
          throw Exception('Error parsing product data');
        }
      }).toList();
    } on FirebaseException catch (e) {
      // Handle Firestore specific errors
      print('FirebaseException while fetching products: ${e.message}');
      switch (e.code) {
        case 'permission-denied':
          print('Permission denied: ${e.message}');
          throw Exception('Permission denied while fetching products');
        case 'unavailable':
          print('Service unavailable: ${e.message}');
          throw Exception('Service unavailable, please try again later');
        default:
          throw Exception('FirebaseException while fetching products: ${e.message}');
      }
    } catch (e) {
      // Handle general errors
      print('Error fetching products: ${e.toString()}');
      throw Exception('Error fetching products');
    }
  }

  Future<List<Product>> getProductsByUserId(String userId) async {
    try {
      bool online = await isConnected();
      GetOptions getOptions = GetOptions(
        source: online ? Source.server : Source.cache,
      );

      DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
          await usersCollection.doc(userId).get();
      if (!documentSnapshot.exists)
        return [];
      else {
        print('+++++++++++++++++++++++');
        print(documentSnapshot.id);
        print(userId);
        print('+++++++++++++++++++++++');
        List<dynamic> postsId = documentSnapshot.data()?['postList'] ?? [];
        print('user products postsId $postsId');
        if (postsId.isEmpty) {
          print('No product IDs found for the user.');
          return [];
        }
        QuerySnapshot snapshot = await productsCollection.where(FieldPath.documentId, whereIn: postsId).get(getOptions);
        // Handle empty postsId list

        print('snapshot');
        print(
            'Number of documents in Products collection: ${snapshot.docs
                .length}');
        print('snapshot');

        if (snapshot.docs.isEmpty) {
          print('No documents found in the Products collection.');
          return [];
        }

        return snapshot.docs.map((doc) {
          try {
            return Product.fromFirestore(doc.data() as Map<String, dynamic>, doc.id);
          } catch (e) {
            print('Error parsing product data: ${e.toString()}');
            throw Exception('Error parsing product data');
          }
        }).toList();
      }
    } on FirebaseException catch (e) {
      print('FirebaseException while fetching products: ${e.message}');
      throw Exception(
          'FirebaseException while fetching products: ${e.message}');
    } catch (e) {
      print('Error fetching products: ${e.toString()}');
      throw Exception('Error fetching products');
    }
  }

  Future<Product> getProduct(String id) async {
    try {
      bool online = await isConnected();
      GetOptions getOptions = GetOptions(
        source: online ? Source.server : Source.cache,
      );

      DocumentSnapshot doc = await productsCollection.doc(id).get(getOptions);
      print('product id = ${id}');

      try {
        return Product.fromFirestore(doc.data() as Map<String, dynamic>, doc.id);
      } catch (e) {
        print('Error parsing product data: ${e.toString()}');
        throw Exception('Error parsing product data');
      }
    } on FirebaseException catch (e) {
      print('FirebaseException while fetching product: ${e.message}');
      throw Exception('FirebaseException while fetching product: ${e.message}');
    } catch (e) {
      print('Error fetching product: ${e.toString()}');
      throw Exception('Error fetching product');
    }
  }

  Future<void> addProduct(Product product) async {
    try {
      DocumentReference ref = await productsCollection.add(product.toFirestore());
      await usersCollection.doc(currentUser.uid).update({
        'postList': FieldValue.arrayUnion([ref.id])
      });
    } on FirebaseException catch (e) {
      print('FirebaseException while adding product: ${e.message}');
      throw Exception('FirebaseException while adding product: ${e.message}');
    } catch (e) {
      print('Error adding product: ${e.toString()}');
      throw Exception('Error adding product');
    }
  }

  Future<void> updateProduct(String id, Product product) async {
    try {
      print('update id $id and product price ${product.price}');
      await productsCollection.doc(id).update(product.toFirestore());
    } on FirebaseException catch (e) {
      print('FirebaseException while updating product: ${e.message}');
      throw Exception('FirebaseException while updating product: ${e.message}');
    } catch (e) {
      print('Error updating product: ${e.toString()}');
      throw Exception('Error updating product');
    }
  }

  Future<void> deleteProduct(String productId, String userId) async {
    try {
      await productsCollection.doc(productId).delete();
      await usersCollection.doc(currentUser.uid).update({
        'postList': FieldValue.arrayRemove([productId])
      });
    } on FirebaseException catch (e) {
      print('FirebaseException while deleting product: ${e.message}');
      throw Exception('FirebaseException while deleting product: ${e.message}');
    } catch (e) {
      print('Error deleting product: ${e.toString()}');
      throw Exception('Error deleting product');
    }
  }

  Future<void> updateProductStock(String id, int stock) async {
    try {
      await productsCollection.doc(id).update({'stock': stock});
    } on FirebaseException catch (e) {
      print('FirebaseException while updating product stock: ${e.message}');
      throw Exception(
          'FirebaseException while updating product stock: ${e.message}');
    } catch (e) {
      print('Error updating product stock: ${e.toString()}');
      throw Exception('Error updating product stock');
    }
  }
}
