import 'package:flutter/material.dart';
import 'package:flutter_json_app/Data_Model.dart';

class Details extends StatefulWidget {
  Data data;
  Details(this.data);

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details Page'),
      ),
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  widget.data.url,
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: CircleAvatar(
                          child: Text(widget.data.id.toString()),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(widget.data.title),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
