import 'package:flutter/material.dart';
import 'package:rixa/state_widgets/rixa_builder.dart';

import '../main.dart';

class PageControlPanel extends StatefulWidget {
  final Widget child;
  const PageControlPanel({Key? key, required this.child}) : super(key: key);

  @override
  State<PageControlPanel> createState() => _PageControlPanelState();
}

class _PageControlPanelState extends State<PageControlPanel> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RixaBuilder(
      builder: (properties, fonts) {
        return Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: appColors.backgroundColor,
          appBar: AppBar(),
          body: Center(child: widget.child),
        );
      },
    );
  }
}
