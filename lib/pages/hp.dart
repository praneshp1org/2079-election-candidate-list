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
  List<dynamic> electionList1 = [];
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
                itemCount: (electionList.length),
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                        // if (electionList[index].local=="धरान उपमहानगरपालिका") {
                        //   title: Text(''),
                        // }
                        title: Text(electionList[index].name +
                            " (" +
                            electionList[index].local +
                            " )")),
                  );
                },
              ));
  }
}
