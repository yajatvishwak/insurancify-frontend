import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:frontend/pages/app.dart';
import 'package:frontend/pages/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future main() async {
  // To load the .env file contents into dotenv.
  // NOTE: fileName defaults to .env and can be omitted in this case.
  // Ensure that the filename corresponds to the path in step 1 and 2.
  await dotenv.load(fileName: ".env");
  SharedPreferences.setMockInitialValues({});
  runApp(const MyApp());

  //...runapp
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        "/login": ((context) => const Login()),
        "/": ((context) => const App()),
      },
      initialRoute: "/login",
    );
  }
}
