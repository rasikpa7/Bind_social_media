import 'package:bind/view/screens/screenwidgets/explore_grid.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent,
        title: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(padding: EdgeInsets.all(8),
            color: Colors.grey[500],
            child: Row(
              children: [
                Icon(Icons.search),
                Container(color: Colors.grey[500],
                child: Text('Search'),)
              ],
            ),
          ),
        ),
      ),
      body: ExploreGrid(),
    );

  }
}