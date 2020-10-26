import '../../constants/data.dart';
import '../../constants/images.dart';
import '../../global_widgets/custom_form_field_alt.dart';
import '../../global_widgets/empty_state.dart';
import '../../models/user.dart';
import '../../config/extensions.dart';

import '../../global_widgets/header_text.dart';
import 'package:flutter/material.dart';

import 'widgets/user_search_tile.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<User> users = AppData.users.where((e) => e.id != '').toList();
  List<User> filteredUsers = AppData.users.where((e) => e.id != '').toList();
  TextEditingController controller = TextEditingController();
  FocusNode inputFocusNode = FocusNode();

  @override
  void initState() {
    filteredUsers = users;
    filteredUsers.shuffle();

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  onSearch(String value) {
    if (value.length == 0 || value.length == 1) {
      setState(() {});
    }
    setState(() {
      filteredUsers = users
          .where(
            (data) => (data.name.toLowerCase().contains(value.toLowerCase())),
          )
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final header = HeaderText(text: "Search");

    final searchBar = CustomFormFieldAlt(
      focusNode: inputFocusNode,
      icon: Icons.search,
      hintText: "Search",
      onChanged: onSearch,
      controller: controller,
      suffixIcon: controller.text.length == 0
          ? null
          : GestureDetector(
              child: Icon(
                Icons.close,
                color: Colors.grey,
              ),
              onTap: () {
                controller.clear();
                inputFocusNode.unfocus();
                setState(() {
                  filteredUsers = users;
                });
              },
            ),
    );

    final list = Expanded(
      child: Container(
        child: ListView.separated(
          itemCount: filteredUsers.length,
          itemBuilder: (BuildContext context, int index) {
            return UserSearchTile(
              user: filteredUsers[index],
            ).fadeInList(index, true);
          },
          separatorBuilder: (BuildContext context, int index) {
            return Divider(
              thickness: 1,
            );
          },
        ),
      ),
    );

    final emptyState = EmptyState(
      image: AppImages.notFound,
      message: "Sorry, User not found",
    );

    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(Icons.close),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            header,
            searchBar,
            filteredUsers.length == 0 ? emptyState : list
          ],
        ),
      ),
    );
  }
}
