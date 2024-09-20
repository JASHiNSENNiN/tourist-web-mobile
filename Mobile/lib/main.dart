import 'package:flutter/material.dart';
import 'package:flutter_application_2/providers/user_provider.dart';
import 'package:flutter_application_2/screens/login_page.dart';
import 'package:flutter_application_2/screens/profile_account.dart'; // Make sure to import other screens
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => UserProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Auth',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      // Define your routes here
      home: const LoginPage(),
      initialRoute: '/login_page',
      routes: {
        '/login_page': (context) => const LoginPage(),
        '/profile_account': (context) => const ProfileAccountPage(),
        // Add other routes here as needed
      },
      // Optionally define onUnknownRoute if you want to handle unknown routes
      // onUnknownRoute: (settings) {
      //   return MaterialPageRoute(builder: (context) => const UnknownPage());
      // },
    );
  }
}
