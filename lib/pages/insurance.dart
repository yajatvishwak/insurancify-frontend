// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Insurance extends StatefulWidget {
  const Insurance();

  @override
  State<Insurance> createState() => _InsuranceState();
}

class _InsuranceState extends State<Insurance> {
  List<dynamic> items = [
    {
      "title": "this is an insurance...",
      "status": "pending",
    }
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchinsurance();
  }

  void fetchinsurance() async {
    final prefs = await SharedPreferences.getInstance();
    Map payload = {"uid": prefs.getString("uid")};
    var url = Uri.parse(dotenv.env["BASEURL"]! + 'getdeetsforhomepage');
    var response = await http.post(url,
        headers: {"Content-Type": "application/json"},
        body: json.encode(payload));
    if (response.statusCode == 200) {
      Map res = json.decode(response.body);
      if (res["code"] == "suc") {
        setState(() {
          items = res["items"];
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Text(
              "Your Previous Insurance",
              style: TextStyle(fontSize: 21, fontWeight: FontWeight.w600),
            ),
          ),
          ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            padding: const EdgeInsets.all(10),
            itemCount: items.length,
            itemBuilder: (_, index) {
              String tit = items[index]["title"] ?? "";
              String status = items[index]["status"] ?? "";
              return ListTile(
                title: Text(tit),
                subtitle: Text(status),
                trailing: IconButton(
                    onPressed: () {}, icon: Icon(Icons.access_alarms_rounded)),
              );
            },

            // ignore: prefer_const_literals_to_create_immutables
          ),
        ],
      ),
    );
  }
}
