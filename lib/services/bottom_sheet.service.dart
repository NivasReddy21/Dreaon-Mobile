import '../global_widgets/bottom_sheets/share.bottom_sheet.dart';
import 'package:flutter/material.dart';

class BottomSheetService {
  Future show({
    @required BuildContext context,
    @required Widget body,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return body;
      },
    );
  }

  Future showShare({
    @required BuildContext context,
  }) {
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return ShareBottomSheet();
      },
    );
  }
}
