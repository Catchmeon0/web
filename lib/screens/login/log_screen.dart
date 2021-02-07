import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:web/widgets/widgets.dart';

import 'log_screen_mobile.dart';

class LogScreen extends StatefulWidget {
  @override
  _LogScreen createState() => _LogScreen();
}

class _LogScreen extends State<LogScreen> {
  final TrackingScrollController _trackingScrollController =
      TrackingScrollController();

  @override
  void dispose() {
    _trackingScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Responsive(
          mobile: AuthThreePageMobile(),
          desktop: AuthThreePageMobile(),
        ),
      ),
    );
  }
}
