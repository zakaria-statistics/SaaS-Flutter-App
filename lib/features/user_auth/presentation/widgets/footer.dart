import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../classes/language.dart';
import '../../../../classes/language_constants.dart';
import '../../../../main.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Footer extends StatefulWidget {
  const Footer({super.key});

  @override
  State<Footer> createState() => _FooterState();
}

class _FooterState extends State<Footer> {
  late String selectedLanguage;

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

Widget buildFooter(BuildContext context) {
  ThemeData themeData = Theme.of(context);
  double screenHeight = MediaQuery.of(context).size.height;
  double screenWidth = MediaQuery.of(context).size.width;
  return Column(
    children: [
      Divider(
        color: Colors.grey,
        thickness: 1,
        height: 1,
      ),
      Container(
        color: Colors.white,
        height: screenHeight * 0.3,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: screenHeight * 0.025),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: screenWidth * 0.111,
              ),
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage("images/graphic_card.png"),
                    radius: 30,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Z-Store',
                    style: TextStyle(
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.bold,
                        fontSize: 28),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Shop',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 33),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Home',
                    style: TextStyle(color: Colors.blue, fontSize: 20),
                  ),
                  Text(
                    'Products',
                    style: TextStyle(color: Colors.blue, fontSize: 20),
                  ),
                  Text(
                    'About',
                    style: TextStyle(color: Colors.blue, fontSize: 20),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Need help?',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 33),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Contact',
                    style: TextStyle(color: Colors.blue, fontSize: 20),
                  ),
                  Text(
                    'Order tracking',
                    style: TextStyle(color: Colors.blue, fontSize: 20),
                  ),
                  Text(
                    'FAQs',
                    style: TextStyle(color: Colors.blue, fontSize: 20),
                  ),
                  Text(
                    'Return policy',
                    style: TextStyle(color: Colors.blue, fontSize: 20),
                  ),
                  Text(
                    'Privacy policy',
                    style: TextStyle(color: Colors.blue, fontSize: 20),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Reach us',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 33),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    '123 Fifth avenue, New York, NY',
                    style: TextStyle(color: Colors.blue, fontSize: 20),
                  ),
                  Text(
                    '10160',
                    style: TextStyle(color: Colors.blue, fontSize: 20),
                  ),
                  Text(
                    'Brands',
                    style: TextStyle(color: Colors.blue, fontSize: 20),
                  ),
                  Text(
                    'contact@info.com',
                    style: TextStyle(color: Colors.blue, fontSize: 20),
                  ),
                  Text(
                    '929-242-6868',
                    style: TextStyle(color: Colors.blue, fontSize: 20),
                  ),
                ],
              ),
              const SizedBox(
                width: 200,
              ),
            ],
          ),
        ),
      ),
      Container(
        height: 100,
        color: Color(0xFF27323F),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 10,
            ),
            Text(
              '© 2024 Electronic Store. Powered by Electronic Store',
              style:
                  TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 15),
            ),
            //Translation
            Row(
              children: [
                Stack(
                  children: [
                    Positioned(
                      child: Text(
                        AppLocalizations.of(context)!.localeName == 'fr' ? 'French' : 'English',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white.withOpacity(0.8)
                        ),
                      ),
                      top: screenHeight * 0.01,
                    ),
                    DropdownButtonHideUnderline(
                      child: DropdownButton<Language>(
                        icon: SvgPicture.asset(
                          AppLocalizations.of(context)!.localeName == 'fr'
                              ? 'assets/svg/fr.svg'
                              : 'assets/svg/us.svg',
                          width: 15,
                          height: 15,
                        ),
                        items: Language.languageList()
                            .map<DropdownMenuItem<Language>>(
                              (e) => DropdownMenuItem<Language>(
                            value: e,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  e.flag,
                                  width: 15,
                                  height: 15,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  e.name,
                                  style: const TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ).toList(),
                        onChanged: (Language? language) async {
                          if (language != null) {
                            Locale locale = await setLocale(language.languageCode);
                            MyApp.setLocale(context, locale);
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),

            Image(image: AssetImage('assets/payment/electronic-store-footer-payment-gateway-icon.png')),
            /*Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        translation(context).homeContactMessage,
                        style: themeData.textTheme.bodyMedium
                      ),
                      const SizedBox(width: 20), // Add spacing between text and icons
                      IconButton(
                        icon: SvgPicture.asset(
                          'assets/svg/phone_icon.svg',
                          // Replace 'linkedin_icon.png' with the correct path to your LinkedIn icon
                          width: 25,
                          height: 25,
                        ),
                        onPressed: () {},
                      ),
                      const SizedBox(width: 20), // Add spacing between icons
                      IconButton(
                        icon: SvgPicture.asset(
                          'assets/svg/gmail_icon.svg',
                          width: 25,
                          height: 25,
                        ),
                        onPressed: () {
                          // Handle GitHub functionality here
                        },
                      ),
                      const SizedBox(width: 20), // Add spacing between icons
                      IconButton(
                        icon: SvgPicture.asset(
                          'assets/svg/maps_icon.svg',
                          width: 25,
                          height: 25,
                        ),
                        onPressed: () {
                          // Handle Gmail functionality here
                        },
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.localeName == 'fr' ? 'French' : 'English',
                        style: themeData.textTheme.bodyMedium,
                    ),
                    DropdownButtonHideUnderline(
                      child: DropdownButton<Language>(
                        icon: SvgPicture.asset(
                          AppLocalizations.of(context)!.localeName == 'fr'
                              ? 'assets/svg/fr.svg'
                              : 'assets/svg/us.svg',
                          width: 15,
                          height: 15,
                        ),
                        items: Language.languageList()
                            .map<DropdownMenuItem<Language>>(
                              (e) => DropdownMenuItem<Language>(
                                value: e,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      e.flag,
                                      width: 15,
                                      height: 15,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      e.name,
                                      style: const TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                            .toList(),
                        onChanged: (Language? language) async {
                          if (language != null) {
                            Locale locale =
                                await setLocale(language.languageCode);
                            MyApp.setLocale(context, locale);
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),*/
            SizedBox(
              width: 10,
            )
          ],
        ),
      ),
    ],
  );
}
