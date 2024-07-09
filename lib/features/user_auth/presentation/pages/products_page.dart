import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../bloc/products_bloc.dart';
import '../../../../bloc/routing_bloc.dart';
import '../../../../utils/logs.dart';
import '../../../../utils/path_util.dart';
import '../backend/entities/product_entity.dart';
import 'building_data.dart';

class UsersProductsPage extends StatefulWidget {
  const UsersProductsPage({super.key});

  @override
  State<UsersProductsPage> createState() => _UsersProductsPageState();
}

class _UsersProductsPageState extends State<UsersProductsPage> {
  List category = BuildingData.category;
  List products = BuildingData.dealProducts;
  List products1 = BuildingData.audioVideoProducts;
  List reviews = BuildingData.reviews;

  List<bool> isHovered = List.filled(BuildingData.dealProducts.length, false);

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    // Define a list of SVG paths
    List<String> svgPaths = [
      'assets/svg/electronic-store-top-brand-logo-1.svg',
      'assets/svg/electronic-store-top-brand-logo-2.svg',
      'assets/svg/electronic-store-top-brand-logo-3.svg',
      'assets/svg/electronic-store-top-brand-logo-1.svg',
      'assets/svg/electronic-store-top-brand-logo-5.svg',
      'assets/svg/electronic-store-top-brand-logo-6.svg',
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Container(
        color: Colors.white,
        child: Expanded(
          child: Column(
            children: [
              Container(
                color: Colors.white,
                height: screenHeight * 0.8,
                child: Stack(
                  children: [
                    Image(
                      width: double.infinity,
                      height: screenHeight * 0.7,
                      fit: BoxFit.fill,
                      image: AssetImage('assets/bg6.jpg'),
                    ),
                    Positioned(
                      child: Container(
                        height: screenHeight * 0.33,
                        width: screenWidth * 0.16,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 30.0, horizontal: 20.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  SvgPicture.asset(
                                      width: screenWidth * 0.025,
                                      height: screenHeight * 0.025,
                                      'assets/svg/electronic-store-top-brand-logo-3.svg'),
                                  SizedBox(
                                    width: screenWidth * 0.005,
                                  ),
                                  Text('Logoipsum'),
                                ],
                              ),
                              Text(
                                'The best home entertainment is here',
                                style: TextStyle(
                                    fontSize: screenWidth * 0.017,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black.withOpacity(0.8)),
                              ),
                              Text(
                                'Visit our store, get the best deals with our offers',
                                style: TextStyle(
                                    color: Colors.grey.shade700,
                                    fontSize: screenWidth * 0.01),
                              ),
                              TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    'Shop now',
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold),
                                  ))
                            ],
                          ),
                        ),
                      ),
                      right: screenWidth * 0.25,
                      top: screenHeight * 0.13,
                    ),
                    Positioned(
                      right: screenWidth * 0.208,
                      top: screenHeight * 0.65,
                      child: Container(
                        width: screenWidth * 0.58,
                        height: screenHeight * 0.1,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(
                                width: 1, color: Colors.grey.shade300)),
                        child: Row(
                          children: [
                            SizedBox(
                              width: screenWidth * 0.005,
                            ),
                            Container(
                              child: Row(
                                children: [
                                  SizedBox(
                                    height: screenHeight * 0.02,
                                    width: screenWidth * 0.02,
                                    child: SvgPicture.asset(
                                        color: Colors.blue,
                                        'assets/svg/truck-fast-solid.svg'),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Free shipping',
                                        style: TextStyle(
                                            color:
                                                Colors.black.withOpacity(0.8),
                                            fontSize: screenWidth * 0.007,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        'When you spend \$ 80 or more',
                                        style: TextStyle(
                                            color: Colors.grey.shade600,
                                            fontSize: screenWidth * 0.006),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    width: screenWidth * 0.03,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: screenHeight * 0.065,
                              child: VerticalDivider(
                                color: Colors.grey.shade300,
                                width: 2,
                              ),
                            ),
                            Container(
                              child: Row(
                                children: [
                                  SizedBox(
                                    height: screenHeight * 0.02,
                                    width: screenWidth * 0.02,
                                    child: SvgPicture.asset(
                                        color: Colors.blue,
                                        'assets/svg/comment-dots-solid.svg'),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'We are available 24/7',
                                        style: TextStyle(
                                            color:
                                                Colors.black.withOpacity(0.8),
                                            fontSize: screenWidth * 0.007,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        'Need help? contact us anytime',
                                        style: TextStyle(
                                            color: Colors.grey.shade600,
                                            fontSize: screenWidth * 0.006),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    width: screenWidth * 0.03,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: screenHeight * 0.065,
                              child: VerticalDivider(
                                color: Colors.grey.shade300,
                                width: 2,
                              ),
                            ),
                            Container(
                              child: Row(
                                children: [
                                  SizedBox(
                                      height: screenHeight * 0.02,
                                      width: screenWidth * 0.02,
                                      child: SvgPicture.asset(
                                          color: Colors.blue,
                                          'assets/svg/rotate-left-solid.svg')),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Satisfied or return',
                                        style: TextStyle(
                                            color:
                                                Colors.black.withOpacity(0.8),
                                            fontSize: screenWidth * 0.007,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        'Easy 30-day return policy',
                                        style: TextStyle(
                                            color: Colors.grey.shade600,
                                            fontSize: screenWidth * 0.006),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    width: screenWidth * 0.03,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: screenHeight * 0.065,
                              child: VerticalDivider(
                                color: Colors.grey.shade300,
                                width: 2,
                              ),
                            ),
                            Container(
                              child: Row(
                                children: [
                                  SizedBox(
                                      height: screenHeight * 0.02,
                                      width: screenWidth * 0.02,
                                      child: SvgPicture.asset(
                                          color: Colors.blue,
                                          'assets/svg/credit-card-regular.svg')),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        '100% secure payments',
                                        style: TextStyle(
                                            color:
                                                Colors.black.withOpacity(0.8),
                                            fontSize: screenWidth * 0.007,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        'Visa, Mastercard, Stripe, PayPal',
                                        style: TextStyle(
                                            color: Colors.grey.shade600,
                                            fontSize: screenWidth * 0.006),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    width: screenWidth * 0.03,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                height: screenHeight * 0.5,
                width: screenWidth * 0.58,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: Colors.grey.shade300, width: 1),
                ),
                child: GridView.count(
                  crossAxisCount: 2,
                  childAspectRatio: 1 / 1,
                  crossAxisSpacing: 2,
                  mainAxisSpacing: 2,
                  scrollDirection: Axis.horizontal,
                  children: category
                      .map((e) => Container(
                            //color: Colors.red,
                            child: Column(
                              children: [
                                Image(
                                  image: AssetImage(e['imageUrl']),
                                  height: screenHeight * 0.15,
                                ),
                                Text(
                                  e['desc'],
                                  style: TextStyle(
                                      color: Colors.black87,
                                      fontSize: screenWidth * 0.008,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  '${e['numberItems']} PRODUCTS',
                                  style: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontSize: screenWidth * 0.0055),
                                )
                              ],
                            ),
                          ))
                      .toList(),
                ),
              ),
              SizedBox(
                height: screenHeight * 0.05,
              ),
              Container(
                color: Colors.white,
                width: screenWidth * 0.58,
                child: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    double containerWidth = constraints
                        .maxWidth; // Access the width of the Container
                    return Row(
                      children: [
                        Image(
                          image: AssetImage(
                              'assets/categories/electronic-store-promotional-banner-2.jpg'),
                          width: containerWidth / 2,
                          fit: BoxFit.fill, // Use half of the Container's width
                        ),
                        Image(
                          image: AssetImage(
                              'assets/categories/electronic-store-promotional-banner-1.jpg'),
                          width: containerWidth / 2,
                          fit: BoxFit.fill, // Use half of the Container's width
                        ),
                      ],
                    );
                  },
                ),
              ),
              SizedBox(
                height: screenHeight * 0.05,
              ),
              Container(
                width: screenWidth * 0.58,
                height: screenHeight * 0.8,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(color: Colors.grey.shade300, width: 1)),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          Text(
                            'Today\'s best deal',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: screenWidth * 0.01),
                          ),
                          TextButton(
                              onPressed: () {},
                              child: Text(
                                'See more',
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: screenWidth * 0.008),
                              ))
                        ],
                      ),
                    ),
                    Container(
                      width: screenWidth * 0.6,
                      height: screenHeight * 0.75,
                      child: LayoutBuilder(
                        builder:
                            (BuildContext context, BoxConstraints constraints) {
                          double containerWidth = constraints
                              .maxWidth; // Access the width of the Container
                          return BlocBuilder<ProductBloc, ProductState>(
                            builder: (context, state) {
                              List<Product> products = state.products;
                              print('bloc invoked');
                              if (state is AllProductsLoadingState) {
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
                                              width: constraints.maxWidth * 0.05,
                                              height: constraints.maxHeight * 0.05,
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
                              }
                              else if (state is AllProductsErrorState) {
                                print('ErrorState ui');
                                print(state.message);
                                return Center(
                                  child: Text(state.message),
                                );
                              }
                              else if (state is AllProductsSuccessState) {
                                return GridView.builder(
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 20,
                                    mainAxisSpacing: 20,
                                    childAspectRatio: 11 / 10,
                                  ),
                                  itemCount: products.length,
                                  itemBuilder: (context, index) {
                                    Product product = products[index];
                                    log('Building item at index $index: ${product.description}');
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 50.0),
                                      child: GestureDetector(
                                        onTap: () {
                                          log('Tapped on product ID: ${product.id}');
                                          context.read<RoutingBloc>().add(ItemEvent(productId: product.id!));
                                          context.read<ProductBloc>().add(ProductByIdEvent(productId: product.id!));
                                          updateUrl('/mainPage/products/${product.id}/item');
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          child: Center(
                                            child: Column(
                                              children: [
                                                Image(
                                                  fit: BoxFit.contain,
                                                  image: NetworkImage(product.imageUrl),
                                                  height: screenHeight * 0.18,
                                                  width: screenWidth * 0.18,
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
                                                        decoration: TextDecoration.lineThrough,
                                                        color: Colors.grey.shade600,
                                                        fontSize: screenWidth * 0.009,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                    SizedBox(width: screenWidth * 0.01),
                                                    Text(
                                                      '${product.price * (1 - 20 / 100)} \$',
                                                      style: TextStyle(
                                                        color: Colors.black87,
                                                        fontSize: screenWidth * 0.007,
                                                        fontWeight: FontWeight.bold,
                                                      ),
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
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: screenHeight * 0.1,
              ),
              Container(
                color: Colors.white,
                width: screenWidth * 0.58,
                child: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    double containerWidth = constraints
                        .maxWidth; // Access the width of the Container
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: screenWidth * 0.18,
                          height: screenHeight * 0.3,
                          child: Stack(
                            children: [
                              Container(
                                color: Colors.grey.withOpacity(0.1),
                                width: screenWidth * 0.2,
                                height: screenHeight * 0.2,
                              ),
                              Positioned(
                                child: Text('Starting at \$ 49'),
                                left: screenWidth * 0.01,
                                top: screenHeight * 0.11,
                              ),
                              Positioned(
                                child: TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    'See more',
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: screenWidth * 0.008),
                                  ),
                                ),
                                top: screenHeight * 0.15,
                                left: screenWidth * 0.02,
                              ),
                              Positioned(
                                top: screenHeight * 0.04, // Adjust as needed
                                left: screenWidth * 0.05, // Adjust as needed
                                child: Image(
                                  width: screenWidth * 0.2,
                                  height: screenHeight * 0.2,
                                  image: AssetImage(
                                      'assets/categories/electronic-store-wireless-headphone.png'),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: Text(
                                  'Wireless headphones',
                                  style: themeData.textTheme.bodyLarge
                                      ?.copyWith(fontSize: screenWidth * 0.02),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: screenWidth * 0.18,
                          height: screenHeight * 0.3,
                          child: Stack(
                            children: [
                              Container(
                                color: Colors.grey.withOpacity(0.1),
                                width: screenWidth * 0.2,
                                height: screenHeight * 0.2,
                              ),
                              Positioned(
                                child: Text('Starting at \$ 49'),
                                left: screenWidth * 0.01,
                                top: screenHeight * 0.11,
                              ),
                              Positioned(
                                child: TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    'See more',
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: screenWidth * 0.008),
                                  ),
                                ),
                                top: screenHeight * 0.15,
                                left: screenWidth * 0.02,
                              ),
                              Positioned(
                                top: screenHeight * 0.04, // Adjust as needed
                                left: screenWidth * 0.05, // Adjust as needed
                                child: Image(
                                  width: screenWidth * 0.2,
                                  height: screenHeight * 0.2,
                                  image: AssetImage(
                                      'assets/categories/electronic-store-grooming.png'),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: Text(
                                  'Grooming',
                                  style: themeData.textTheme.bodyLarge
                                      ?.copyWith(fontSize: screenWidth * 0.02),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: screenWidth * 0.18,
                          height: screenHeight * 0.3,
                          child: Stack(
                            children: [
                              Container(
                                color: Colors.grey.withOpacity(0.1),
                                width: screenWidth * 0.2,
                                height: screenHeight * 0.2,
                              ),
                              Positioned(
                                child: Text('Starting at \$ 49'),
                                left: screenWidth * 0.01,
                                top: screenHeight * 0.11,
                              ),
                              Positioned(
                                child: TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    'See more',
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: screenWidth * 0.008),
                                  ),
                                ),
                                top: screenHeight * 0.15,
                                left: screenWidth * 0.02,
                              ),
                              Positioned(
                                top: screenHeight * 0.04, // Adjust as needed
                                left: screenWidth * 0.05, // Adjust as needed
                                child: Image(
                                  width: screenWidth * 0.2,
                                  height: screenHeight * 0.2,
                                  image: AssetImage(
                                      'assets/categories/electronic-store-video-games.png'),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: Text(
                                  'Video games',
                                  style: themeData.textTheme.bodyLarge
                                      ?.copyWith(fontSize: screenWidth * 0.02),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              SizedBox(
                height: screenHeight * 0.05,
              ),
              Container(
                width: screenWidth * 0.58,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: Colors.grey.shade300, width: 1),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          Text(
                            'audio & video',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: screenWidth * 0.01),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              'See more',
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: screenWidth * 0.008),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: screenWidth * 0.6,
                      height: screenHeight * 0.45,
                      child: LayoutBuilder(
                        builder:
                            (BuildContext context, BoxConstraints constraints) {
                          double containerWidth = constraints
                              .maxWidth; // Access the width of the Container
                          return // Define a list to track hover state for each item

                              GridView.count(
                            crossAxisCount: 1,
                            childAspectRatio: 5 / 3,
                            crossAxisSpacing: 2,
                            mainAxisSpacing: 2,
                            scrollDirection: Axis.horizontal,
                            children: products1.map((e) {
                              int index = products1.indexOf(
                                  e); // Get the index of the current item
                              return Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  children: [
                                    MouseRegion(
                                      cursor: SystemMouseCursors.click,
                                      // Use index to track hover state for each item individually
                                      onEnter: (event) {
                                        setState(() {
                                          isHovered[index] = true;
                                        });
                                      },
                                      onExit: (event) {
                                        setState(() {
                                          isHovered[index] = false;
                                        });
                                      },
                                      child: Image(
                                        fit: BoxFit.fitWidth,
                                        image: AssetImage(
                                          // Use the hover state of the current item
                                          isHovered[index]
                                              ? e['imageUrl1']
                                              : e['imageUrl2'],
                                        ),
                                        height: screenHeight * 0.2,
                                        width: screenWidth * 0.2,
                                      ),
                                    ),
                                    Row(
                                      children: List<Icon>.generate(
                                        e['review'].toInt(),
                                        (i) => const Icon(
                                          Icons.star,
                                          color: Colors.yellow,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      e['desc'],
                                      style: TextStyle(
                                        color: Colors.black87,
                                        fontSize: screenWidth * 0.008,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          '${e['previousPrice']} \$',
                                          style: TextStyle(
                                              decoration:
                                                  TextDecoration.lineThrough,
                                              color: Colors.grey.shade600,
                                              fontSize: screenWidth * 0.007,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          width: screenWidth * 0.01,
                                        ),
                                        Text(
                                          '${e['currentPrice']} \$',
                                          style: TextStyle(
                                              color: Colors.black87,
                                              fontSize: screenWidth * 0.007,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: screenHeight * 0.05,
              ),
              Container(
                width: screenWidth * 0.58,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(
                      color: Colors.grey.withOpacity(0.5),
                      width: 1,
                    )),
                child: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    double containerWidth = constraints
                        .maxWidth; // Access the width of the Container
                    return Row(
                      children: [
                        Container(
                          width: containerWidth / 2,
                          height: screenHeight * 0.4,
                          color: Colors.white,
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 40.0, top: 40.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Brand\'s deal',
                                  style: TextStyle(color: Colors.grey.shade600),
                                ),
                                SizedBox(
                                  height: screenHeight * 0.02,
                                ),
                                Text(
                                  'Save up to  \$ 200 on select Samsung washing machine',
                                  style: themeData.textTheme.bodyLarge,
                                ),
                                SizedBox(
                                  height: screenHeight * 0.02,
                                ),
                                Text('offer last until the end of the month'),
                                SizedBox(
                                  height: screenHeight * 0.02,
                                ),
                                TextButton(
                                    onPressed: () {},
                                    child: Text(
                                      'Show more',
                                      style: TextStyle(
                                          color: Colors.blue,
                                          fontSize: screenWidth * 0.01),
                                    ))
                              ],
                            ),
                          ),
                        ),
                        Image(
                          image: AssetImage(
                              'assets/brand/electronic-store-promotional-banner-hwidth-1.jpg'),
                          width: containerWidth / 2,
                          height: screenHeight * 0.4,
                          fit: BoxFit.fill, // Use half of the Container's width
                        ),
                      ],
                    );
                  },
                ),
              ),
              SizedBox(
                height: screenHeight * 0.05,
              ),
              Container(
                width: screenWidth * 0.58,
                height: screenHeight * 0.2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(
                    color: Colors.grey.withOpacity(0.5),
                    width: 1,
                  ),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 40.0, top: 40.0),
                      child: Row(
                        children: [
                          Text(
                            'Top brands',
                            style: TextStyle(color: Colors.grey.shade600),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 0.04,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: svgPaths.map((path) {
                        return Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.01),
                          child: SvgPicture.asset(
                            path,
                            width: screenWidth * 0.04,
                            height: screenHeight * 0.04,
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: screenHeight * 0.05,
              ),
              Container(
                width: screenWidth * 0.58,
                height: screenHeight * 0.6,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0, left: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'What is everyone saying?',
                        style: TextStyle(
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      // Add some space between text and reviews
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          for (int i = 0; i < 3; i++)
                            SizedBox(
                              height: screenHeight * 0.55,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  for (int j = 0; j < 2; j++)
                                    Container(
                                      width: screenWidth * 0.18,
                                      height: screenHeight * 0.25,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        border: Border.all(
                                          color: Colors.grey.withOpacity(0.5),
                                          width: 1,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(20.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: List<Icon>.generate(
                                                reviews[i * 2 + j]['review']
                                                    .toInt(),
                                                (index) => const Icon(
                                                  Icons.star,
                                                  color: Colors.yellow,
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 5),
                                            // Add space between stars and description
                                            Text(
                                              reviews[i * 2 + j]['desc'],
                                              style: TextStyle(
                                                  color: Colors.grey.shade600),
                                            ),
                                            SizedBox(height: 5),
                                            // Add space between description and avatar
                                            Row(
                                              children: [
                                                CircleAvatar(
                                                  backgroundImage: AssetImage(
                                                      reviews[i * 2 + j]
                                                          ['avatar']),
                                                ),
                                                SizedBox(
                                                    width: screenWidth * 0.005),
                                                // Add space between avatar and name
                                                Text(
                                                  reviews[i * 2 + j]['name'],
                                                  style: TextStyle(
                                                      color:
                                                          Colors.grey.shade700),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: screenHeight * 0.05,
              ),
              Container(
                width: screenWidth * 0.58,
                height: screenHeight * 0.2,
                child: Stack(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: screenHeight * 0.06,
                        ),
                        SizedBox(
                          width: screenWidth * 0.45,
                          child: Divider(
                            color: Colors.grey.shade300,
                            thickness: 2,
                          ),
                        ),
                        SizedBox(
                          height: screenHeight * 0.02,
                        ),
                        Container(
                          width: screenWidth * 0.35,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Expert advice',
                                    style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        color: Colors.grey.shade600),
                                  ),
                                  Text(
                                    '1-222-345-6789',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Customer service',
                                    style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        color: Colors.grey.shade600),
                                  ),
                                  Text(
                                    '1-222-345-6789',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Have any question?',
                                    style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        color: Colors.grey.shade600),
                                  ),
                                  Text(
                                    'Contact us',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    Positioned(
                      child: Image(
                        image: AssetImage(
                            'assets/contact/electronic-store-support-team.png'),
                      ),
                      top: screenHeight * 0.002,
                      left: screenWidth * 0.455,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

