import 'package:flutter/material.dart';
import 'package:loja_flutter_app/screens/base/base_screen.dart';
import 'package:loja_flutter_app/screens/login/login_screen.dart';
import 'package:loja_flutter_app/screens/signup/signup_screen.dart';
import 'package:provider/provider.dart';

import 'model/product.dart';
import 'model/product_manager.dart';
import 'model/user_manager.dart';
import 'screens/product/product_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserManager(),
          lazy: false,
        ),
        ChangeNotifierProvider(
            create: (_) => ProductManager(),
            lazy: false,
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
          title: 'Loja Flutter',
          theme: ThemeData(
            //primaryColor: Colors.teal,
            primaryColor: const Color.fromARGB(255, 4, 125, 141),
            visualDensity: VisualDensity.adaptivePlatformDensity,
            scaffoldBackgroundColor: const Color.fromARGB(255, 4, 125, 141),
            //scaffoldBackgroundColor: Colors.teal,
            appBarTheme: const AppBarTheme(
              elevation: 0.0
            ),
          ),
          //home: BaseScreen(),
      initialRoute: '/base',
      onGenerateRoute: (settings){
          switch(settings.name){
            case '/login':
              return MaterialPageRoute(
                builder: (_) => LoginScreen(),
              );
            case '/signup':
              return MaterialPageRoute(
                  builder: (_) => SignupScreen(),
              );
            case '/product':
              return MaterialPageRoute(
                builder: (_) => ProductScreen(
                  settings.arguments as Product
                ),
              );
            case '/base':
            default:
              return MaterialPageRoute(
                  builder: (_) => BaseScreen(),
              );
          }
      },
      ),
    );
  }
}
