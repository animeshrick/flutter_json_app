import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_json_app/DetailsPage.dart';
import 'package:http/http.dart' as http;

import 'Data_Model.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //Color color = {Colors.red, Colors.blue, Colors.black, Colors.pink};

  Future<List<Data>> getAllData() async {
    var api = 'http://jsonplaceholder.typicode.com/photos';
    var data = await http.get(api);
    var jsonData = json.decode(data.body);
    List<Data> listOf = [];
    for (var i in jsonData) {
      Data data = Data(i["id"], i["title"], i["url"], i["thumbnailUrl"]);
      listOf.add(data);
    }
    return listOf;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
          child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountEmail: Text("email"),
            accountName: Text('name'),
            decoration: BoxDecoration(color: Colors.brown),
          ),
          ListTile(
            title: Text('First Page'),
            leading: Icon(
              Icons.search,
              color: Colors.green,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('Second Page'),
            leading: Icon(
              Icons.add,
              color: Colors.black,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('Third Page'),
            leading: Icon(
              Icons.grain,
              color: Colors.pink,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('Fourth Page'),
            leading: Icon(
              Icons.fiber_manual_record,
              color: Colors.lightBlue,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('Fifth Page'),
            leading: Icon(
              Icons.network_check,
              color: Colors.redAccent,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          Divider(
            color: Colors.red,
            thickness: 5.0,
            height: 10,
          ),
          ListTile(
            title: Text('Close'),
            leading: Icon(
              Icons.close,
              color: Colors.redAccent,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      )),
      appBar: AppBar(
        title: Text("Json App"),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: null,
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: null,
          )
        ],
      ),
      body: ListView(
        children: [
          Container(
            height: 250,
            margin: EdgeInsets.all(10),
            child: FutureBuilder(
              future: getAllData(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.pink,
                    ),
                  );
                } else {
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        elevation: 10,
                        child: Column(
                          children: [
                            Image.network(
                              snapshot.data[index].url,
                              height: 150,
                              width: 150,
                              fit: BoxFit.cover,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              margin: EdgeInsets.all(10),
                              height: 50,
                              child: Row(
                                children: [
                                  Container(
                                    child: CircleAvatar(
                                      backgroundColor: Colors.grey,
                                      child: Text(
                                          snapshot.data[index].id.toString()),
                                      foregroundColor: Colors.black,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Container(
                                    width: 100,
                                    child: Text(
                                      snapshot.data[index].title,
                                      maxLines: 1,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
              margin: EdgeInsets.all(10),
              height: MediaQuery.of(context).size.height,
              child: FutureBuilder(
                future: getAllData(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      if (snapshot.data == null) {
                        return CircularProgressIndicator(
                          backgroundColor: Colors.pink,
                        );
                      } else {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        Details(snapshot.data[index])));
                          },
                          child: Card(
                            elevation: 7,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Image.network(
                                    snapshot.data[index].thumbnailUrl,
                                    height: 50,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                  width: 5,
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    snapshot.data[index].title,
                                    maxLines: 1,
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: CircleAvatar(
                                      backgroundColor: Colors.black,
                                      child: Text(
                                        snapshot.data[index].id.toString(),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                    },
                  );
                },
              )),
        ],
      ),
    );
  }
}
