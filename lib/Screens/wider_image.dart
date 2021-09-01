import 'package:flutter/material.dart';

class WiderImage extends StatelessWidget {
  static const routeName = 'wider-image';

  @override
  Widget build(BuildContext context) {
    String id = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('WiderView'),
      ),
      body: Column(
        children: <Widget>[
          Image.network(id),
        ],
      ),
    );
  }
}
