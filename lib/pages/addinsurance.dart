// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AddInsurance extends StatefulWidget {
  final String selectedValue;

  const AddInsurance(this.selectedValue, {Key? key}) : super(key: key);
  @override
  State<AddInsurance> createState() => _AddInsuranceState();
}

class _AddInsuranceState extends State<AddInsurance> {
  var items = ["Life", "Home", "General", "Travel"];
  final titleController = TextEditingController();
  final descController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedInsurance = widget.selectedValue;
  }

  String selectedInsurance = "General";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Text("Add an insurance"),
              ),
              Text("Insurance Title"),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: titleController,
                  decoration: InputDecoration(
                    hintText: "Title",
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
              Text("Insurance Description"),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: descController,
                  maxLines: 10,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    hintText: "Description",
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
              DropdownButton(
                value: selectedInsurance,
                items: items.map((String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(items),
                  );
                }).toList(),
                onChanged: (String? value) {
                  setState(() {
                    selectedInsurance = value!;
                  });
                },
              ),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: ElevatedButton(
                      onPressed: () async {
                        final prefs = await SharedPreferences.getInstance();
                        Map payload = {
                          "title": titleController.text,
                          "desc": descController.text,
                          "category": selectedInsurance,
                          "uid": prefs.getString("uid")
                        };
                        var url =
                            Uri.parse(dotenv.env["BASEURL"]! + 'addinsurance');
                        var response = await http.post(url,
                            headers: {"Content-Type": "application/json"},
                            body: json.encode(payload));
                        if (response.statusCode == 200) {
                          Map res = json.decode(response.body);
                          if (res["code"] == "suc") {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                title: Text("Item has been added"),
                                content: Text(
                                    "YAY! Insurance request has been raised"),
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
                      child: Text("Submit"),
                    ),
                  )),
            ]),
          ),
        ),
      ),
    );
  }
}
