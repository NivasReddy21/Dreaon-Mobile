import '../../config/extensions.dart';
import '../../constants/data.dart';
import '../../global_widgets/custom_form_field_alt.dart';
import '../../views/live_tv/widgets/live_tv_tile.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';

class LiveTvPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final liveTvs = AppData().liveTvs;

    final input = Container(
      margin: EdgeInsets.only(top: 2.0, bottom: 10.0),
      child: CustomFormFieldAlt(
        hintText: "Search Live TV creators",
        icon: LineAwesomeIcons.search,
        bottomPadding: 5,
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Live TV",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 15.0),
        child: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate(
                [input],
              ),
            ),
            SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
                childAspectRatio: 0.7,
              ),
              delegate: SliverChildBuilderDelegate(
                (
                  BuildContext context,
                  int index,
                ) {
                  return LiveTvTile(
                    liveTv: liveTvs[index],
                  ).fadeInList(index, false);
                },
                 childCount: liveTvs.length,
              ),
            ),
             SliverList(
              delegate: SliverChildListDelegate(
                [SizedBox(height: 20.0)],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
