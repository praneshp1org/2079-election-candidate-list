import 'package:flutter/material.dart';
import 'package:json1/model/district.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //fields
  var url, response;
  List data = [];
  List<District> districtList = [];
  bool _isLoading = true;

  Future<List<District>> getDistrict() async {
    url = Uri.parse("https://data.askbhunte.com/api/v1/districts");
    response = await http.get(url);
    data = jsonDecode(response.body);

    setState(() {
      districtList = data.map((json) => District.fromJson(json)).toList();
      _isLoading = false;
    });
    return districtList;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDistrict();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('JSON Serialization'),
        ),
        body: (_isLoading == true)
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: districtList.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(districtList[index].title_en +
                          " (" +
                          districtList[index].title_ne +
                          " )"),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(districtList[index]
                                  .centroid
                                  .coordinates[0]
                                  .toString() +
                              " / " +
                              districtList[index]
                                  .centroid
                                  .coordinates[1]
                                  .toString()),
                          Text("LNG: " +
                              districtList[index].bbox[0].toString() +
                              " / " +
                              districtList[index].bbox[2].toString()),
                          Text("LAT: " +
                              districtList[index].bbox[1].toString() +
                              " / " +
                              districtList[index].bbox[3].toString()),
                        ],
                      ),
                    ),
                  );
                },
              ));
  }
}
