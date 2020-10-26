import '../../constants/constants.dart';
import '../../models/message_details.dart';
import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final MessageDetails message;

  const ChatBubble({Key key, this.message}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment:
          message.isFromMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: message.isFromMe
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.6,
            ),
            padding: EdgeInsets.all(15.0),
            child: Text(
              message.content,
              style: TextStyle(
                fontSize: 15.0,
                color: message.isFromMe
                    ? Colors.white
                    : Theme.of(context).textTheme.bodyText1.color.withOpacity(0.5),
                fontWeight: FontWeight.w500,
              ),
            ),
            decoration: BoxDecoration(
              color: message.isFromMe
                  ? null
                  : Theme.of(context).colorScheme.primary,
              gradient: message.isFromMe ? AppConstants.gradient : null,
              borderRadius: message.isFromMe
                  ? BorderRadius.only(
                      topLeft: Radius.circular(15.0),
                      bottomLeft: Radius.circular(15.0),
                      topRight: Radius.circular(15.0),
                    )
                  : BorderRadius.only(
                      topRight: Radius.circular(15.0),
                      topLeft: Radius.circular(15.0),
                      bottomRight: Radius.circular(15.0),
                    ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5.0),
            child: Text(
              message.date,
              style: TextStyle(color: Colors.grey),
            ),
          )
        ],
      ),
    );
  }
}
