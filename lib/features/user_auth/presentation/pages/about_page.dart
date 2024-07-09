import 'package:flutter/material.dart';
import 'package:my_web_app/classes/language_constants.dart';
import '../widgets/footer.dart';
import 'my_drawer.dart';
import 'package:carousel_slider/carousel_slider.dart';

class AboutPage extends StatelessWidget {
  AboutPage({super.key});

  final List<String> imgList = [
    'assets/ads/since.png',
    'assets/ads/elite.png',
    'assets/ads/expert.jpg',
    ];
  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(translation(context).aboutWelcome,
                      style: themeData.textTheme.bodyLarge,
                    ),
                    const SizedBox(
                      height: 33,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: CarouselSlider(
                        options: CarouselOptions(
                          height: 300,
                          autoPlay: true,
                          aspectRatio: 30 / 10, // Standard aspect ratio for product images
                          enlargeCenterPage: true, // Center item is enlarged
                          enlargeStrategy: CenterPageEnlargeStrategy.height, // Enlargement strategy
                          viewportFraction: 0.3 , // Fraction of the viewport occupied by each item
                          initialPage: 1, // Start with the second item to center it initially
                          enableInfiniteScroll: true, // Infinite scroll for continuous browsing
                          autoPlayInterval: const Duration(seconds: 5), // Set auto-play interval
                          autoPlayAnimationDuration: const Duration(milliseconds: 800), // Set auto-play animation duration
                          autoPlayCurve: Curves.easeInOut, // Set auto-play animation curve
                        ),
                        items: imgList.map((item) => Container(
                           // Take full width of the carousel
                          margin: const EdgeInsets.symmetric(horizontal: 8.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0), // Rounded corners for product images
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5), // Shadow color
                                spreadRadius: 2, // Spread radius
                                blurRadius: 5, // Blur radius
                                offset: const Offset(0, 3), // Offset from top left
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Image.asset(
                              item,
                              fit: BoxFit.fill, // Maintain aspect ratio and cover the container
                            ),
                          ),
                        )).toList(),
                      ),
                    ),

                    const SizedBox(height: 22.0),
                    Text(
                      translation(context).aboutMission,
                      style: themeData.textTheme.bodyLarge,
                    ),
                    Text(
                      translation(context).aboutMissionDefinition,
                    ),
                    const SizedBox(height: 22.0),
                    Text(
                      translation(context).aboutProducts,
                      style: themeData.textTheme.bodyLarge,
                    ),
                    Text(
                      translation(context).aboutProductsProvided,
                    ),
                    const SizedBox(height: 22.0),
                    Text(
                      translation(context).aboutChooseUs,
                      style: themeData.textTheme.bodyLarge,
                    ),
                    Text(
                      '- ${translation(context).aboutChooseUsExpertise}',
                    ),
                    Text(
                      '- ${translation(context).aboutChooseUsQuality}',
                    ),
                    Text(
                      '- ${translation(context).aboutChooseUsCustomer}',
                    ),
                    Text(
                      '- ${translation(context).aboutChooseUsConvenience}',
                    ),
                    Text(
                      '- ${translation(context).aboutChooseUsCommunity}',
                    ),
                    SizedBox(height: 20.0),
                    Text(
                      translation(context).aboutGetInTouch,
                      style: themeData.textTheme.bodyLarge,
                    ),
                    Text(
                      translation(context).aboutQuestions,
                    ),
                    SizedBox(
                      height: 33,
                    ),
                  ],
                ),
              ),
            ],
          ),

        ],
      );
  }
}
