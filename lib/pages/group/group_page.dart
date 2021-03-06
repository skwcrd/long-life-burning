
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import './create_group.dart';
import './detail.dart';

class GroupPage extends StatefulWidget {
  GroupPage({ Key key }) : super(key: key);
  static const String routeName = '/';
  @override
  _GroupPageState createState() => _GroupPageState();
}

class MyData {
  String id, groupname, location, time , category,date;
  List users;
  Animation animation;
  AnimationController controller;
  final GlobalKey<dynamic> key = GlobalKey();
  int state = 0;
  bool isPressed = false, animatingReveal = false;
  MyData(this.id, this.groupname, this.location, this.time, this.category, this.users, this.date);
}

class _GroupPageState extends State<GroupPage> {
      List<MyData> allData = [];

      @override
      Widget build(BuildContext context) {
        return Scaffold(
          resizeToAvoidBottomInset: true,
          resizeToAvoidBottomPadding: true,
          backgroundColor: Colors.white,
          appBar: AppBar(
            brightness: Brightness.dark,
            backgroundColor: Colors.blueAccent,
            title: Text(
              'Group',
              style: TextStyle(
                color: Colors.white,
                fontSize: 36.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.add),
                color: Colors.white,
                onPressed: () =>
                    Navigator.of(context).pushNamed(CreateGroup.routeName),
              ),
            ],
          ),
          body: StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance.collection('group').snapshots(),
            builder: (_, snapshot) {
              if (!snapshot.hasData) {
                return CircularProgressIndicator();
              }
              allData.clear();
              snapshot.data.documents.forEach((doc) {
                var d = doc.data['date'] != null ? DateTime.fromMicrosecondsSinceEpoch(doc.data['date']?.microsecondsSinceEpoch) : null;
                MyData data = new MyData(
                  doc.documentID,
                  doc.data['groupname'],
                  doc.data['location'],
                  doc.data['time'],
                  doc.data['category'],
                  doc.data['users'],
                  "${d?.day?.toString()?.padLeft(2,"0") ?? "XX"}-${d?.month?.toString()?.padLeft(2,"0") ?? "XX"}-${d?.year ?? "XXXX"}",
                );
                allData.add(data);
              });
              return allData.length == 0 ? Column(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: <Widget>[
           new Text(
              "No Data available",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ]) : 
              new ListView.builder(
                itemCount: allData.length,
                itemBuilder: (_, index)
                {
                  return ListData(
                    data: allData[index],
                    contexts: context,
                  );
                }
              );
            },
          ),
          );
      }
}

class ListData extends StatefulWidget {
  final MyData data;
  final BuildContext contexts;
  ListData({
    this.data,
    this.contexts,
  });
  @override
  _ListDataState createState() => _ListDataState();
  void callback() {}
}

class _ListDataState extends State<ListData> with TickerProviderStateMixin {
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(widget.contexts).pushNamed(
                DetailGroup.routeName,
                arguments: {
                  "id": widget.data.id,
                  "groupname": widget.data.groupname,
                  "category": widget.data.category,
                  "location": widget.data.location,
                  "time": widget.data.time,
                  "date": widget.data.date,
                  "users": widget.data.users,
                }
                ),
      child: new Card(
        elevation: 10.0,
        margin: EdgeInsets.all(15.0),
        child: new Container(
          padding: new EdgeInsets.all(14.0),
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                    new Text
              (widget.data.groupname ?? "",style: Theme.of(context).textTheme.subtitle,
              textAlign:TextAlign.center,
              ),
              new Text
              (widget.data.time ?? "",style: Theme.of(context).textTheme.subtitle,
              textAlign:TextAlign.center,
              ),
                 ],
              ),
              SizedBox(height: 10.0,),
              //     new Text
              // (widget.data.category ?? "",style: Theme.of(context).textTheme.subtitle,
              // textAlign:TextAlign.start,
              // ),
              new Text
                (widget.data.location ?? "",style: Theme.of(context).textTheme.subtitle,
              textAlign:TextAlign.start
              ),
            ],
          ),
        ),
      ),
    );
  }
}

