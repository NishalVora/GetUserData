import 'package:flutter/material.dart';
import 'widgets/item_list.dart';
import './Screens/wider_image.dart';

void main() => runApp(MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.pink,
          accentColor: Colors.purple,
        ),
        home: ItemList(),
        routes: {
          WiderImage.routeName: (ctx) => WiderImage(),
        }));
