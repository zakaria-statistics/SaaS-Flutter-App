import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_web_app/bloc/cart_bloc/cart_bloc.dart';
import 'package:my_web_app/bloc/theme_bloc.dart';
import 'package:my_web_app/classes/language_constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'bloc/products_bloc.dart';
import 'bloc/routing_bloc.dart';
import 'features/user_auth/presentation/router/routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    print('foo boo');
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyBZZNYh6IHjR1hQsbcJN44C3cYGkiX7tLg",
        appId: "1:895108934473:web:511aa7763d359bf3e94898",
        messagingSenderId: "895108934473",
        projectId: "firstapp-6a3b2",
        // Your web Firebase config options
      ),
    );
    print('boo foo');
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();

  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.setLocale(newLocale);
  }
}

class _MyAppState extends State<MyApp> {
  var auth = FirebaseAuth.instance;
  var isLoggedIn = false;
  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Locale? _locale;

  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  didChangeDependencies() {
    getLocale().then((locale) => setLocale(locale));
    super.didChangeDependencies();
  }

  checkIfLogin() async {
    auth.authStateChanges().listen((User? user) {
      if (user != null && mounted) {
        setState(() {
          isLoggedIn = true;
        });
      }
    });
  }
// git test
  @override
  void initState() {
    checkIfLogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        /*Provider(
          create: (_) => ProductRepository(),
        ),
        ProxyProvider<ProductRepository, ProductService>(
          update: (_, productRepository, __) =>
              ProductService(productRepository),
        ),*/
        BlocProvider(
          create: (context) => ProductBloc(),
        ),
        BlocProvider(
          create: (context) => RoutingBloc(),
        ),
        BlocProvider(
          create: (context) => ThemeBloc(),
        ),
        BlocProvider(
          create: (context) => CartBloc(),
        ),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return MaterialApp.router(
            routerConfig: MyRouter.router,
            debugShowCheckedModeBanner: false,
            theme: state.themeData,
            title: 'ZITECH',
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            locale: _locale,
          );
        },
      ),
    );
  }
}
