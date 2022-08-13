import 'package:cached_network_image/cached_network_image.dart';
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
      child: Card(
        child: CachedNetworkImage(
          height: 500,
          imageUrl: imageUrl,
          imageBuilder: (context, imageProvider) => Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
                // colorFilter: ColorFilter.mode(
                //     Colors.black, BlendMode.colorBurn)
              ),
            ),
          ),
          placeholder: (context, url) =>
           Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                        'lib/model/assets/placeholder_for_homepost.jpg'),
                    fit: BoxFit.cover)),
          ),
          errorWidget: (context, url, error) => const Icon(
            Icons.error,
            size: 30,
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}
