import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../model/message_model.dart';

class MessageWidget extends StatelessWidget {
  final Message message;
   bool isMe;
   
   final userImageUrl;

   MessageWidget({required this.userImageUrl,
    required this.message,
     required this.isMe,
  });

  @override
  Widget build(BuildContext context) {
    final radius = Radius.circular(12.r);
    final borderRadius = BorderRadius.all(radius);

    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: <Widget>[
        // if (!isMe)
        //   CircleAvatar(
        //       radius: 16, backgroundImage: NetworkImage(message.recieverAvatarUrl)),
        Container( 
          padding: EdgeInsets.all(16.r),
          margin: EdgeInsets.all(16.r),
          constraints: BoxConstraints(maxWidth: 140.w),
          decoration: BoxDecoration(
            color: isMe ? Color.fromARGB(255, 38, 239, 128) : 
            Theme.of(context).accentColor,
            borderRadius: isMe
                ? borderRadius.subtract(BorderRadius.only(bottomRight: radius))
                : borderRadius.subtract(BorderRadius.only(bottomLeft: radius)),
          ),
          child: buildMessage(),
        ),
      ],
    );
  }

  Widget buildMessage() => Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            message.message,
            style: TextStyle(color: isMe ? Colors.black : Colors.white),
            textAlign: isMe ? TextAlign.end : TextAlign.start,
          ),
        ],
      );
}