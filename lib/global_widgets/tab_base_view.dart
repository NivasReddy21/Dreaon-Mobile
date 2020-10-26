import 'package:flutter/material.dart';

import 'header_text.dart';

class TabBaseView extends StatelessWidget {
  final String title;
  final Widget body;

  const TabBaseView({
    Key key,
    @required this.title,
    @required this.body,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _title = Container(
      margin: EdgeInsets.only(top: 30.0, bottom: 10.0),
      child: HeaderText(
        text: title,
      ),
    );

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _title,
          Expanded(
            child: body,
          )
        ],
      ),
    );
  }
}
