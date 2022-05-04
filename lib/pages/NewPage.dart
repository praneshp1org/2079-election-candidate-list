import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get/get.dart';
// import 'package:loader_search_bar/loader_search_bar.dart';

import 'package:json1/model/election.dart';

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
  String? _result;
  // List _items = [];
  // Future<void> readJson() async {
  //   final String response = await rootBundle.loadString('assets/election.json');
  //   final data = await json.decode(response);
  //   setState(() {
  //     _items = data["Candidate"];
  //     _isLoading = false;
  //   });
  // }

  // Future<void> readJson() async {
  //   response = await rootBundle.load("assets/election.json");
  //   data = await json.decode(response.body);
  //   setState(() {
  //     electionList = data.map((json) => Election.fromJson(json)).toList();
  //     _isLoading = false;
  //   });
  // }

  Future<List<Election>> getData() async {
    url = Uri.parse(
        "https://raw.githubusercontent.com/ErKiran/2079-local-election-candidate-list/main/data/candidate_list.json");
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
        appBar: AppBar(
          title: Text('उम्मेदवारहरूको सूची'),
        ),
        body: (_isLoading == true)
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: electionList.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                        title: Text(electionList[index].name +
                            " (" +
                            electionList[index].Party.toString() +
                            " )"),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("पोस्ट: " + electionList[index].Post),
                            Text("प्रदेश: " + electionList[index].Provience),
                            Text("जिल्ला: " + electionList[index].District),
                            Text("स्थानीय तह: " + electionList[index].local),
                            Text((electionList[index].Ward == "")
                                ? "वार्ड नं: लागु हुँदैन"
                                : "वार्ड नं:  " + electionList[index].Ward),
                          ],
                        )),
                  );
                },
              ));
  }
}
