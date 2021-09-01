import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../Screens/wider_image.dart';
import 'package:connectivity/connectivity.dart';

class ItemList extends StatefulWidget {
  @override
  _ItemListState createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  List users = [];
  bool isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.fetchUser();
  }

  fetchUser() async {
    setState(() {
      isLoading = !isLoading;
    });

    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      print('Internet disconnected');
      // Mobile is not Connected to Internet
    } else {
      var url = "https://picsum.photos/v2/list?page=1&limit=100";
      var response = await http.get(url);
      // print(response.body);
      if (response.statusCode == 200) {
        var items = json.decode(response.body);
        setState(() {
          users = items;
          // print(users);
          isLoading = false;
        });
      } else {
        users = [];
        isLoading = false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Test"),
      ),
      body: getBody(),
      // body: Text('Getting data'),
    );
  }

  Widget getBody() {
    if (users.contains(null) || users.length < 0 || isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) {
        return getUserData(users[index], context);
      },
    );
  }

  Widget getUserData(item, BuildContext ctx) {
    return Card(
      elevation: 1.0,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(
              item['download_url'],
            ),
          ),
          title: Text(item['author']),
          onTap: () {
            Navigator.of(context).pushNamed(
              WiderImage.routeName,
              arguments: item['download_url'],
            );
          },
        ),
      ),
    );
  }
}
