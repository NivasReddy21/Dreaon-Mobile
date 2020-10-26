import 'package:edge_alert/edge_alert.dart';
import 'package:flutter/material.dart';

enum AlertType { success, error, warning }

class AlertService {
  void show({
    @required String message,
    @required AlertType type,
    @required BuildContext context,
  }) {
    EdgeAlert.show(
      context,
      title: _chooseTitle(type),
      description: message,
      icon: _chooseIcon(type),
      backgroundColor: _chooseColor(type),
      gravity: EdgeAlert.TOP,
    );
  }

  Color _chooseColor(AlertType type) {
    if (type == AlertType.success) {
      return Colors.green;
    } else if (type == AlertType.error) {
      return Colors.red;
    } else {
      return Colors.orange;
    }
  }

  String _chooseTitle(AlertType type) {
    if (type == AlertType.success) {
      return "Success!!!";
    } else if (type == AlertType.error) {
      return "Error!!!";
    } else {
      return "Warning!!!";
    }
  }

  IconData _chooseIcon(AlertType type) {
    if (type == AlertType.success) {
      return Icons.check_circle_outline;
    } else if (type == AlertType.error) {
      return Icons.error_outline;
    } else {
      return Icons.info_outline;
    }
  }
}
