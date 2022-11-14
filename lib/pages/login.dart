// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/pages/app.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login();

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Insurancify",
                  style: TextStyle(fontSize: 50, fontWeight: FontWeight.w900),
                ),
                Text(
                  "Getting insured isnt rocket science",
                  style: TextStyle(fontSize: 20),
                ),
                Image.asset("asset/login-1.png"),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: usernameController,
                    decoration: InputDecoration(
                      hintText: "Username",
                      contentPadding: EdgeInsets.all(14),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: "Password",
                      contentPadding: EdgeInsets.all(14),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () async {
                          Map payload = {
                            "username": usernameController.text,
                            "password": passwordController.text
                          };
                          var url = Uri.parse(dotenv.env["BASEURL"]! + 'login');
                          var response = await http.post(url,
                              headers: {"Content-Type": "application/json"},
                              body: json.encode(payload));
                          if (response.statusCode == 200) {
                            Map res = json.decode(response.body);
                            if (res["code"] == "suc") {
                              final prefs =
                                  await SharedPreferences.getInstance();
                              prefs.setString("name", res["name"].toString());
                              prefs.setString(
                                  "username", usernameController.text);
                              prefs.setString("uid", res["uid"].toString());
                              prefs.setString(
                                  "password", passwordController.text);

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const App()),
                              );
                            } else {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  title: Text("Unable to auth"),
                                  content:
                                      Text(res["message"] ?? "Unable to auth"),
                                  actions: [
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context, 'OK'),
                                      child: const Text('OK'),
                                    ),
                                  ],
                                ),
                              );
                            }
                          }
                        },
                        child: Text("Login"),
                        style: ElevatedButton.styleFrom(
                            primary: Color.fromARGB(255, 0, 103, 108)),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text("Not New here?"),
                      TextButton(
                          onPressed: () {}, child: Text("Signup instead")),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      )),
    );
  }
}
