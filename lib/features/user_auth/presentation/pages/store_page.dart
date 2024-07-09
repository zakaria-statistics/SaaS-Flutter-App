import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_web_app/features/user_auth/presentation/backend/entities/product_entity.dart';
import 'package:uuid/uuid.dart';
import '../../../../bloc/products_bloc.dart';
import '../../../../bloc/routing_bloc.dart';
import '../../../../classes/language_constants.dart';
import '../../../../utils/confirm_delete.dart';
import '../../../../utils/logs.dart';
import '../../../../utils/path_util.dart';
import '../backend/entities/user_entity.dart';
import 'add_post_new.dart';

class StorePage extends StatefulWidget {
  final String id;

  const StorePage({required this.id, Key? key}) : super(key: key);

  @override
  State<StorePage> createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  late Future<UserEntity> _userEntityFuture;
  final productsCollection = FirebaseFirestore.instance.collection("Products");
  final usersCollection = FirebaseFirestore.instance.collection("Users");
  final currentUser = FirebaseAuth.instance.currentUser!;


  @override
  void initState() {
    super.initState();
    _userEntityFuture = getUserById(widget.id);
  }

  Future<UserEntity> getUserById(String userId) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> userSnapshot =
          await FirebaseFirestore.instance
              .collection('Users')
              .doc(userId)
              .get();
      if (userSnapshot.exists) {
        Map<String, dynamic>? map = userSnapshot.data();
        return UserEntity(
            id: userId,
            photo: map!['photo'],
            username: map['username'],
            role: '',
            desc: map['desc'],
            sales: map['sales'],
            joined: map['joined'],
            review: map['review']);
      } else {
        // User not found
        return UserEntity(id: '', username: '', role: '', photo: '');
      }
    } catch (e) {
      // Error occurred while fetching user
      print('Error fetching user: $e');
      return UserEntity();
    }
  }






  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return FutureBuilder<UserEntity>(
      future: _userEntityFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else {
          UserEntity userEntity = snapshot.data!;

          return Container(
            width: screenWidth * 1,
            height: screenHeight * 1.2,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0, top: 40.0),
              child: Row(
                children: [
                  Column(
                    children: [
                      Container(
                        width: screenWidth * 0.25,
                        height: screenHeight * 0.6,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15)),
                          border: Border.all(
                              width: 1, color: Colors.black.withOpacity(0.2)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: screenHeight * 0.15,
                              width: screenWidth * 0.25,
                              decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(15)),
                                color: Colors.grey.withOpacity(0.1),
                                border: Border.all(
                                    width: 1,
                                    color: Colors.black.withOpacity(0.2)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Container(
                                  height: screenWidth * 0.05,
                                  width: screenWidth * 0.05,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      fit: BoxFit.contain,
                                      // Fit the image to cover the entire circle
                                      image: NetworkImage(userEntity.photo!),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: screenHeight * 0.05,
                            ),
                            Container(
                              height: screenHeight * 0.3,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: screenWidth * 0.2,
                                    height: screenHeight * 0.06,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                          width: 1,
                                          color: Colors.grey.withOpacity(0.5),
                                        )),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Text('Name'),
                                        SizedBox(
                                          width: screenWidth * 0.02,
                                        ),
                                        Text('${userEntity.username}')
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: screenWidth * 0.2,
                                    height: screenHeight * 0.06,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                          width: 1,
                                          color: Colors.grey.withOpacity(0.5),
                                        )),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Text('Sales'),
                                        SizedBox(
                                          width: screenWidth * 0.02,
                                        ),
                                        Text('+1.4k')
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: screenWidth * 0.2,
                                    height: screenHeight * 0.06,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                          width: 1,
                                          color: Colors.grey.withOpacity(0.5),
                                        )),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Text('Joined'),
                                        SizedBox(
                                          width: screenWidth * 0.02,
                                        ),
                                        Text('2021')
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: screenWidth * 0.2,
                                    height: screenHeight * 0.06,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                          width: 1,
                                          color: Colors.grey.withOpacity(0.5),
                                        )),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Text('Review'),
                                        SizedBox(
                                          width: screenWidth * 0.02,
                                        ),
                                        const Row(
                                          children: [
                                            Text('4.5'),
                                            Icon(
                                              Icons.star,
                                              color: Colors.yellow,
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: screenHeight * 0.05,
                      ),
                      Container(
                        width: screenWidth * 0.25,
                        height: screenHeight * 0.2,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15)),
                          border: Border.all(
                              width: 1, color: Colors.black.withOpacity(0.2)),
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Text(
                                    'About me',
                                    style: TextStyle(
                                        fontSize: screenWidth * 0.011),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                '${userEntity.desc}',
                                style: TextStyle(fontSize: screenWidth * 0.01),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: screenWidth * 0.025,
                            ),
                            SizedBox(
                              width: screenWidth * 0.01,
                            ),
                            Container(
                              width: screenWidth * 0.69,
                              height: screenHeight,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(15)),
                                border: Border.all(
                                    width: 1,
                                    color: Colors.black.withOpacity(0.2)),
                              ),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Products'),
                                        currentUser.uid == widget.id ? Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            // Change the color to match other cards
                                            decoration: BoxDecoration(
                                                color: Colors.blue,
                                              border: Border.all(
                                                width: 1,
                                                color: Colors.grey
                                              ),
                                              borderRadius: BorderRadius.circular(10)
                                            ),
                                            child: InkWell(
                                              onTap: () {
                                                showDialog(
                                                  context: context,
                                                  builder: (BuildContext context) {
                                                    return AddPostDialogNew(
                                                      onAdd: (
                                                          String imageUrl,
                                                          String description,
                                                          double price,
                                                          double review,
                                                          double reduction
                                                          ) async {
                                                        context.read<ProductBloc>().add(AddProductEvent(product: Product(
                                                          name: '',
                                                          price: price,
                                                          category: '',
                                                          description: description,
                                                          imageUrl: imageUrl,
                                                          stock: 10,
                                                        ), userId: currentUser.uid));
                                                      }
                                                    );
                                                  },
                                                );
                                              },
                                              borderRadius: BorderRadius.circular(20.0),
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                                child: SizedBox(
                                                  height: 60,
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Text('Add product', style: TextStyle(color: Colors.white),),
                                                      Center(
                                                        child: Icon(
                                                          Icons.add,
                                                          size: 30,
                                                          color: Colors
                                                              .white, // Change the color of the plus sign
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ) : Container(),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: screenHeight * 0.02,
                                  ),
                                  Container(
                                    width: screenWidth * 0.69,
                                    height: screenHeight * 0.8,
                                    child: Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: BlocBuilder<ProductBloc, ProductState>(
                                        builder: (context, state) {
                                          List<Product> products = state.products;
                                          print('bloc invoked');

                                          if (state is UserProductsLoadingState) {
                                            print('LoadingState...');
                                            return LayoutBuilder(
                                              builder: (context, constraints) {
                                                return Container(
                                                  height: constraints.maxHeight * 0.2,
                                                  width: constraints.maxWidth * 0.2,
                                                  color: Colors.white,
                                                  child: Align(
                                                    alignment: Alignment.center,
                                                    child: LayoutBuilder(
                                                      builder: (context, constraints) {
                                                        return SizedBox(
                                                          width: constraints.maxWidth * 0.03,
                                                          height: constraints.maxWidth * 0.03,
                                                          child: CircularProgressIndicator(
                                                            color: Colors.blue,
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                );
                                              },
                                            );
                                          } else if (state is UserProductsErrorState) {
                                            print('ErrorState ui');
                                            print(state.message);
                                            return Center(
                                              child: Text(state.message),
                                            );
                                          }
                                          else if (state is UserProductsSuccessState) {
                                            print('SuccessState');
                                            return GridView.builder(
                                              scrollDirection: Axis.horizontal,
                                              gridDelegate:
                                              const SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 2,
                                                crossAxisSpacing: 20,
                                                mainAxisSpacing: 20,
                                                childAspectRatio: 10 / 11,
                                              ),
                                              itemCount: products.length,
                                              itemBuilder: (context, index) {
                                                print('holly molly it s moo');
                                                Product product = products[index];
                                                print('............!');
                                                print(products[index].description);
                                                print('............!');
                                                return GestureDetector(
                                                  onTap: () {
                                                    log('Tapped on product ID: ${product.id}');
                                                    context.read<RoutingBloc>().add(ItemEvent(productId: product.id!));
                                                    context.read<ProductBloc>().add(ProductByIdEvent(productId: product.id!));
                                                    updateUrl('/mainPage/products/${product.id}/item');
                                                  },
                                                  child: Padding(
                                                    padding: const EdgeInsets.symmetric(
                                                        horizontal: 50.0, vertical: 50.0),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(10),
                                                      ),
                                                      child: Center(
                                                        child: Column(
                                                          children: [
                                                            currentUser.uid == widget.id ? Row(
                                                              children: [
                                                                IconButton(
                                                                    onPressed: (){
                                                                      confirmDelete(context: context, productId: product.id!, userId: currentUser.uid);
                                                                      print('delete product ids ${product.id!}');
                                                                    },
                                                                    icon: Icon(Icons.delete, color: Colors.redAccent,)
                                                                ),
                                                                IconButton(
                                                                    onPressed: (){
                                                                      showDialog(context: context, builder: (BuildContext context) {
                                                                        return AddPostDialogNew(
                                                                            initialDescription: product.description,
                                                                            initialImageUrl: product.imageUrl,
                                                                            initialPrice: product.price,
                                                                            initialReduction: 10,
                                                                            initialReview: 4,
                                                                            onAdd: (
                                                                                String imageUrl,
                                                                                String description,
                                                                                double price,
                                                                                double review,
                                                                                double reduction
                                                                                ) async {
                                                                              Product currentProduct = Product(id: product.id, name: 'no data', description: description, price: price, imageUrl: imageUrl, category: 'no data', stock: 10, );
                                                                              print('product1 ${currentProduct.toString()}');
                                                                              context.read<ProductBloc>().add(UpdateProductEvent(id: product.id!, product: currentProduct, userId: currentUser.uid));
                                                                            }
                                                                        );
                                                                      },
                                                                      );
                                                                    },
                                                                    icon: Icon(Icons.edit, color: Colors.grey.shade400,)
                                                                ),
                                                              ],
                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            ) : Container(),
                                                            Image(
                                                              fit: BoxFit.contain,
                                                              image: NetworkImage(
                                                                product.imageUrl,
                                                              ),
                                                              height: screenHeight * 0.15,
                                                              width: screenWidth * 0.15,
                                                            ),
                                                            Row(
                                                              children: List<Icon>.generate(
                                                                4,
                                                                    (i) => const Icon(
                                                                  Icons.star,
                                                                  color: Colors.yellow,
                                                                ),
                                                              ),
                                                            ),
                                                            Text(
                                                              product.description,
                                                              maxLines: 2,
                                                              overflow: TextOverflow.ellipsis,
                                                              style: TextStyle(
                                                                color: Colors.black87,
                                                                fontSize: screenWidth * 0.008,
                                                                fontWeight: FontWeight.bold,
                                                              ),
                                                            ),
                                                            Row(
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              children: [
                                                                Text(
                                                                  '${product.price} \$',
                                                                  style: TextStyle(
                                                                      decoration:
                                                                      TextDecoration.lineThrough,
                                                                      color: Colors.grey.shade600,
                                                                      fontSize: screenWidth * 0.009,
                                                                      fontWeight: FontWeight.bold),
                                                                ),
                                                                SizedBox(
                                                                  width: screenWidth * 0.01,
                                                                ),
                                                                Text(
                                                                  '${product.price * (1 - 20 / 100)} \$',
                                                                  style: TextStyle(
                                                                      color: Colors.black87,
                                                                      fontSize: screenWidth * 0.007,
                                                                      fontWeight: FontWeight.bold),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                            );
                                          }
                                          else {
                                            return Container();
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: screenWidth * 0.01,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
