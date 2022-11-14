// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:frontend/pages/addinsurance.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home();

  @override
  State<Home> createState() => _ProfileState();
}

class _ProfileState extends State<Home> {
  String name = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getInitVals();
  }

  void getInitVals() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString("name") ?? "name";
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Welcome " + name,
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                child: Text(
                  "Add an Insurance",
                  style: TextStyle(fontSize: 16),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddInsurance("General"),
                              ));
                        },
                        child: Column(
                          children: [
                            Image.asset("asset/2.png"),
                            Text("General")
                          ],
                        )),
                  ),
                  Expanded(
                    child: TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddInsurance("Home"),
                              ));
                        },
                        child: Column(
                          children: [Image.asset("asset/3.png"), Text("Home")],
                        )),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddInsurance("Travel"),
                              ));
                        },
                        child: Column(
                          children: [
                            Image.asset("asset/4.png"),
                            Text("Travel")
                          ],
                        )),
                  ),
                  Expanded(
                    child: TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddInsurance("Life"),
                              ));
                        },
                        child: Column(
                          children: [Image.asset("asset/5.png"), Text("Life")],
                        )),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
