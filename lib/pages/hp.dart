import 'package:flutter/material.dart';
import 'package:json1/Widget/search_widget.dart';
import 'package:json1/model/election.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HPage extends StatefulWidget {
  const HPage({Key? key}) : super(key: key);

  @override
  State<HPage> createState() => _HPageState();
}

class _HPageState extends State<HPage> {
  var url, response;
  List data = [];
  List<Election> electionList = [];
  // List<dynamic> electionList1 = [];
  List<Election> _electionlistToDisplay = [];
  bool _isLoad = true;

  Future<List<Election>> getData() async {
    url = Uri.parse(
        "https://raw.githubusercontent.com/ErKiran/2079-local-election-candidate-list/main/data/candidate_list.json");
    response = await http.get(url);
    data = jsonDecode(response.body);
    // electionList1 = data.map((e) => (Election.fromJson(e)).local).toList();
    setState(() {
      // if (electionList1.contains(["धरान उपमहानगरपालिका"])) {
      electionList = data.map((e) => (Election.fromJson(e))).toList();
      // }

      _isLoad = false;
    });
    return electionList;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getData();
    _electionlistToDisplay = electionList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('hllo'),
          elevation: 0,
        ),
        body: (_isLoad == true)
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: (_electionlistToDisplay.length + 1),
                itemBuilder: (context, index) {
                  return (index == 0) ? _searchbar() : _listItem(index - 1);
                },
              ));
  }

  _searchbar() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        decoration: InputDecoration(hintText: "Search here..."),
        onChanged: (text) {
          text = text.toLowerCase();
          setState(() {
            _electionlistToDisplay = electionList.where((note) {
              var candidateName = note.name;
              return candidateName.contains(text);
            }).toList();
            // return candidateName.
          });
        },
      ),
    );
  }

  _listItem(index) {
    return Card(
      elevation: 5,
      child: ListTile(
          title: Text(_electionlistToDisplay[index].name +
              " (" +
              _electionlistToDisplay[index].Party.toString() +
              " )"),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("पद: " + _electionlistToDisplay[index].Post),
              Text("प्रदेश: " + _electionlistToDisplay[index].Provience),
              Text("जिल्ला: " + _electionlistToDisplay[index].District),
              Text("स्थानीय तह: " + _electionlistToDisplay[index].local),
              Text((_electionlistToDisplay[index].Ward == "")
                  ? "वडा नं: लागु हुँदैन"
                  : "वडा नं:  " + _electionlistToDisplay[index].Ward),
            ],
          )),
    );
  }
}
