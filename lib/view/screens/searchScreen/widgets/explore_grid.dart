import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExploreCard extends StatelessWidget {
  final imageUrl;
  ExploreCard({Key? key, this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.all(0.0.r),
      child: Card(
        child: CachedNetworkImage(
          height: 500.h,
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
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                        'lib/model/assets/placeholder_for_homepost.jpg'),
                    fit: BoxFit.cover)),
          ),
          errorWidget: (context, url, error) =>  Icon(
            Icons.error,
            size: 30.sp,
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}
