import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get/get.dart';
// import 'package:loader_search_bar/loader_search_bar.dart';

import 'package:json1/model/election.dart';
import 'package:json1/pages/wesite.dart';

class NewPage extends StatefulWidget {
  const NewPage({Key? key}) : super(key: key);

  @override
  State<NewPage> createState() => _NewPageState();
}

class _NewPageState extends State<NewPage> {
  TextEditingController controller = new TextEditingController();
  var url, response;
  List data = [];
  List<Election> electionList = [];
  bool _isLoading = true;

  bool _isLight = true;

  Future<List<Election>> getData() async {
    url = Uri.parse(
        "https://raw.githubusercontent.com/praneshp1org/2079-election-candidate-list/master/assets/election.json");
    response = await http.get(url);
    if (response.statusCode == 200) {
      data = jsonDecode(response.body);
      setState(() {
        electionList = data.map((json) => Election.fromJson(json)).toList();
        _isLoading = false;
      });
    } else {
      Get.snackbar("Error!", "Some error occured!");
    }

    return electionList;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
          child: Column(
            children: [
              UserAccountsDrawerHeader(
                  currentAccountPicture: CircleAvatar(
                    backgroundImage: NetworkImage(
                        "https://github.com/praneshp1org/Flutter-Hive-/blob/master/pta.jpg?raw=true"),
                  ),
                  accountName: Text('Developed by:'),
                  accountEmail: Text('Pranesh Tech Apps')),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      (_isLight == false)
                          ? Get.changeTheme(ThemeData.light())
                          : Get.changeTheme(ThemeData.dark());
                    });
                    _isLight = !_isLight;
                  },
                  child: ListTile(
                    title: Text("Change Theme"),
                    leading: Icon(Icons.wb_sunny),
                    trailing: Chip(
                        label: (_isLight == true)
                            ? Text('Light theme')
                            : Text('Dark theme')),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    Get.to(HomePage1());
                  },
                  child: ListTile(
                    title: Text("Official Website"),
                    leading: Icon(Icons.web),
                  ),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: (() {
                        exit(0);
                      }),
                      child: ListTile(
                          title: Text("Quit app"),
                          leading: Icon(Icons.do_disturb_on_rounded)),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        appBar: AppBar(
          title: Text('उम्मेदवारहरूको सूची'),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                  onPressed: () {
                    setState(() {
                      (_isLight == false)
                          ? Get.changeTheme(ThemeData.light())
                          : Get.changeTheme(ThemeData.dark());
                    });
                    _isLight = !_isLight;
                  },
                  icon: Icon(Icons.sunny)),
            )
          ],
        ),
        body: (_isLoading == true)
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 10),
                    Text(
                      "सर्भरबाट data प्राप्त गर्दै! यसले केही समय लिन सक्छ...",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              )
            : ListView.builder(
                itemCount: electionList.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 5,
                    child: ListTile(
                        title: Text(electionList[index].name +
                            " (" +
                            electionList[index].Party.toString() +
                            " )"),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("पद: " + electionList[index].Post),
                            Text("प्रदेश: " + electionList[index].Provience),
                            Text("जिल्ला: " + electionList[index].District),
                            Text("स्थानीय तह: " + electionList[index].local),
                            Text((electionList[index].Ward == "")
                                ? "वडा नं: लागु हुँदैन"
                                : "वडा नं:  " + electionList[index].Ward),
                          ],
                        )),
                  );
                },
              ));
  }
}
