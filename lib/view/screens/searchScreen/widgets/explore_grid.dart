import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class ExploreCard extends StatelessWidget {
  final imageUrl;
   ExploreCard({Key? key, this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Padding(
  padding: const EdgeInsets.all(0.0),
  child:   Card(
    child: Container(height: 500,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),
                      image: DecorationImage(
        image: NetworkImage(imageUrl),
        fit: BoxFit.cover),
      ),
    
      
    
    ),
  ),
);
    
  }
}